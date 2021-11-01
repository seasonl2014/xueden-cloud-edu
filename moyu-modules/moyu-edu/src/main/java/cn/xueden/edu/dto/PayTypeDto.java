package cn.xueden.edu.dto;

import lombok.Data;

/**功能描述：订单支付方式
 * @Auther:梁志杰
 * @Date:2021/5/22
 * @Description:cn.xueden.edu.dto
 * @version:1.0
 */
@Data
public class PayTypeDto {
    /**
     * 支付渠道wxpay表示微信，alipay表示支付宝
     */
    private String payType;
}
