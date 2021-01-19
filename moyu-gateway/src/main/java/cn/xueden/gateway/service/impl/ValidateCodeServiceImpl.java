package cn.xueden.gateway.service.impl;

import cn.xueden.common.core.constant.Constants;
import cn.xueden.common.core.exception.CaptchaException;
import cn.xueden.common.core.utils.IdUtils;
import cn.xueden.common.core.utils.XudenStringUtils;
import cn.xueden.common.core.utils.sign.Base64;
import cn.xueden.common.core.web.domain.AjaxResult;
import cn.xueden.common.redis.service.RedisService;
import cn.xueden.gateway.service.IValidateCodeService;
import com.alibaba.csp.sentinel.annotation.SentinelResource;
import com.google.code.kaptcha.Producer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FastByteArrayOutputStream;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.concurrent.TimeUnit;

/**功能描述：验证码实现处理类
 * @Auther:梁志杰
 * @Date:2020/9/25
 * @Description:cn.xueden.gateway.service.impl
 * @version:1.0
 */
@Service
public class ValidateCodeServiceImpl implements IValidateCodeService {

    @Resource(name = "captchaProducer")
    private Producer captchaProducer;

    @Resource(name = "captchaProducerMath")
    private Producer captchaProducerMath;

    @Autowired
    private RedisService redisService;

    // 验证码类型
    private String captchaType = "math";

    /**
     * 生成验证码
     */
    @Override
    /*@SentinelResource(value = "createCapcha")*/
    public AjaxResult createCapcha() throws IOException, CaptchaException {
        // 保存验证码信息
        String uuid = IdUtils.simpleUUID();
        String verifyKey = Constants.CAPTCHA_CODE_KEY + uuid;

        String capStr = null, code = null;
        BufferedImage image = null;

        // 生成验证码
        if ("math".equals(captchaType))
        {
            String capText = captchaProducerMath.createText();
            capStr = capText.substring(0, capText.lastIndexOf("@"));
            code = capText.substring(capText.lastIndexOf("@") + 1);
            image = captchaProducerMath.createImage(capStr);
        }
        else if ("char".equals(captchaType))
        {
            capStr = code = captchaProducer.createText();
            image = captchaProducer.createImage(capStr);
        }

        redisService.setCacheObject(verifyKey, code, Constants.CAPTCHA_EXPIRATION, TimeUnit.MINUTES);
        // 转换流信息写出
        FastByteArrayOutputStream os = new FastByteArrayOutputStream();
        try
        {
            ImageIO.write(image, "jpg", os);
        }
        catch (IOException e)
        {
            return AjaxResult.error(e.getMessage());
        }

        AjaxResult ajax = AjaxResult.success();
        ajax.put("uuid", uuid);
        ajax.put("img", Base64.encode(os.toByteArray()));
        return ajax;
    }

    /**
     * 校验验证码
     */
    @Override
    public void checkCapcha(String code, String uuid) throws CaptchaException{
        if (XudenStringUtils.isEmpty(code))
        {
            throw new CaptchaException("验证码不能为空");
        }
        if (XudenStringUtils.isEmpty(uuid))
        {
            throw new CaptchaException("验证码已失效");
        }
        String verifyKey = Constants.CAPTCHA_CODE_KEY + uuid;
        String captcha = redisService.getCacheObject(verifyKey);
        redisService.deleteObject(verifyKey);

        if (!code.equalsIgnoreCase(captcha))
        {
            throw new CaptchaException("验证码错误");
        }
    }


}
