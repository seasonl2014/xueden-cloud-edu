package cn.xueden.edu.controller.teacher;

import cn.xueden.alivod.utils.AliyunVODSDKUtils;
import cn.xueden.alivod.utils.ConstantPropertiesUtil;
import cn.xueden.common.core.edu.domain.*;
import cn.xueden.common.core.edu.vo.EduMemberVO;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.common.security.service.TokenService;
import cn.xueden.edu.service.*;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.vod.model.v20170321.GetVideoPlayAuthRequest;
import com.aliyuncs.vod.model.v20170321.GetVideoPlayAuthResponse;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**功能描述：讲师平台首页控制层
 * @Auther:梁志杰
 * @Date:2021/5/26
 * @Description:cn.xueden.edu.controller.teacher
 * @version:1.0
 */
@Api(tags = "讲师平台首页接口")
@RestController
@RequestMapping("/edu/teacher/index")
public class EduTeacherIndexController {

    @Autowired
    private TokenService tokenService;

    @Autowired
    private IEduTeacherService teacherService;

    @Autowired
    private IEduCourseService educourseService;

    @Autowired
    private IEduMemberBuyCourseService eduMemberBuyCourseService;

    @Autowired
    private IEduDailyReportService eduDailyReportService;

    @Autowired
    private IEduCashOutDetailsService eduCashOutDetailsService;


    /**
     *  统计讲师累计收入和可提现金额,学生数量、课程数量
     * @param request
     * @return
     */
    @GetMapping
    public RestResponse total(HttpServletRequest request){
        Map<String,Object> map = new HashMap<>();

        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return null;
        }

        //根据token,获取登录会员信息
        EduMemberVO eduMemberVO = tokenService.getLoginMember();
        if(eduMemberVO==null){
            return null;
        }
        EduTeacher dbTeacher = teacherService.getById(eduMemberVO.getTeacherId());
        if(dbTeacher==null){
            return RestResponse.failure("您不是讲师");
        }

        // 统计我的课程
        QueryWrapper<EduCourse> courseQueryWrapper = new QueryWrapper();
        courseQueryWrapper.eq("teacher_id",dbTeacher.getId());
        int courseTotal = educourseService.count(courseQueryWrapper);

        // 统计我的学生，根据购买课程记录表统计
        QueryWrapper<EduMemberBuyCourse> memberBuyCourseQueryWrapper = new QueryWrapper();
        memberBuyCourseQueryWrapper.eq("teacher_id",dbTeacher.getId());
        int memberBuyCourseTotal = eduMemberBuyCourseService.count(memberBuyCourseQueryWrapper);

        map.put("memberBuyCourseTotal",memberBuyCourseTotal); // 我的学生
        map.put("courseTotal",courseTotal); // 我的课程
        map.put("cashOutMoney",dbTeacher.getCashOutMoney()); // 可提现金额
        map.put("incomeAmount",dbTeacher.getIncomeAmount()); // 累计收入
        return RestResponse.success().setData(map);

    }

    /**
     *  统计本月和上月订单数量和讲师收益
     * @param request
     * @return
     */
    @GetMapping("/getDailyReportList")
    public RestResponse getDailyReportList(HttpServletRequest request){
        Map<String,Object> map = new HashMap<>();

        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return null;
        }

        //根据token,获取登录会员信息
        EduMemberVO eduMemberVO = tokenService.getLoginMember();
        if(eduMemberVO==null){
            return null;
        }
        EduTeacher dbTeacher = teacherService.getById(eduMemberVO.getTeacherId());
        if(dbTeacher==null){
            return RestResponse.failure("您不是讲师");
        }

        // 统计本月订单和收益情况
        LocalDate localDate = LocalDate.now();
        // 获取本月第一天
        LocalDate firstDayOfThisMonth = localDate.with(TemporalAdjusters.firstDayOfMonth());
        // 取本月最后一天
        LocalDate lastDayOfThisMonth = localDate.with(TemporalAdjusters.lastDayOfMonth());
        QueryWrapper<EduDailyReport> eduDailyReportQueryWrapper = new QueryWrapper();
        eduDailyReportQueryWrapper.eq("teacher_id",dbTeacher.getId());
        eduDailyReportQueryWrapper.ge("create_time",firstDayOfThisMonth);
        eduDailyReportQueryWrapper.le("create_time",lastDayOfThisMonth);
        List<EduDailyReport> sameMonthList = eduDailyReportService.list(eduDailyReportQueryWrapper); // 获取当月数据
        map.put("sameMonthDaysNos",sameMonthList.stream().map(EduDailyReport::getDayNo).collect(Collectors.toList())); // 天
        map.put("sameMonthOrderNum",sameMonthList.stream().map(EduDailyReport::getOrderNum).collect(Collectors.toList())); // 订单数量
        map.put("sameMonthIncomeMoney",sameMonthList.stream().map(EduDailyReport::getIncomeMoney).collect(Collectors.toList())); // 讲师收入

        // 统计上月月订单和收益情况

        localDate = localDate.minusMonths(1);
        // 获取上月第一天
        LocalDate firstDayOfLastMonth = localDate.with(TemporalAdjusters.firstDayOfMonth());
        // 取上月最后一天
        LocalDate lastDayOfLastMonth = localDate.with(TemporalAdjusters.lastDayOfMonth());
        QueryWrapper<EduDailyReport> lastMonthEduDailyReportQueryWrapper = new QueryWrapper();
        lastMonthEduDailyReportQueryWrapper.eq("teacher_id",dbTeacher.getId());
        lastMonthEduDailyReportQueryWrapper.ge("create_time",firstDayOfLastMonth);
        lastMonthEduDailyReportQueryWrapper.le("create_time",lastDayOfLastMonth);
        List<EduDailyReport> lastMonthList = eduDailyReportService.list(lastMonthEduDailyReportQueryWrapper); // 获取当月数据
        map.put("lastMonthDaysNos",lastMonthList.stream().map(EduDailyReport::getDayNo).collect(Collectors.toList())); // 天
        map.put("lastMonthOrderNum",lastMonthList.stream().map(EduDailyReport::getOrderNum).collect(Collectors.toList())); // 订单数量
        map.put("lastMonthIncomeMoney",lastMonthList.stream().map(EduDailyReport::getIncomeMoney).collect(Collectors.toList())); // 讲师收入


        return RestResponse.success().setData(map);

    }
    /**
     *  讲师申请提现
     * @param request
     * @return
     */
    @PostMapping("/apply")
    public RestResponse apply(@RequestBody EduCashOutDetails eduCashOutDetails,HttpServletRequest request){
        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return null;
        }

        //根据token,获取登录会员信息
        EduMemberVO eduMemberVO = tokenService.getLoginMember();
        if(eduMemberVO==null){
            return null;
        }
        EduTeacher dbTeacher = teacherService.getById(eduMemberVO.getTeacherId());
        if(dbTeacher==null){
            return RestResponse.failure("您不是讲师");
        }
        eduCashOutDetails.setTeacherId(dbTeacher.getId());
        eduCashOutDetails.setCreateId(dbTeacher.getId());
        eduCashOutDetails.setUpdateId(dbTeacher.getId());
        eduCashOutDetails.setBankCard(dbTeacher.getCardNumber());
        eduCashOutDetails.setName(dbTeacher.getPayeeName());
        eduCashOutDetails.setStatus(0);
        eduCashOutDetailsService.save(eduCashOutDetails);

        // 结算可提现金额
        dbTeacher.setCashOutMoney(dbTeacher.getCashOutMoney().subtract(BigDecimal.valueOf(eduCashOutDetails.getCashOut())));
        dbTeacher.setUpdateId(dbTeacher.getId());
        teacherService.updateById(dbTeacher);
        return RestResponse.success();
    }

    /**
     * 获取讲师个人信息
     * @param request
     * @return
     */
    @GetMapping("/getTeacherInfo")
    public RestResponse getTeacherInfo(HttpServletRequest request){
        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return null;
        }

        //根据token,获取登录会员信息
        EduMemberVO eduMemberVO = tokenService.getLoginMember();
        if(eduMemberVO==null){
            return null;
        }
        EduTeacher dbTeacher = teacherService.getById(eduMemberVO.getTeacherId());
        if(dbTeacher==null){
            return RestResponse.failure("您不是讲师");
        }

        return RestResponse.success().setData(dbTeacher);
    }

    /**
     * 修改讲师个人信息
     * @param request
     * @return
     */
    @PutMapping("/updateTeacher")
    public RestResponse updateTeacher(@RequestBody EduTeacher eduTeacher,HttpServletRequest request){
        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return null;
        }

        //根据token,获取登录会员信息
        EduMemberVO eduMemberVO = tokenService.getLoginMember();
        if(eduMemberVO==null){
            return null;
        }
        EduTeacher dbTeacher = teacherService.getById(eduMemberVO.getTeacherId());
        if(dbTeacher==null){
            return RestResponse.failure("您不是讲师");
        }
        dbTeacher.setPayeeName(eduTeacher.getPayeeName());
        dbTeacher.setCardNumber(eduTeacher.getCardNumber());
        dbTeacher.setBank(eduTeacher.getBank());
        dbTeacher.setUpdateId(dbTeacher.getId());
        teacherService.updateById(dbTeacher);
        return RestResponse.success("绑定成功");
    }


}
