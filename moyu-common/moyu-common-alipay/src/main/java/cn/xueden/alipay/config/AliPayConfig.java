package cn.xueden.alipay.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

/**功能描述：支付宝支付配置类
 * @Auther:梁志杰
 * @Date:2021/5/16
 * @Description:cn.xueden.config
 * @version:1.0
 */
@Component
@Configuration
@ConfigurationProperties(prefix = "alipay")
@Data
public class AliPayConfig {

    // 请求协议 https或 http
    private String protocol;

    // 网关
    private String gatewayHost;

    // 签名
    private String signType;

    //应用appId
    private String appId;

    // 私钥
    private String merchantPrivateKey;

    // 应用公钥证书文件路径
    private String merchantCertPath;

    // 支付宝公钥证书文件路径
    private String alipayCertPath;

    // 支付宝根证书文件路径
    private String alipayRootCertPath;

    // 购买VIP支付类接口异步通知接收服务地址，例如：https://www.test.com/callback
    private String notifyVipUrl;

    // 购买课程接口异步通知接收服务地址
    private String notifyCourseUrl;

    // 设置AES密钥，调用AES加解密相关接口时需要（可选） 请填写您的AES密钥，例如：aa4BtZ4tspm2wnXLb1ThQA
    private String encryptKey;

}
