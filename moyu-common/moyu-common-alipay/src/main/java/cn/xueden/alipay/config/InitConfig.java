package cn.xueden.alipay.config;


import com.alipay.easysdk.factory.Factory;
import com.alipay.easysdk.kernel.Config;
import lombok.extern.slf4j.Slf4j;
import cn.xueden.alipay.utils.StringUtils;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import java.io.File;

/**功能描述：设置全局配置
 * @Auther:梁志杰
 * @Date:2021/5/16
 * @Description:cn.xueden.config
 * @version:1.0
 */
@Component
@Slf4j
public class InitConfig implements InitializingBean {

    private final AliPayConfig aliPayConfig;

    public InitConfig(AliPayConfig aliPayConfig) {
        this.aliPayConfig = aliPayConfig;
    }

    /**
     * 全局配置
     * @throws Exception
     */
    @Override
    public void afterPropertiesSet() throws Exception {
        log.info("开始支付宝全局配置---------------------------");
        Config config = new Config();
        config.protocol = aliPayConfig.getProtocol();
        config.gatewayHost = aliPayConfig.getGatewayHost();
        config.signType = aliPayConfig.getSignType();
        config.appId = aliPayConfig.getAppId();
        config.merchantPrivateKey = StringUtils.readFileOfTxt(new File(new File(aliPayConfig.getMerchantPrivateKey()).getPath()));;

        config.merchantCertPath = aliPayConfig.getMerchantCertPath();
        config.alipayCertPath = aliPayConfig.getAlipayCertPath();
        config.alipayRootCertPath = aliPayConfig.getAlipayRootCertPath();
        config.notifyUrl = aliPayConfig.getNotifyCourseUrl();
        Factory.setOptions(config);
        log.info("结束支付宝全局配置-------------------------");
    }
}
