package cn.xueden.common.core.edu.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

/**功能描述：课程小节视图类
 * @Auther:梁志杰
 * @Date:2021/1/30
 * @Description:cn.xueden.common.core.edu.vo
 * @version:1.0
 */
@Data
public class EduVideoVO {
    private Long id;

    private Long courseId;

    private Long chapterId;

    private String title;

    private Integer sort;

    private Long playCount;

    private Integer isFree;

    private String videoSourceId;

    private Float duration;

    private Integer previewDuration; // 预览时长

    private String status;

    private Long size;

    private Long version;

    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd")
    private Date createDate;

    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd")
    private Date updateDate;

    private String videoOriginalName;

    private Integer displayAds; // 是否显示广告，0表示显示，1表示不显示
}
