package cn.xueden.wechat.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

/**功能描述：微信支付配置文件
 * @Auther:梁志杰
 * @Date:2021/5/21
 * @Description:cn.xueden.wechat.config
 * @version:1.0
 */
@Component
@Configuration
@ConfigurationProperties(prefix = "wechatpay")
@Data
public class WechatConfig {

    // 商户号
    private String  mchId;

    // 微信公众平台服务号appId
    private String  appId;

    //  v3接口 CA证书 apiclient_key.pem私钥内容
    private String  privateKey;

    //  wechatpay.pem证书内容 必填  填写classpath路径 位于 maven项目的resources文件下
    private String wechatpaykey;

    //  商户证书序列号 CA证书 可查看微信商户平台-账户设置-安全设置-api安全密钥
    private String  mcHserialNo;

    // native支付请求接口
    private String nativeV3Api;

    // 购买课程异步回调通知
    private String notifyCourseUrl;

    // 购买VIP会员异步回调通知
    private String notifyVipUrl;

    //APIv3密钥 【微信商户平台—>账户设置—>API安全—>设置APIv3密钥】
    private String aPIv3key;
}
