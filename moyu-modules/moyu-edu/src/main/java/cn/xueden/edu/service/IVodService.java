package cn.xueden.edu.service;

import cn.xueden.common.core.edu.domain.EduVideo;

/**功能描述：阿里云视频点播业务接口
 * @Auther:梁志杰
 * @Date:2021/1/25
 * @Description:cn.xueden.edu.service
 * @version:1.0
 */
public interface IVodService {

    // 根据文件标志获取视频信息
    EduVideo getVideoByfileKey(String fileKey);

}
