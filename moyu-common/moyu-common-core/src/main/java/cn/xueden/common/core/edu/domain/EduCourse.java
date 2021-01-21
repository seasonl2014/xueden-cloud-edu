package cn.xueden.common.core.edu.domain;

import com.baomidou.mybatisplus.annotations.TableName;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**功能描述：课程实体类
 * @Auther:梁志杰
 * @Date:2021/1/19
 * @Description:cn.xueden.common.core.edu.domain
 * @version:1.0
 */
@Data
@TableName("edu_course")
public class EduCourse {
    @ApiModelProperty(value = "课程ID")
    private Long id;

    @ApiModelProperty(value = "课程讲师ID")
    private Long teacherId;

    @ApiModelProperty(value = "课程专业ID")
    private Long subjectId;

    @ApiModelProperty(value = "课程标题")
    private String title;

    @ApiModelProperty(value = "课程销售价格，设置为0则可免费观看")
    private BigDecimal price;

    @ApiModelProperty(value = "总课时")
    private Integer lessonNum;

    @ApiModelProperty(value = "课程封面图片路径")
    private String cover;

    @ApiModelProperty(value = "课程备注")
    private String remarks;

    @ApiModelProperty(value = "销售数量")
    private Long buyCount;

    @ApiModelProperty(value = "VIP学员数量")
    private Long vipCount;

    @ApiModelProperty(value = "浏览数量")
    private Long viewCount;

    @ApiModelProperty(value = "乐观锁")
    private Long version;

    @ApiModelProperty(value = "视频状态 Draft未发布  Normal已发布")
    private String status;

    @ApiModelProperty(value = "创建时间")
    private Date gmtCreate;

    @ApiModelProperty(value = "更新时间")
    private Date gmtModified;

    @ApiModelProperty(value = "课程一级分类ID")
    private Long subjectParentId;

    @ApiModelProperty(value = "课程难度，0表示入门，1表示初级，2表示中级，3表示高级")
    private Integer difficulty;

    @ApiModelProperty(value = "课程类型 ，0表示新手入门，1表示免费好课，2表示技能提高3，表示实战")
    private Integer courseType;
}

