package cn.xueden.common.core.edu.vo;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**功能描述：课程视图对象
 * @Auther:梁志杰
 * @Date:2021/1/30
 * @Description:cn.xueden.common.core.edu.vo
 * @version:1.0
 */
@Data
public class EduCourseVO {
    private Long id;

    private Long teacherId;

    private String teacherName;

    private Long subjectId;

    @NotBlank(message = "课程标题不能为空")
    private String title;

    @NotBlank(message = "课程短标题不能为空")
    private String shortTitle;

    @NotNull(message = "课程价格不能为空")
    private BigDecimal price;

    @NotNull(message = "课程课时不能为空")
    private Integer lessonNum;

    @NotBlank(message = "课程封面不能为空")
    private String cover;

    private String remarks;


    private Long buyCount;

    private Long vipCount;


    private Long viewCount;


    private Long version;


    private String status;


    private Date createDate;


    private Date updateDate;


    private Long subjectParentId;

    @NotNull(message = "分类不能为空")
    private Long[] categoryKeys;

    //难度
    private Integer difficulty;

    // 课程类型 ，0表示新手入门，1表示免费好课，2表示技能提高3，表示实战
    private Integer courseType;

    // 章节列表
    private List<EduChapterVO> eduChapterVOList;
}
