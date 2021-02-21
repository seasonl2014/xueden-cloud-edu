package cn.xueden.wechat.utils;

import com.yungouos.pay.wxpay.WxPay;
import org.springframework.stereotype.Component;

/**
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
}

