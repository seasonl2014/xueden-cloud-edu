package cn.xueden.edu.controller.front;

import cn.xueden.common.core.edu.domain.*;
import cn.xueden.common.core.edu.enums.PayStatus;
import cn.xueden.common.core.edu.vo.EduMemberBuyCourseVO;
import cn.xueden.common.core.edu.vo.EduMemberVO;
import cn.xueden.common.core.edu.vo.MyCourseVO;
import cn.xueden.common.core.edu.vo.PassWordVO;
import cn.xueden.common.core.utils.LayerData;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.common.log.annotation.XudenOtherSystemLog;
import cn.xueden.common.redis.service.RedisService;
import cn.xueden.common.security.service.TokenService;
import cn.xueden.common.security.utils.SecurityUtils;
import cn.xueden.edu.converter.EduMemberBuyCourseConverter;
import cn.xueden.edu.converter.EduMemberConverter;
import cn.xueden.edu.converter.EduVideoMemberConverter;
import cn.xueden.edu.service.*;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.catalina.security.SecurityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**功能描述：会员个人中心控制层
 * @Auther:梁志杰
 * @Date:2021/2/18
 * @Description:cn.xueden.edu.controller.front
 * @version:1.0
 */
@Api(tags = "前台会员个人中心接口")
@RestController
@RequestMapping("/edu/front/member/center")
public class EduMemberCenterController {

    @Autowired
    private TokenService tokenService;

    @Autowired
    private IEduMemberService memberService;

    @Autowired
    private IEduVipTypeService vipTypeService;

    @Autowired
    private IEduMemberBuyCourseService memberBuyCourseService;

    @Autowired
    private IEduCourseService eduCourseService;

    @Autowired
    private IEduDealMoneyService dealMoneyService;

    @Autowired
    private IEduVideoMemberService videoMemberService;

    @Autowired
    private IEduVideoService videoService;

    @Autowired
    private IEduTeacherService teacherService;

    @Autowired
    private RedisService redisService;

    @ApiOperation(value = "前台会员个人信息", notes = "前台会员个人信息")
    @PostMapping("/info")
    @XudenOtherSystemLog("个人中心")
    public RestResponse getMemberInfo(HttpServletRequest request) {
        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return RestResponse.failure("请先登录！");
        }

        //根据token,获取登录会员信息
        EduMemberVO eduMemberVO = tokenService.getLoginMember();
        if(eduMemberVO==null){
            return RestResponse.failure("请先登录！");
        }
        // 获取会员信息
        EduMember dbEduMember = memberService.getById(eduMemberVO.getId());
        eduMemberVO = EduMemberConverter.converterToEduMemberVO(dbEduMember);

        // 获取该用户VIP
        EduVipType eduVipType = vipTypeService.getById(dbEduMember.getVipId());
        if(eduVipType!=null){
            eduMemberVO.setVipType(eduVipType.getName());
        }

        return RestResponse.success().setData(eduMemberVO);
    }

    @ApiOperation(value = "前台更新会员个人信息", notes = "前台更新会员个人信息")
    @PostMapping("/update")
    @XudenOtherSystemLog("前台更新会员个人信息")
    public RestResponse update(@RequestBody EduMemberVO eduMemberVO, HttpServletRequest request) {
        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return RestResponse.failure("请先登录！");
        }

        //根据token,获取登录会员信息
        EduMemberVO eduMemberToken = tokenService.getLoginMember();
        if(eduMemberToken==null){
            return RestResponse.failure("请先登录！");
        }
        // 获取会员信息
        EduMember dbEduMember = memberService.getById(eduMemberToken.getId());
        if(dbEduMember==null){
            return RestResponse.failure("更新个人信息失败！");
        }else{
            dbEduMember.setNickname(eduMemberVO.getNickname());
            dbEduMember.setSex(eduMemberVO.getSex());
            dbEduMember.setSign(eduMemberVO.getSign());
            dbEduMember.setUpdateId(dbEduMember.getId());
            memberService.updateById(dbEduMember);
        }


        return RestResponse.success("更新个人信息成功");
    }

    @ApiOperation(value = "前台获取我的课程", notes = "前台获取我的课程")
    @PostMapping("/getMyCourseList")
    @XudenOtherSystemLog("前台获取我的课程")
    public RestResponse getMyCourseList(@RequestBody MyCourseVO myCourseVO,HttpServletRequest request) {
        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return RestResponse.failure("请先登录！");
        }

        //根据token,获取登录会员信息
        EduMemberVO eduMemberToken = tokenService.getLoginMember();
        if(eduMemberToken==null){
            return RestResponse.failure("请先登录！");
        }
        int pageNO = 1;
        int pageSize = 3;
        if(myCourseVO!=null){
            pageNO = myCourseVO.getPageNo();
            pageSize = myCourseVO.getPageSize();
        }

        // 获取我的课程
        QueryWrapper<EduMemberBuyCourse> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("is_payment", PayStatus.YES_PAY.getCode());
        queryWrapper.eq("member_id", eduMemberToken.getId());
        Page<EduMemberBuyCourse> memberBuyCoursePage = memberBuyCourseService.page(new Page<>(pageNO,pageSize),queryWrapper);
        Map<String,Object> result = new HashMap<>();
        result.put("total",memberBuyCoursePage.getTotal());
        result.put("list", EduMemberBuyCourseConverter.converterToVOList(memberBuyCoursePage.getRecords(),eduCourseService));
        return RestResponse.success("获取我的课程成功").setData(result);
    }

    @ApiOperation(value = "前台下载课程资料", notes = "前台下载课程资料")
    @PostMapping("/download/{orderNo}")
    @XudenOtherSystemLog("前台下载课程资料")
    public RestResponse download(@PathVariable String orderNo, HttpServletRequest request) {
        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return RestResponse.failure("请先登录！");
        }

        //根据token,获取登录会员信息
        EduMemberVO eduMemberToken = tokenService.getLoginMember();
        if(eduMemberToken==null){
            return RestResponse.failure("请先登录！");
        }

        if(orderNo==null){
            return RestResponse.failure("下载失败！");
        }


        // 根据订单获取我的课程
        QueryWrapper<EduMemberBuyCourse> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("is_payment", PayStatus.YES_PAY.getCode());
        queryWrapper.eq("order_no", orderNo);
        queryWrapper.eq("member_id", eduMemberToken.getId());
        EduMemberBuyCourse eduMemberBuyCourse = memberBuyCourseService.getOne(queryWrapper);
        if(eduMemberBuyCourse==null){
            return RestResponse.failure("下载失败！");
        }
        EduCourse eduCourse = eduCourseService.getById(eduMemberBuyCourse.getCourseId());
        if(eduCourse==null||eduCourse.getDownloadLink()==null){
            return RestResponse.failure("下载失败！");
        }
        return RestResponse.success("正在下载课程资料...").setData(eduCourse);
    }

    @ApiOperation(value = "前台获取购买记录", notes = "前台获取购买记录")
    @PostMapping("/getMyRechargeList")
    @XudenOtherSystemLog("前台获取购买记录")
    public RestResponse getMyRechargeList(@RequestBody MyCourseVO myCourseVO,HttpServletRequest request) {
        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return RestResponse.failure("请先登录！");
        }

        //根据token,获取登录会员信息
        EduMemberVO eduMemberToken = tokenService.getLoginMember();
        if(eduMemberToken==null){
            return RestResponse.failure("请先登录！");
        }
        int pageNO = 1;
        int pageSize = 3;
        if(myCourseVO!=null){
            pageNO = myCourseVO.getPageNo();
            pageSize = myCourseVO.getPageSize();
        }

        // 获取购买记录
        QueryWrapper<EduDealMoney> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("member_id", eduMemberToken.getId());
        Page<EduDealMoney> dealMoneyPage = dealMoneyService.page(new Page<>(pageNO,pageSize),queryWrapper);
        Map<String,Object> result = new HashMap<>();
        result.put("total",dealMoneyPage.getTotal());
        result.put("list", dealMoneyPage.getRecords());
        return RestResponse.success("获取购买记录成功").setData(result);
    }

    @ApiOperation(value = "前台获取视频播放记录", notes = "前台获取视频播放记录")
    @PostMapping("/getMyVideoList")
    @XudenOtherSystemLog("前台获取视频播放记录")
    public RestResponse getMyVideoList(@RequestBody MyCourseVO myCourseVO,HttpServletRequest request) {
        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return RestResponse.failure("请先登录！");
        }

        //根据token,获取登录会员信息
        EduMemberVO eduMemberToken = tokenService.getLoginMember();
        if(eduMemberToken==null){
            return RestResponse.failure("请先登录！");
        }
        int pageNO = 1;
        int pageSize = 3;
        if(myCourseVO!=null){
            pageNO = myCourseVO.getPageNo();
            pageSize = myCourseVO.getPageSize();
        }

        // 获取视频观看记录
        QueryWrapper<EduVideoMember> queryWrapper = new QueryWrapper<>();
        queryWrapper.select("video_id","sum(play_count) as play_count","ifnull(sum(duration),0) as duration ");
        queryWrapper.eq("member_id", eduMemberToken.getId());
        queryWrapper.groupBy("video_id");
        Page<EduVideoMember> videoMemberPage = videoMemberService.page(new Page<>(pageNO,pageSize),queryWrapper);
        Map<String,Object> result = new HashMap<>();
        result.put("total",videoMemberPage.getTotal());
        result.put("list", EduVideoMemberConverter.converterToVOList(videoMemberPage.getRecords(),videoService));
        return RestResponse.success("获取观看记录成功").setData(result);
    }

    @ApiOperation(value = "前台绑定邮箱", notes = "前台绑定邮箱")
    @PostMapping("/bindEamil")
    @XudenOtherSystemLog("前台绑定邮箱")
    public RestResponse bindEamil(@RequestBody EduMemberVO eduMemberVO, HttpServletRequest request) {
        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return RestResponse.failure("请先登录！");
        }

        //根据token,获取登录会员信息
        EduMemberVO eduMemberToken = tokenService.getLoginMember();
        if(eduMemberToken==null){
            return RestResponse.failure("请先登录！");
        }
        // 获取会员信息
        EduMember dbEduMember = memberService.getById(eduMemberToken.getId());
        if(dbEduMember==null){
            return RestResponse.failure("绑定邮箱失败！");
        }else{
            dbEduMember.setEmail(eduMemberVO.getEmail());
            dbEduMember.setUpdateId(dbEduMember.getId());
            memberService.updateById(dbEduMember);
        }


        return RestResponse.success("绑定邮箱成功");
    }

    @ApiOperation(value = "会员更改手机号", notes = "会员更改手机号")
    @PostMapping("/updatePhone")
    @XudenOtherSystemLog("会员更改手机号")
    public RestResponse updatePhone(@RequestBody EduMemberVO eduMemberVO, HttpServletRequest request) {
        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return RestResponse.failure("请先登录！");
        }

        //根据token,获取登录会员信息
        EduMemberVO eduMemberToken = tokenService.getLoginMember();
        if(eduMemberToken==null){
            return RestResponse.failure("请先登录！");
        }

        String code = redisService.getCacheObject(eduMemberVO.getMobile());
        if(code==null){
            return RestResponse.failure("更改失败,验证码已经过期！");
        }
        if(!code.equalsIgnoreCase(eduMemberVO.getCode())){
            return RestResponse.failure("更改失败,验证码不正确！");
        }

        // 获取会员信息
        EduMember dbEduMember = memberService.getById(eduMemberToken.getId());
        if(dbEduMember==null){
            return RestResponse.failure("更改失败,手机号已经存在！");
        }else{
            dbEduMember.setMobile(eduMemberVO.getMobile());
            dbEduMember.setUpdateId(dbEduMember.getId());
            memberService.updateById(dbEduMember);
        }


        return RestResponse.success("更改手机号成功");
    }

    @ApiOperation(value = "会员更新个人密码", notes = "会员更新个人密码")
    @PostMapping("/savePassWord")
    @XudenOtherSystemLog("会员更新个人密码")
    public RestResponse savePassWord(@RequestBody PassWordVO passWordVO, HttpServletRequest request) {
        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return RestResponse.failure("请先登录！");
        }

        //根据token,获取登录会员信息
        EduMemberVO eduMemberToken = tokenService.getLoginMember();
        if(eduMemberToken==null){
            return RestResponse.failure("请先登录！");
        }

        // 获取会员信息
        EduMember dbEduMember = memberService.getById(eduMemberToken.getId());
        if(dbEduMember==null){
            return RestResponse.failure("更改失败,会员不存在！");
        }else{
            if(passWordVO==null){
                return RestResponse.failure("更改失败,请填写完整信息！");
            }

            if(!SecurityUtils.matchesPassword(passWordVO.getPassWord(),dbEduMember.getPassword())){
                return RestResponse.failure("更改失败,原密码不正确！");
            }

            if(!passWordVO.getNewPassWord().equalsIgnoreCase(passWordVO.getResNewPassWord())){
                return RestResponse.failure("更改失败,两次输入密码不一致！");
            }

            dbEduMember.setPassword(SecurityUtils.encryptPassword(passWordVO.getNewPassWord()));
            dbEduMember.setUpdateId(dbEduMember.getId());
            memberService.updateById(dbEduMember);
        }


        return RestResponse.success("更改密码成功，请退出系统重新登录");
    }

    @ApiOperation(value = "前台讲师入驻", notes = "前台讲师入驻")
    @PostMapping("/apply")
    @XudenOtherSystemLog("前台更新会员个人信息")
    public RestResponse apply(@RequestBody EduTeacher eduTeacher, HttpServletRequest request) {
        if(eduTeacher==null||eduTeacher.getIntro().trim().length()==0||eduTeacher.getName().trim().length()==0||eduTeacher.getRemarks().trim().length()==0){
            return RestResponse.failure("请先填写完整信息！");
        }
        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return RestResponse.failure("请先登录！");
        }

        //根据token,获取登录会员信息
        EduMemberVO eduMemberToken = tokenService.getLoginMember();
        if(eduMemberToken==null){
            return RestResponse.failure("请先登录！");
        }
        // 获取会员信息
        EduMember dbEduMember = memberService.getById(eduMemberToken.getId());
        if(dbEduMember==null){
            return RestResponse.failure("入驻失败,请先注册账号！");
        }else{
            // 获取讲师记录
            EduTeacher dbEduTeacher = teacherService.getById(dbEduMember.getTeacherId());
            if(dbEduTeacher!=null){
                return RestResponse.failure("你已经申请，请勿重复申请！");
            }else{
                dbEduTeacher = new EduTeacher();
                dbEduTeacher.setUpdateId(dbEduMember.getId());
                dbEduTeacher.setCreateId(dbEduMember.getId());
                dbEduTeacher.setIntro(eduTeacher.getIntro());
                dbEduTeacher.setAvatar("http://www.xueden.cn/128.png");
                dbEduTeacher.setLevel(1);
                dbEduTeacher.setName(eduTeacher.getName());
                dbEduTeacher.setRemarks(eduTeacher.getRemarks());
                teacherService.save(dbEduTeacher);
            }
            dbEduMember.setTeacherId(dbEduTeacher.getId());
            dbEduMember.setUpdateId(dbEduMember.getId());
            memberService.updateById(dbEduMember);
        }


        return RestResponse.success("讲师入驻提交信息成功");
    }


}
