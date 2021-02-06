package cn.xueden.edu.service;

import cn.xueden.common.core.edu.domain.EduVideo;
import cn.xueden.common.redis.service.RedisService;
import org.springframework.web.multipart.MultipartFile;

/**功能描述：阿里云视频点播业务接口
 * @Auther:梁志杰
 * @Date:2021/1/25
 * @Description:cn.xueden.edu.service
 * @version:1.0
 */
public interface IVodService {

    // 根据文件标志获取视频信息
    EduVideo getVideoByfileKey(String fileKey);

    /**
     * 根据章节id实现上传视频到阿里云服务器的方法
     * @param file
     * @return
     */
    String uploadAliyunVideoById(MultipartFile file, Long id, RedisService redisService, String fileKey);

    /**
     * 根据章节id实现上传视频到阿里云服务器的方法(批量上传)
     * @param file
     * @return
     */
    String batchUploadAliyunVideoById(MultipartFile file, Long id, RedisService redisService, String fileKey);


}
