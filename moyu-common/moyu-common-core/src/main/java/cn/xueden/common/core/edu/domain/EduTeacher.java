package cn.xueden.common.core.edu.domain;

import cn.xueden.common.core.web.domain.DataEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;

/**功能描述：讲师实体类
 * @Auther:梁志杰
 * @Date:2021/1/22
 * @Description:cn.xueden.common.core.edu.domain
 * @version:1.0
 */
@TableName("edu_teacher")
@Data
public class EduTeacher extends DataEntity<EduTeacher> {

    @ApiModelProperty(value = "讲师姓名")
    private String name;

    @ApiModelProperty(value = "讲师资历,一句话说明讲师")
    private String intro;

    @ApiModelProperty(value = "头衔 1高级讲师 2首席讲师")
    private Integer level;

    @ApiModelProperty(value = "讲师头像")
    private String avatar;

    @ApiModelProperty(value = "排序")
    private Integer sort;

    @ApiModelProperty(value = "可提现金额")
    private BigDecimal cashOutMoney;

    @ApiModelProperty(value = "累计收入")
    private BigDecimal incomeAmount;

    @ApiModelProperty(value = "收款人姓名")
    private String payeeName;

    @ApiModelProperty(value = "收款卡号")
    private String cardNumber;

    @ApiModelProperty(value = "收款银行")
    private String bank;

}
