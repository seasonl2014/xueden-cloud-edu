package cn.xueden.common.core.edu.domain;

import cn.xueden.common.core.web.domain.DataEntity;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**功能描述：每日统计实体类
 * @Auther:梁志杰
 * @Date:2021/5/27
 * @Description:cn.xueden.common.core.edu.domain
 * @version:1.0
 */
@Data
@TableName("edu_daily_report")
public class EduDailyReport {

    /**
     * 实体编号（唯一标志）
     *
     */
    @TableId(type = IdType.AUTO)
    protected  Long id;

    @ApiModelProperty(value = "课程讲师ID")
    private Long teacherId;

    @ApiModelProperty(value = "创建时间")
    private Date createTime;

    @ApiModelProperty(value = "日期")
    private String date;

    @ApiModelProperty(value = "讲师收入")
    private Double incomeMoney;

    @ApiModelProperty(value = "订单数量")
    private Integer orderNum;

    @ApiModelProperty(value = "天")
    private String dayNo;

}
