package cn.xueden.common.core.edu.domain;

import cn.xueden.common.core.web.domain.DataEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;

/**功能描述：讲师收入明细实体类
 * @Auther:梁志杰
 * @Date:2021/5/26
 * @Description:cn.xueden.common.core.edu.domain
 * @version:1.0
 */
@Data
@TableName("edu_income_details")
public class EduIncomeDetails extends DataEntity<EduIncomeDetails> {
    @ApiModelProperty(value = "会员ID")
    private Long memberId;

    @ApiModelProperty(value = "课程讲师ID")
    private Long teacherId;

    @ApiModelProperty(value = "订单编号")
    private String orderNo;

    @ApiModelProperty(value = "课程ID")
    private Long courseId;

    @ApiModelProperty(value = "课程销售价格")
    private Double price;

    @ApiModelProperty(value = "课程收益")
    private Double income;



}
