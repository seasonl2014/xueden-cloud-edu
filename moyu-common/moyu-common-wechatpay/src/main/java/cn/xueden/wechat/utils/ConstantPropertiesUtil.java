package cn.xueden.wechat.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**功能描述：微信支付配置信息
 * @Auther:梁志杰
 * @Date:2021/2/9
 * @Description:cn.xueden.wechat.utils
 * @version:1.0
 */
@Component
public class ConstantPropertiesUtil implements InitializingBean {

    private static final Logger LOGGER = LoggerFactory.getLogger(ConstantPropertiesUtil.class);

    // YunGouOS平台微信商户号
    @Value("${yungouos.wechat.mchid}")
    private String wechatmchid;

    // YunGouOS平台密钥
    @Value("${yungouos.wechat.key}")
    private String wechatkey;

    // YunGouOS平台购买课程支付结束后返回地址
    @Value("${yungouos.wechat.returnurlcourse}")
    private String returnurlcourse;

    // YunGouOS平台购买VIP支付结束后返回地址
    @Value("${yungouos.wechat.returnurlvip}")
    private String returnurlvip;


    //定义常量
    public static String YUNGOUOSWECHATMCHID;

    public static String YUNGOUOSKEY;

    public static  String YUNGOUORETURNURLCOURSE;

    public static  String YUNGOUORETURNURLVIP;

    @Override
    public void afterPropertiesSet() throws Exception {
        YUNGOUOSWECHATMCHID = wechatmchid;
        YUNGOUOSKEY = wechatkey;
        YUNGOUORETURNURLCOURSE = returnurlcourse;
        YUNGOUORETURNURLVIP = returnurlvip;
        LOGGER.info("----------完成初始化微信支付配置信息---------{}");
    }

}
