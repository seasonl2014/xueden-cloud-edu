package cn.xueden.common.core.edu.vo;

import cn.xueden.common.core.edu.domain.EduVideo;
import lombok.Data;

/**功能描述：视频观看记录视图类
 * @Auther:梁志杰
 * @Date:2021/2/18
 * @Description:cn.xueden.common.core.edu.vo
 * @version:1.0
 */
@Data
public class EduVideoMemberVO {

    private Long playCount;

    private Float duration;

    private EduVideo eduVideo;
}
