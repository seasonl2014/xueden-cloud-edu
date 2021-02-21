package cn.xueden.edu.controller.front;

import cn.xueden.common.core.edu.vo.EduVideoVO;
import cn.xueden.common.core.utils.IPUtil;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.edu.service.IEduVideoService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

/**
 * @Auther:梁志杰
 * @Date:2021/1/30
 * @Description:cn.xueden.edu.controller.front
 * @version:1.0
 */
@Api(tags = "前台视频播放接口")
@RestController
@RequestMapping("/edu/front/video")
public class EduPlayVideoController {

    @Autowired
    private IEduVideoService videoService;

    /**
     * 获取视频详情
     * @param id
     * @return
     */
    @ApiOperation(value = "前台获取视频详情", notes = "前台获取视频信息")
    @PostMapping("/get/{id}")
    public RestResponse getVideoInfo(@PathVariable Long id,
                                     HttpServletRequest request) {
        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return RestResponse.failure("视频加载失败，请先登录！");
        }
        // 获取用户IP地址
        String ipAddress = IPUtil.getIpAddr(request);
        System.out.println("观看视频，获取用户真实ip地址：-------"+ipAddress);
        EduVideoVO videoVO = videoService.getVideoInfo(id,token,ipAddress);
        if(videoVO==null){
            return RestResponse.failure("请先购买或加入VIP再来观看吧！");
        }


        return RestResponse.success().setData(videoVO);
    }
}
