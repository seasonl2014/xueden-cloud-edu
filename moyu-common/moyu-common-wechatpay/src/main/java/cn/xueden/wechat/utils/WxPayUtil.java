package cn.xueden.wechat.utils;

import com.wechat.pay.contrib.apache.httpclient.WechatPayHttpClientBuilder;
import com.wechat.pay.contrib.apache.httpclient.util.PemUtil;
import com.yungouos.pay.wxpay.WxPay;
import org.apache.http.impl.client.CloseableHttpClient;
import org.springframework.stereotype.Component;

import java.io.FileInputStream;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.List;

/**功能描述：第三方服务商的微信支付
 * @Auther:梁志杰
 * @Date:2021/2/9
 * @Description:cn.xueden.wechat.utils
 * @version:1.0
 */
@Component
public class WxPayUtil {
    /**
     * 微信扫码支付
     * @return
     */
    public static String nativePay(String orderNo,String totalFee,String remark,String notifyUrl){

        String code =  WxPay.nativePay(orderNo,
                totalFee,
                ConstantPropertiesUtil.YUNGOUOSWECHATMCHID,
                remark,"1",
                null,notifyUrl,
                null,null,
                "0",null,ConstantPropertiesUtil.YUNGOUOSKEY);

        System.out.println("返回支付信息："+code);
        return code;

    }

    /**
     *
     * @param merchantId
     *          商户id
     * @param merchantSerialNumber
     *         商户证书序列号
     * @param privateKeyFilePath
     *        商户私钥PrivateKey实例
     * @param wechatpayCertificatePath
     *        平微信支付平台证书的X509Certificate实例列表
     * @return
     * @throws Exception
     */
    public static CloseableHttpClient getClient(String merchantId, String merchantSerialNumber, String privateKeyFilePath, String wechatpayCertificatePath) throws Exception {
        WechatPayHttpClientBuilder builder = WechatPayHttpClientBuilder.create()
                .withMerchant(merchantId, merchantSerialNumber, PemUtil.loadPrivateKey(new FileInputStream(privateKeyFilePath)));

        List<X509Certificate> certs = new ArrayList<>();
        certs.add(PemUtil.loadCertificate(new FileInputStream(wechatpayCertificatePath)));
        builder.withWechatpay(certs);
        return builder.build();
    }
}

