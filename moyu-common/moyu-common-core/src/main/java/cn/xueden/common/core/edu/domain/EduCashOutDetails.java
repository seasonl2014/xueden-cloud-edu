package cn.xueden.common.core.edu.domain;

import cn.xueden.common.core.web.domain.DataEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**功能描述：讲师提现明细实体类
 * @Auther:梁志杰
 * @Date:2021/5/26
 * @Description:cn.xueden.common.core.edu.domain
 * @version:1.0
 */
@Data
@TableName("edu_cashout_details")
public class EduCashOutDetails extends DataEntity<EduCashOutDetails> {

    @ApiModelProperty(value = "课程讲师ID")
    private Long teacherId;

    @ApiModelProperty(value = "提款账号")
    private String bankCard;

    @ApiModelProperty(value = "开户人")
    private String name;

    @ApiModelProperty(value = "提现金额")
    private Double cashOut;

    @ApiModelProperty(value = "状态，0待审核 1 付款完成")
    private Integer status;



}
