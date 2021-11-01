package cn.xueden.wechat.dto;

import lombok.Data;

/**功能描述：微信支付下单请求参数
 * @Auther:梁志杰
 * @Date:2021/5/21
 * @Description:cn.xueden.wechat.dto
 * @version:1.0
 */
@Data
public class WxOrderDto {

    /**
     * 应用ID, 由微信生成的应用ID，全局唯一
     */
    private String appid;

    /**
     * 直连商户号
     */
    private String mchid;

    /**
     * 商品描述
     */
    private String description;

    /**
     * 商户订单号
     */
    private String out_trade_no;

    /**
     * 通知地址
     */
    private String notify_url;

    /**
     * 金额
     */
    private AmountDto amount;
}
