package cn.xueden.common.core.edu.domain;

import cn.xueden.common.core.web.domain.DataEntity;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

/**功能描述：课程大章实体类
 * @Auther:梁志杰
 * @Date:2021/1/24
 * @Description:cn.xueden.common.core.edu.domain
 * @version:1.0
 */
@Data
@TableName("edu_chapter")
public class EduChapter extends DataEntity<EduChapter> {

    @ApiModelProperty(value = "课程ID")
    private Long courseId;

    @ApiModelProperty(value = "章节名称")
    private String title;

    @ApiModelProperty(value = "章节时长")
    private Float duration;

    @ApiModelProperty(value = "显示排序")
    private Integer sort;

}
