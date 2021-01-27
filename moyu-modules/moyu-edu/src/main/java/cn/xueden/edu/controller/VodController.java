package cn.xueden.edu.controller;

import cn.xueden.alivod.utils.AliyunVODSDKUtils;
import cn.xueden.alivod.utils.ConstantPropertiesUtil;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.common.log.annotation.XudenOtherSystemLog;
import cn.xueden.common.security.annotation.PreAuthorize;

import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.vod.model.v20170321.GetVideoPlayAuthRequest;
import com.aliyuncs.vod.model.v20170321.GetVideoPlayAuthResponse;
import io.swagger.annotations.Api;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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

    /**
     * 根据视频id获取播放凭证
     * @param vid
     * @return
     */
    @GetMapping("getPlayAuth/{vid}")
    @XudenOtherSystemLog("根据视频id获取阿里云视频点播播放凭证")
    @PreAuthorize(hasPermi = "edu:chapter:playauth")
    public RestResponse getPlayAutoId(@PathVariable String vid){
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
