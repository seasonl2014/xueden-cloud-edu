package cn.xueden.common.core.edu.domain;

import cn.xueden.common.core.web.domain.DataEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @Auther:梁志杰
 * @Date:2021/1/30
 * @Description:cn.xueden.common.core.edu.domain
 * @version:1.0
 */
@Data
@TableName("edu_member_buy_course")
public class EduMemberBuyCourse  extends DataEntity<EduMemberBuyCourse> {

    @ApiModelProperty(value = "订单编号")
    private String orderNo;

    @ApiModelProperty(value = "课程ID")
    private Long courseId;

    @ApiModelProperty(value = "会员ID")
    private Long memberId;

    @ApiModelProperty(value = "购买金额")
    private BigDecimal price;

    @ApiModelProperty(value = "购买类型，0表示普通会员购买，其他表示VIP购买")
    private Long buyType;

    @ApiModelProperty(value = "是否付款，0表示未付款，1表示已付款，2表示已退款")
    private Integer isPayment;

    @ApiModelProperty(value = "支付渠道（ wxpay表示微信，alipay表示支付宝")
    private String payChannel;

    @ApiModelProperty(value = "所属国家或地区")
    private String country;

    @ApiModelProperty(value = "区域，如华南")
    private String area;

    @ApiModelProperty(value = "所属省份")
    private String province;

    @ApiModelProperty(value = "所属城市")
    private String city;

    @ApiModelProperty(value = "网络服务提供商")
    private String isp;

}
