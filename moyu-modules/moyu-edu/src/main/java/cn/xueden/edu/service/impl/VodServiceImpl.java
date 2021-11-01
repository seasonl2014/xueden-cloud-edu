package cn.xueden.edu.service.impl;

import cn.xueden.alivod.PutObjectProgressListener;
import cn.xueden.alivod.utils.ConstantPropertiesUtil;
import cn.xueden.common.core.edu.domain.EduChapter;
import cn.xueden.common.core.edu.domain.EduCourse;
import cn.xueden.common.core.edu.domain.EduSubject;
import cn.xueden.common.core.edu.domain.EduVideo;
import cn.xueden.common.redis.service.RedisService;
import cn.xueden.edu.dao.EduChapterDao;
import cn.xueden.edu.dao.EduCourseDao;
import cn.xueden.edu.dao.EduSubjectDao;
import cn.xueden.edu.dao.EduVideoDao;
import cn.xueden.edu.service.IVodService;
import com.aliyun.vod.upload.impl.UploadVideoImpl;
import com.aliyun.vod.upload.req.UploadStreamRequest;
import com.aliyun.vod.upload.resp.UploadStreamResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.vod.model.v20170321.GetVideoInfoRequest;
import com.aliyuncs.vod.model.v20170321.GetVideoInfoResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.math.BigDecimal;
import java.util.concurrent.TimeUnit;

import static cn.xueden.alivod.utils.AliyunVODSDKUtils.initVodClient;

/**
 * @Auther:梁志杰
 * @Date:2021/1/25
 * @Description:cn.xueden.edu.service.impl
 * @version:1.0
 */
@Service
public class VodServiceImpl implements IVodService {

    @Autowired
    private EduVideoDao eduVideoDao;

    @Autowired
    private EduCourseDao eduCourseDao;

    @Autowired
    private EduSubjectDao eduSubjectDao;

    @Autowired
    private EduChapterDao eduChapterDao;

    /**
     * 获取阿里云视频信息(暂时先获取视频时长)
     * @param videoId
     * @return
     */
    public Float getVideoInfo(String videoId){
        try {
            TimeUnit.SECONDS.sleep(5);//秒
            DefaultAcsClient client = initVodClient(ConstantPropertiesUtil.ACCESS_KEY_ID, ConstantPropertiesUtil.ACCESS_KEY_SECRET);
            GetVideoInfoResponse response = new GetVideoInfoResponse();
            GetVideoInfoRequest request = new GetVideoInfoRequest();
            request.setVideoId(videoId);
            response =client.getAcsResponse(request);
            Float duration = response.getVideo().getDuration();
            return duration;
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 根据文件标志获取视频信息
     * @param fileKey
     * @return
     */
    @Override
    public EduVideo getVideoByfileKey(String fileKey) {
        return null;
    }

    /**
     * 根据章节id实现上传视频到阿里云服务器的方法
     * @param file
     * @param id
     * @param redisService
     * @param fileKey
     * @return
     */
    @Override
    public String uploadAliyunVideoById(MultipartFile file, Long id, RedisService redisService, String fileKey) {

       try {

            //获取小节视频信息
            EduVideo eduVideo = eduVideoDao.selectById(id);
            if(null==eduVideo){
                return null;
            }
            //根据课程ID获取课程信息
            EduCourse eduCourse = eduCourseDao.selectById(eduVideo.getCourseId());
            if(null==eduCourse){
                return null;
            }

            // 根据课程类别ID获取课程分类信息
            EduSubject eduSubject = eduSubjectDao.selectById(eduCourse.getSubjectId());
            if(null==eduSubject){
                return null;
            }

           String accessKeyId = ConstantPropertiesUtil.ACCESS_KEY_ID;
           String accessKeySecret = ConstantPropertiesUtil.ACCESS_KEY_SECRET;
           String fileName = file.getOriginalFilename();

           String title = fileName.substring(0,fileName.lastIndexOf("."));
           InputStream inputStream = file.getInputStream();
           int fileSize = inputStream.available();
           UploadStreamRequest request = new UploadStreamRequest(accessKeyId, accessKeySecret, title, fileName, inputStream);
           request.setCateId(eduSubject.getCateId());
           request.setPrintProgress(true);
           //转码组，转码收费比较昂贵，视频免费则不需要转码
           if(eduCourse.getPrice().compareTo(BigDecimal.ZERO)  == 0){
               System.out.println("课程免费，不需要转码");
           }else{
               // 在判断单个视频是否免费
               if(eduVideo.getIsFree()==1){
                   request.setTemplateGroupId(ConstantPropertiesUtil.TEMPLATE_GROUPID);
               }

           }

           /* 设置自定义上传进度回调 (必须继承 VoDProgressListener) */
           request.setProgressListener(new PutObjectProgressListener(redisService,fileSize,id));
           UploadVideoImpl uploader = new UploadVideoImpl();
           UploadStreamResponse response = uploader.uploadStream(request);
           System.out.print("RequestId=" + response.getRequestId() + "\n"); //请求视频点播服务的请求ID
           if (response.isSuccess()) {
               System.out.print("VideoId=" + response.getVideoId() + "\n");
           } else {
               /* 如果设置回调URL无效，不影响视频上传，可以返回VideoId同时会返回错误码。其他情况上传失败时，VideoId为空，此时需要根据返回错误码分析具体错误原因 */
               System.out.print("VideoId=" + response.getVideoId() + "\n");
               System.out.print("ErrorCode=" + response.getCode() + "\n");
               System.out.print("ErrorMessage=" + response.getMessage() + "\n");
           }

           //获取阿里云视频信息

           Float duration = getVideoInfo(response.getVideoId());

           // 更新视频信息
           eduVideo.setId(id);
           eduVideo.setVideoSourceId(response.getVideoId());
           eduVideo.setDuration(duration);
           eduVideo.setSize((long)fileSize);
           eduVideo.setFileKey(fileKey);
           eduVideoDao.updateById(eduVideo);
           return response.getVideoId();

       }catch (Exception e){
           e.printStackTrace();

       }

        return null;
    }

    /**
     * 根据章节id实现上传视频到阿里云服务器的方法
     * @param file
     * @param id
     * @param redisService
     * @param fileKey
     * @return
     */
    @Override
    public String batchUploadAliyunVideoById(MultipartFile file, Long id, RedisService redisService, String fileKey,Long teacherId) {

        try {
            EduVideo eduVideo = new EduVideo();
            //获取大章信息
            EduChapter eduChapter = eduChapterDao.selectById(id);
            if(null==eduChapter){
                return null;
            }
            //根据课程ID获取课程信息
            EduCourse eduCourse = eduCourseDao.selectById(eduChapter.getCourseId());
            if(null==eduCourse){
                return null;
            }

            // 根据课程类别ID获取课程分类信息
            EduSubject eduSubject = eduSubjectDao.selectById(eduCourse.getSubjectId());
            if(null==eduSubject){
                return null;
            }

            String accessKeyId = ConstantPropertiesUtil.ACCESS_KEY_ID;
            String accessKeySecret = ConstantPropertiesUtil.ACCESS_KEY_SECRET;
            String fileName = file.getOriginalFilename();

            String title = fileName.substring(0,fileName.lastIndexOf("."));
            InputStream inputStream = file.getInputStream();
            int fileSize = inputStream.available();
            UploadStreamRequest request = new UploadStreamRequest(accessKeyId, accessKeySecret, title, fileName, inputStream);
            request.setCateId(eduSubject.getCateId());
            request.setPrintProgress(true);
            //转码组，转码收费比较昂贵，视频免费则不需要转码
            if(eduCourse.getPrice().compareTo(BigDecimal.ZERO)  == 0){
                System.out.println("课程免费，不需要转码");
                eduVideo.setIsFree(0);
            }else{
                eduVideo.setIsFree(1);
            }

            /* 设置自定义上传进度回调 (必须继承 VoDProgressListener) */
            request.setProgressListener(new PutObjectProgressListener(redisService,fileSize,id));
            UploadVideoImpl uploader = new UploadVideoImpl();
            UploadStreamResponse response = uploader.uploadStream(request);
            System.out.print("RequestId=" + response.getRequestId() + "\n"); //请求视频点播服务的请求ID
            if (response.isSuccess()) {
                System.out.print("VideoId=" + response.getVideoId() + "\n");
            } else {
                /* 如果设置回调URL无效，不影响视频上传，可以返回VideoId同时会返回错误码。其他情况上传失败时，VideoId为空，此时需要根据返回错误码分析具体错误原因 */
                System.out.print("VideoId=" + response.getVideoId() + "\n");
                System.out.print("ErrorCode=" + response.getCode() + "\n");
                System.out.print("ErrorMessage=" + response.getMessage() + "\n");
            }

            //获取阿里云视频信息

            Float duration = getVideoInfo(response.getVideoId());

            // 插入视频信息

            eduVideo.setVideoSourceId(response.getVideoId());
            eduVideo.setDuration(duration);
            eduVideo.setSize((long)fileSize);
            eduVideo.setFileKey(fileKey);
            eduVideo.setChapterId(eduChapter.getId());
            eduVideo.setTitle(title);
            eduVideo.setCourseId(eduCourse.getId());

            if(teacherId!=null){
                eduVideo.setCreateId(teacherId);
                eduVideo.setUpdateId(teacherId);
            }

            eduVideoDao.insert(eduVideo);
            return response.getVideoId();

        }catch (Exception e){
            e.printStackTrace();

        }

        return null;
    }
}
