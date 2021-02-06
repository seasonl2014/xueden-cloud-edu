package cn.xueden.edu.controller.front;

import cn.xueden.common.core.edu.domain.EduMemberBuyVip;
import cn.xueden.common.core.edu.domain.EduTeacher;
import cn.xueden.common.core.edu.vo.*;
import cn.xueden.common.core.utils.IPUtil;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.common.log.annotation.XudenOtherSystemLog;

import cn.xueden.edu.service.IEduChapterService;
import cn.xueden.edu.service.IEduCourseService;
import cn.xueden.edu.service.IEduTeacherService;
import cn.xueden.edu.service.IEduVipTypeService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**功能描述：前台课程详情控制层
 * @Auther:梁志杰
 * @Date:2021/1/30
 * @Description:cn.xueden.edu.controller.front
 * @version:1.0
 */
@Api(tags = "前台课程详情接口")
@RestController
@RequestMapping("/edu/front/details")
public class EduDetailsController {

    @Autowired
    private IEduCourseService courseService;

    @Autowired
    private IEduTeacherService eduTeacherService;

    @Autowired
    private IEduChapterService eduChapterService;

    @Autowired
    private IEduVipTypeService eduVipTypeService;

    @Autowired
    private IEduVipTypeService vipTypeService;

   /* @Autowired
    private IEduMemberService memberService;



    @Autowired
    private IEduMemberBuyCourseService memberBuyCourseService;*/

    /**
     * 编辑课程
     * @param id
     * @return
     */
    @ApiOperation(value = "前台获取课程详情", notes = "前台获取课程信息")
    @PostMapping("/get/{id}")
    //@XudenOtherSystemLog("查看课程详情")
    public RestResponse get(@PathVariable Long id) {

        // 获取课程信息
        EduCourseVO eduCourseVO = courseService.getById(id);


        if(eduCourseVO!=null){
            // 获取讲师信息
            EduTeacher eduTeacher = eduTeacherService.getById(eduCourseVO.getTeacherId());
            if(eduTeacher!=null){
                eduCourseVO.setTeacherName(eduTeacher.getName());
            }

            // 更新查看次数
            courseService.updateViewCount(eduCourseVO);

            // 获取章节目录
            EduChapterVO eduChapterVO = new EduChapterVO();
            eduChapterVO.setCourseId(eduCourseVO.getId());
            List<EduChapterVO> eduChapterVOList = eduChapterService.findAllByEduChapterAndVideo(eduChapterVO);


            eduCourseVO.setEduChapterVOList(eduChapterVOList);
            return RestResponse.success().setData(eduCourseVO);
        }else{
            return RestResponse.failure("查看课程失败");
        }


    }


    /**
     * 获取所有VIP会员
     *
     * @return
     */
    @ApiOperation(value = "前台获取所有VIP会员", notes = "前台获取所有VIP会员")
    @PostMapping("/getAllVip")
    public RestResponse getAllVip() {
        List<EduVipTypeVO> eduVideoVOList= eduVipTypeService.getAllVip();
        if(eduVideoVOList!=null){
            return RestResponse.success().setData(eduVideoVOList);
        }else {
            return RestResponse.failure("加入失败");
        }

    }

    /**
     * 获取会员下的所有权益
     * @param vipId
     * @return
     */
    @ApiOperation(value = "前台获取会员下的所有权益", notes = "前台获取会员下的所有权益")
    @PostMapping("/getVipSubject/{vipId}")
    public RestResponse getVipSubject(@PathVariable Long vipId) {
        List<EduVipTypeSubjectVO> eduVipTypeSubjectVOS = eduVipTypeService.getVipSubject(vipId);
        if(eduVipTypeSubjectVOS!=null){
            return RestResponse.success().setData(eduVipTypeSubjectVOS);
        }else {
            return RestResponse.failure("暂无数据");
        }

    }

    /**
     * 加入VIP会员
     *
     * @return
     */
    @ApiOperation(value = "前台加入VIP会员", notes = "前台加入VIP会员")
    @PostMapping("/addVip")
    @XudenOtherSystemLog("加入VIP会员")
    public RestResponse addVip(@RequestBody EduVipTypeVO eduVipTypeVO, HttpServletRequest request) {
        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return RestResponse.failure("购买失败，请先登录！");
        }
        if(eduVipTypeVO==null){
            return RestResponse.failure("加入失败");
        }
        // 获取用户IP地址
        String ipAddress = IPUtil.getIpAddr(request);
        //测试用：
        ipAddress = "180.142.65.253";
        EduMemberBuyVip result = vipTypeService.addVip(eduVipTypeVO.getId(),token,ipAddress);
        if(result==null){
            return RestResponse.failure("加入失败");
        }
        return  RestResponse.success("订单生成成功").setCode(50001).setData(result);

    }


}
