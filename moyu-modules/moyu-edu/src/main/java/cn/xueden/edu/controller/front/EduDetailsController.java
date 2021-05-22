package cn.xueden.edu.controller.front;

import cn.xueden.alipay.config.AliPayConfig;
import cn.xueden.alipay.service.AliPayService;
import cn.xueden.common.core.edu.domain.*;
import cn.xueden.common.core.edu.vo.*;
import cn.xueden.common.core.utils.IPUtil;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.common.log.annotation.XudenOtherSystemLog;

import cn.xueden.edu.dto.PayTypeDto;
import cn.xueden.edu.service.*;
import cn.xueden.wechat.config.WechatConfig;
import cn.xueden.wechat.dto.AmountDto;
import cn.xueden.wechat.dto.WxOrderDto;
import cn.xueden.wechat.service.WxPayService;
import cn.xueden.wechat.utils.ConstantPropertiesUtil;
import cn.xueden.wechat.utils.WxPayUtil;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
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

    @Autowired
    private IEduMemberService memberService;

    @Autowired
    private IEduMemberBuyCourseService memberBuyCourseService;

    @Autowired
    private IEduMemberBuyVipService memberBuyVipService;

    @Autowired
    private IEduEnvironmenParamService eduEnvironmenParamService;

    @Autowired
    private WxPayService wxPayService;

    @Autowired
    private WechatConfig wechatConfig;

    @Autowired
    private AliPayService aliPayService;

    @Autowired
    private AliPayConfig aliPayConfig;

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
        EduCourseVO eduCourseVO = courseService.getVoById(id);


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

            // 获取环境参数
            QueryWrapper<EduEnvironmenParam> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("course_id",id);
            List<EduEnvironmenParam> environmenParamList = eduEnvironmenParamService.list(queryWrapper);
            eduCourseVO.setEnvironmenParams(environmenParamList);

            return RestResponse.success().setData(eduCourseVO);
        }else{
            return RestResponse.failure("查看课程失败");
        }


    }

    /**
     * 购买课程
     * @param id
     * @return
     */
    @ApiOperation(value = "前台购买课程", notes = "前台购买课程")
    @PostMapping("/buy/{id}")
    @XudenOtherSystemLog("会员购买课程")
    public RestResponse buy(@PathVariable Long id,
                            HttpServletRequest request) {
        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return RestResponse.failure("购买失败，请先登录！");
        }
        // 获取用户IP地址
        String ipAddress = IPUtil.getIpAddr(request);
        EduMemberBuyCourse result = courseService.buy(id,token,ipAddress);
        if(result!=null&&result.getIsPayment()==1){
            return RestResponse.failure("您已购买过该课程，无需再购买！");
        }else {
            return  RestResponse.success("订单生成成功").setData(result).setCode(50001);
        }

    }

    /**
     * 购买课程立即付款
     * @param orderNo
     *        订单号
     * @return
     */
    @ApiOperation(value = "前台购买课程付款", notes = "前台购买课程付款")
    @PostMapping("/pay/{orderNo}")
    @XudenOtherSystemLog("购买课程付款")
    public RestResponse pay(@PathVariable String orderNo,
                            @RequestBody PayTypeDto payType,
                            HttpServletRequest request) throws Exception {
        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return RestResponse.failure("付款失败，请先登录！");
        }
        // 获取订单信息
        EduMemberBuyCourse pay=memberBuyCourseService.getByOrderNumber(orderNo);
        if(pay==null){
            return RestResponse.failure("付款失败，订单不存在！");
        }else{
            pay.setPayChannel(payType.getPayType());
            memberBuyCourseService.updatePayment(pay);
        }

        // 获取课程信息
        EduCourseVO eduCourseVO = courseService.edit(pay.getCourseId());
        if(eduCourseVO==null){
            return RestResponse.failure("付款失败，课程不存在！");
        }


        // 生成付款链接
        AmountDto amount = new AmountDto();
        BigDecimal num1 = new BigDecimal(100);
        BigDecimal result3 = num1.multiply(pay.getPrice());

        amount.setTotal(result3.intValue());// 单位是分
        WxOrderDto wxOrderDto = new WxOrderDto();
        wxOrderDto.setAmount(amount);
        wxOrderDto.setOut_trade_no(""+orderNo+"");

        wxOrderDto.setDescription("购买【"+eduCourseVO.getTitle()+"】课程");
        wxOrderDto.setNotify_url(wechatConfig.getNotifyCourseUrl());
        wxOrderDto.setMchid(wechatConfig.getMchId());
        wxOrderDto.setAppid(wechatConfig.getAppId());
        String code="";
        if(payType.getPayType().equalsIgnoreCase("wxpay")){ // 使用微信支付
            code = wxPayService.CreateNativeOrder(wxOrderDto);
        }else{ // 使用支付宝支付
           String responseAliPay = aliPayService.alipayFaceToFacePrecreate(wxOrderDto.getDescription(),orderNo,pay.getPrice().toString());
            if(responseAliPay!=null){
                JSONObject jsonObject = JSONObject.parseObject(responseAliPay);
                String alipay_trade_precreate_response = jsonObject.getString("alipay_trade_precreate_response");
                JSONObject jsonObject1 = JSONObject.parseObject(alipay_trade_precreate_response);
                code = jsonObject1.toJSONString();
            }
        }



        System.out.println("返回支付信息："+code);
        JSONObject jsonObject = JSONObject.parseObject(code);
        return RestResponse.success().setData(jsonObject).setCode(200);

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
        //ipAddress = "180.142.65.253";
        EduMemberBuyVip result = vipTypeService.addVip(eduVipTypeVO.getId(),token,ipAddress);
        if(result==null){
            return RestResponse.failure("加入失败");
        }
        return  RestResponse.success("订单生成成功").setCode(50001).setData(result);

    }

    /**
     * 购买VIP立即付款
     * @param orderNo
     *        订单号
     * @return
     */
    @ApiOperation(value = "前台购买VIP付款", notes = "前台购买VIP付款")
    @PostMapping("/vipPay/{orderNo}")
    @XudenOtherSystemLog("购买VIP付款")
    public RestResponse vipPay(@PathVariable String orderNo,
                               @RequestBody PayTypeDto payType,
                               HttpServletRequest request) throws Exception {
        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return RestResponse.failure("付款失败，请先登录！");
        }

        // 获取订单信息
        EduMemberBuyVip eduMemberBuyVip = memberBuyVipService.getByOrderNumber(orderNo);
        if(eduMemberBuyVip==null){
            return RestResponse.failure("付款失败，请稍候再试！");
        }else {
            eduMemberBuyVip.setPayChannel(payType.getPayType());
            memberBuyVipService.updatePayment(eduMemberBuyVip);
        }

        EduVipType dbEduVipType = eduVipTypeService.getById(eduMemberBuyVip.getVipId());
        if(dbEduVipType==null){
            return RestResponse.failure("付款失败，请稍候再试！");
        }

        // 生成付款链接
        AmountDto amount = new AmountDto();
        BigDecimal num1 = new BigDecimal(100);
        BigDecimal result3 = num1.multiply(eduMemberBuyVip.getPrice());

        amount.setTotal(result3.intValue());// 单位是分
        WxOrderDto wxOrderDto = new WxOrderDto();
        wxOrderDto.setAmount(amount);
        wxOrderDto.setOut_trade_no(""+orderNo+"");

        wxOrderDto.setDescription("用户购买【"+dbEduVipType.getName()+"】");
        wxOrderDto.setNotify_url(wechatConfig.getNotifyVipUrl());
        wxOrderDto.setMchid(wechatConfig.getMchId());
        wxOrderDto.setAppid(wechatConfig.getAppId());
        String code="";
        if(payType.getPayType().equalsIgnoreCase("wxpay")){ // 使用微信支付
            code = wxPayService.CreateNativeOrder(wxOrderDto);
        }else{ // 使用支付宝支付
            String responseAliPay = aliPayService.alipayFaceToFacePrecreate(wxOrderDto.getDescription(),orderNo,eduMemberBuyVip.getPrice().toString(),aliPayConfig.getNotifyVipUrl());
            if(responseAliPay!=null){
                JSONObject jsonObject = JSONObject.parseObject(responseAliPay);
                String alipay_trade_precreate_response = jsonObject.getString("alipay_trade_precreate_response");
                JSONObject jsonObject1 = JSONObject.parseObject(alipay_trade_precreate_response);
                code = jsonObject1.toJSONString();
            }
        }
        System.out.println("返回支付信息："+code);
        JSONObject jsonObject = JSONObject.parseObject(code);
        return RestResponse.success().setData(jsonObject).setCode(200);

    }




}
