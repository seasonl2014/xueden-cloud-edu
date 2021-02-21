package cn.xueden.edu.service;

import cn.xueden.common.core.edu.domain.EduVideo;
import cn.xueden.common.core.edu.vo.EduVideoVO;
import com.baomidou.mybatisplus.extension.service.IService;
/*import com.baomidou.mybatisplus.service.IService;*/

/**功能描述：课程大纲小节业务接口
 * @Auther:梁志杰
 * @Date:2021/1/24
 * @Description:cn.xueden.edu.service
 * @version:1.0
 */
public interface IEduVideoService extends IService<EduVideo> {

    /**
     * 根据文件标志获取视频信息
     * @param fileKey
     * @return
     */
    EduVideo getVideoByfileKey(String fileKey);


    /**
     * 根据ID获取视频信息
     * @param id
     * @param token
     * @param ipAddress
     * @return
     */
    EduVideoVO getVideoInfo(Long id, String token, String ipAddress);

}
