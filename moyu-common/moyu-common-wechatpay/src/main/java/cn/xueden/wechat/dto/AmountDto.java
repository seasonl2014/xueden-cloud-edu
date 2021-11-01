package cn.xueden.wechat.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Auther:梁志杰
 * @Date:2021/5/21
 * @Description:cn.xueden.wechat.dto
 * @version:1.0
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AmountDto {

    /**
     * 订单总金额，单位为分
     */
    private Integer total;

    /**
     * 货币类型,CNY：人民币
     */
    private String currency;
}
