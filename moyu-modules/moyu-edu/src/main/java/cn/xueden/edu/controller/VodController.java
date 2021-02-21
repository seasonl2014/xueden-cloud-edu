package cn.xueden.edu.controller;

import cn.xueden.alivod.utils.AliyunVODSDKUtils;
import cn.xueden.alivod.utils.ConstantPropertiesUtil;
import cn.xueden.common.core.edu.domain.EduVideo;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.common.log.annotation.XudenOtherSystemLog;
import cn.xueden.common.redis.service.RedisService;
import cn.xueden.common.security.annotation.PreAuthorize;

import cn.xueden.edu.service.IEduVideoService;
import cn.xueden.edu.service.IVodService;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.vod.model.v20170321.GetVideoPlayAuthRequest;
import com.aliyuncs.vod.model.v20170321.GetVideoPlayAuthResponse;
import io.swagger.annotations.Api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**功能描述：a阿里云视频点播模块控制层
 * @Auther:梁志杰
 * @Date:2021/1/25
 * @Description:cn.xueden.edu.controller
 * @version:1.0
 */
@Api("阿里云点播接口")
@RestController
@RequestMapping("/edu/vod")
public class VodController {

    @Autowired
    private IEduVideoService eduVideoService;

    @Autowired
    private RedisService redisService;

    @Autowired
    private IVodService vodService;

    /**
     * 重置上传进度
     * @param request
     */
    @GetMapping ("/percent/reset")
    public void resetPercent(HttpServletRequest request){
        String videoId = request.getParameter("videoId");
        redisService.deleteObject("upload_percent:"+videoId);
    }

    /**
     * 获取实时长传进度
     * @param videoId
     * @return
     */
    @GetMapping("getUploadPercent/{videoId}")
    public RestResponse getUploadPercent(@PathVariable String videoId){
        System.out.println("从redis获取=========方法====："+redisService.getCacheObject("upload_percent:"+videoId));
        int percent = redisService.getCacheObject("upload_percent:"+videoId) == null ? 0: (int) redisService.getCacheObject("upload_percent:"+videoId);
        Map<String,Object> map = new HashMap<>();
        map.put("percent",percent);
        return RestResponse.success().setData(map);
    }

    /**
     * 获取实时长传进度(批量上传)
     * @param fileKey
     * @return
     */
    @GetMapping("getBatchUploadPercent/{fileKey}")
    public RestResponse getBatchUploadPercent(@PathVariable String fileKey){
        System.out.println("从redis获取===="+fileKey+"=====批量方法====："+redisService.getCacheObject("upload_percent:"+fileKey));
        int percent = redisService.getCacheObject("upload_percent:"+fileKey) == null ? 0: (int) redisService.getCacheObject("upload_percent:"+fileKey);
        Map<String,Object> map = new HashMap<>();
        map.put("percent",percent);
        return RestResponse.success().setData(map);
    }

    /**
     * 根据章节id实现上传视频到阿里云服务器的方法
     * @return
     */
    @PostMapping("uploadById")
    public RestResponse uploadAliyunVideoById(@RequestParam("file") MultipartFile file, @RequestParam("id")Long id,
                                              @RequestParam("fileKey")String fileKey, HttpServletRequest request){

        //调用方法实现视频上传，返回上传之后的视频id
        try {

            Map<String,Object> map = new HashMap<>();

            // 判断视频是否已经上传过了
            if(fileKey!=null){
                EduVideo eduVideo = eduVideoService.getVideoByfileKey(fileKey);
                if(eduVideo!=null){
                    return RestResponse.success("极速秒传完成");
                }else{
                    String videoId = vodService.uploadAliyunVideoById(file,id,redisService,fileKey);
                    map.put("videoId",videoId);
                    return RestResponse.success("上传成功").setData(map);
                }
            }else {
                String videoId = vodService.uploadAliyunVideoById(file,id,redisService,fileKey);
                map.put("videoId",videoId);
                return RestResponse.success("上传成功").setData(map);
            }

        } catch (Exception e) {
            e.printStackTrace();
            return RestResponse.failure("上传失败");
        }
    }

    /**
     * 根据章节id实现上传视频到阿里云服务器的方法(批量上传)
     * @return
     */
    @PostMapping("batchUploadApi")
    public RestResponse uploadAliyunVideoById2(@RequestParam("file") MultipartFile file, @RequestParam("id")Long id,
                                              @RequestParam("fileKey")String fileKey, HttpServletRequest request){

        //调用方法实现视频上传，返回上传之后的视频id
        try {

            Map<String,Object> map = new HashMap<>();

            // 判断视频是否已经上传过了
            if(fileKey!=null){
                EduVideo eduVideo = eduVideoService.getVideoByfileKey(fileKey);
                if(eduVideo!=null){
                    return RestResponse.success("极速秒传完成");
                }else{
                    String videoId = vodService.batchUploadAliyunVideoById(file,id,redisService,fileKey);
                    map.put("videoId",videoId);
                    return RestResponse.success("上传成功").setData(map);
                }
            }else {
                String videoId = vodService.batchUploadAliyunVideoById(file,id,redisService,fileKey);
                map.put("videoId",videoId);
                return RestResponse.success("上传成功").setData(map);
            }

        } catch (Exception e) {
            e.printStackTrace();
            return RestResponse.failure("上传失败");
        }
    }

    /**
     * 根据视频id获取播放凭证
     * @param vid
     * @return
     */
    @GetMapping("getPlayAuth/{vid}")
    @XudenOtherSystemLog("根据视频id获取阿里云视频点播播放凭证")
    @PreAuthorize(hasPermi = "edu:chapter:playauth")
    public RestResponse getPlayAutoId(@PathVariable String vid){
        return getPlayAutoId2(vid);
      /*  try {
            //初始化客户端、请求对象和相应对象
            DefaultAcsClient client = AliyunVODSDKUtils.initVodClient(ConstantPropertiesUtil.ACCESS_KEY_ID, ConstantPropertiesUtil.ACCESS_KEY_SECRET);

            GetVideoPlayAuthRequest request = new GetVideoPlayAuthRequest();
            GetVideoPlayAuthResponse response = new GetVideoPlayAuthResponse();

            //设置请求参数
            request.setVideoId(vid);
            //获取请求响应
            response = client.getAcsResponse(request);

            //输出请求结果
            //播放凭证
            String playAuth = response.getPlayAuth();
            Map<String,Object> map = new HashMap<>();
            map.put("playAuth",playAuth);
            return RestResponse.success().setData(map);
        } catch (Exception e) {
            e.printStackTrace();
            return RestResponse.failure("获取播放凭证失败");
        }*/

    }

    /**
     * 前台使用 根据视频id获取播放凭证
     * @param vid
     * @return
     */
    @PostMapping("getPlayAuth2/{vid}")
    public RestResponse getPlayAutoId2(@PathVariable String vid){
        try {
            //初始化客户端、请求对象和相应对象
            DefaultAcsClient client = AliyunVODSDKUtils.initVodClient(ConstantPropertiesUtil.ACCESS_KEY_ID, ConstantPropertiesUtil.ACCESS_KEY_SECRET);

            GetVideoPlayAuthRequest request = new GetVideoPlayAuthRequest();
            GetVideoPlayAuthResponse response = new GetVideoPlayAuthResponse();

            //设置请求参数
            request.setVideoId(vid);
            //获取请求响应
            response = client.getAcsResponse(request);

            //输出请求结果
            //播放凭证
            String playAuth = response.getPlayAuth();
            Map<String,Object> map = new HashMap<>();
            map.put("playAuth",playAuth);
            return RestResponse.success().setData(map);
        } catch (Exception e) {
            e.printStackTrace();
            return RestResponse.failure("获取播放凭证失败");
        }

    }


}
