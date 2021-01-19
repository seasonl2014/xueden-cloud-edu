package cn.xueden.gateway.service;

import cn.xueden.common.core.exception.CaptchaException;
import cn.xueden.common.core.web.domain.AjaxResult;

import java.io.IOException;

/**功能描述：验证码处理接口
 * @Auther:梁志杰
 * @Date:2020/9/25
 * @Description:cn.xueden.gateway.service
 * @version:1.0
 */
public interface IValidateCodeService {

    /**
     * 生成验证码
     */
    public AjaxResult createCapcha() throws IOException, CaptchaException;

    /**
     * 校验验证码
     */
    public void checkCapcha(String key, String value) throws CaptchaException;

}
