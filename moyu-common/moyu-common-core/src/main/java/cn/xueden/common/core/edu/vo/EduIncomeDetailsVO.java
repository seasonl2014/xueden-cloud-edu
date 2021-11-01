package cn.xueden.common.core.edu.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**功能描述：讲师收益视图对象
 * @Auther:梁志杰
 * @Date:2021/5/26
 * @Description:cn.xueden.common.core.edu.vo
 * @version:1.0
 */
@Data
public class EduIncomeDetailsVO {


    // 会员ID
    private Long memberId;

    // 会员名称
    private String memberName;

    // 讲师ID
    private Long teacherId;

    // 订单编号
    private String orderNo;

    // 课程ID
    private Long courseId;

    // 课程名称
    private String courseName;

    // 课程价格
    private Double price;

    // 课程收益
    private Double income;

    // 交易日期
    protected Date createDate;
}
