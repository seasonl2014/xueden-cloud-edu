package cn.xueden.common.core.edu.vo;

import cn.xueden.common.core.edu.domain.EduVideo;
import lombok.Data;

import java.util.Date;
import java.util.List;

/**功能描述：章节视图对象
 * @Auther:梁志杰
 * @Date:2021/1/24
 * @Description:cn.xueden.common.core.edu.vo
 * @version:1.0
 */
@Data
public class EduChapterVO {
    private Long id;

    private Long courseId;

    private String title;

    private String remarks;

    private Float duration;

    private Integer sort;

    private Date createDate;

    private Date updateDate;

    private List<EduVideo> children;
}

