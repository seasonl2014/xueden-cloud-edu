package cn.xueden.alipay.service;


import com.alipay.easysdk.factory.Factory;
import com.alipay.easysdk.kernel.util.ResponseChecker;

import com.alipay.easysdk.payment.facetoface.models.AlipayTradePrecreateResponse;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

/**功能描述：支付宝支付业务类
 * @Auther:梁志杰
 * @Date:2021/5/22
 * @Description:cn.xueden.service
 * @version:1.0
 */
@Component
@Slf4j
public class AliPayService {

    public String alipayFaceToFacePrecreate(String subject, String outTradeNo, String totalAmount){
         return alipayFaceToFacePrecreate(subject,outTradeNo,totalAmount,null);
    }


    /**
     *功能描述：当面付 生成交易付款码，待用户扫码付款
     * @param subject
     * @param outTradeNo
     * @param totalAmount
     * @param totalAmount
     * @return
     */
    public String alipayFaceToFacePrecreate(String subject, String outTradeNo, String totalAmount,String asyncNotify){
        try {
            // 2. 发起API调用（以创建当面付收款二维码为例）
            AlipayTradePrecreateResponse response = Factory.Payment.FaceToFace().asyncNotify(asyncNotify)
                    .preCreate(subject, outTradeNo, totalAmount);
            // 3. 处理响应或异常
            if (ResponseChecker.success(response)) {
                log.info("调用成功",response);
                return response.httpBody;
            } else {
                log.info("调用失败，原因：" + response.msg + "，" + response.subMsg);
            }
        } catch (Exception e) {
            log.info("调用遭遇异常，原因：" ,e.getMessage());
            throw new RuntimeException(e.getMessage(), e);
        }
        return null;
    }


}
