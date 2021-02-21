package cn.xueden.common.core.edu.enums;

/**功能描述：订单状态
 * @Auther:梁志杰
 * @Date:2021/2/18
 * @Description:cn.xueden.common.core.edu.enums
 * @version:1.0
 */
public enum PayStatus {
    NO_PAY("0", "未付款"),
    YES_PAY("1", "已付款"),
    REFUND_PAY("2", "已退款");

    private final String code;

    private final String info;

    PayStatus(String code, String info) {
        this.code = code;
        this.info = info;
    }

    public String getCode() {
        return code;
    }

    public String getInfo() {
        return info;
    }
}
