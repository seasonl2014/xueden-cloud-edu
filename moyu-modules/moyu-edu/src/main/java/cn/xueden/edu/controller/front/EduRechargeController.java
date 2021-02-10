package cn.xueden.edu.controller.front;

import cn.xueden.common.core.edu.domain.EduDealMoney;
import cn.xueden.common.core.edu.domain.EduMember;
import cn.xueden.common.core.edu.domain.EduMemberBuyCourse;
import cn.xueden.common.core.edu.domain.EduMemberBuyVip;
import cn.xueden.edu.service.*;
import cn.xueden.edu.websocket.WebSocketServer;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**功能描述：YunGouOS平台回调方法
 * @Auther:梁志杰
 * @Date:2021/2/9
 * @Description:cn.xueden.edu.controller.front
 * @version:1.0
 */
@Api(tags = "支付接口")
@RestController
@RequestMapping("/edu/recharge")
public class EduRechargeController {

    @Autowired
    private IEduMemberBuyCourseService memberBuyCourseService;

    @Autowired
    private IEduDealMoneyService dealMoneyService;

    @Autowired
    private IEduMemberBuyVipService memberBuyVipService;

    @Autowired
    private IEduMemberService memberService;

    @Autowired
    private IEduCourseService courseService;

    /**
     * 购买课程回调地址
     * @param request
     * @return
     * @throws IOException
     */
    @RequestMapping("/courseNotifyUrl")
    public String courseNotifyUrl(HttpServletRequest request) throws IOException {
        System.out.println("------------------------是否进入到回调方法");
        String code = request.getParameter("code");
        System.out.println("------------------------请求参数code："+code);
        String outTradeNo = request.getParameter("outTradeNo");
        System.out.println("------------------------请求参数outTradeNo："+outTradeNo);
        String money = request.getParameter("money");
        System.out.println("------------------------请求参数money："+money);
        String msg = "恭喜您购买成功";
        if(code.equals("1")){

            EduMemberBuyCourse pay=memberBuyCourseService.getByOrderNumber(outTradeNo);
            if(pay!=null&&pay.getIsPayment()!=0){
                return "SUCCESS";
            }

            //获取成交金额记录
            EduDealMoney eduDealMoney = dealMoneyService.getByOrderNumber(outTradeNo);
            // 插入一条记录
            if(eduDealMoney==null){
                eduDealMoney = new EduDealMoney();
                eduDealMoney.setOrderNo(outTradeNo);
                eduDealMoney.setCountry(pay.getCountry());
                eduDealMoney.setArea(pay.getArea());
                eduDealMoney.setProvince(pay.getProvince());
                eduDealMoney.setCity(pay.getCity());
                eduDealMoney.setIsp(pay.getIsp());
                eduDealMoney.setBuyType(pay.getBuyType());
                eduDealMoney.setMemberId(pay.getMemberId());
                eduDealMoney.setPrice(pay.getPrice());
                eduDealMoney.setCreateId(pay.getMemberId());
                eduDealMoney.setUpdateId(pay.getMemberId());
                eduDealMoney.setRemarks(pay.getRemarks());
                eduDealMoney.setPayChannel(pay.getPayChannel());
                dealMoneyService.save(eduDealMoney);
            }


            //更新状态
            pay.setIsPayment(1);//已付款
            memberBuyCourseService.updatePayment(pay);

            //更新课程购买数量
            courseService.updateBuyCount(pay.getCourseId());

            try {
                Map<String, Object> map = new HashMap<String, Object>();
                ObjectMapper mapper = new ObjectMapper();
                map.put("status", 1);
                map.put("msg", "支付成功,课程资料请到个人中心我的课程下载！");
                String json = mapper.writeValueAsString(map);
                WebSocketServer.sendInfo(json,outTradeNo);
            } catch (JsonProcessingException e) {
                e.printStackTrace();
            }

        }else{
            return "FAILURE";
        }
        return "SUCCESS";
    }

    /**
     * 加入VIP回调地址
     * @param request
     * @return
     * @throws IOException
     */
    @RequestMapping("/vipNotifyUrl")
    public String vipNotifyUrl(HttpServletRequest request) throws IOException {
        System.out.println("------------------------是否进入到回调方法");
        String code = request.getParameter("code");
        System.out.println("------------------------请求参数code："+code);
        String outTradeNo = request.getParameter("outTradeNo");
        System.out.println("------------------------请求参数outTradeNo："+outTradeNo);
        String money = request.getParameter("money");
        System.out.println("------------------------请求参数money："+money);
        String msg = "恭喜您购买成功";
        if(code.equals("1")){

            EduMemberBuyVip pay=memberBuyVipService.getByOrderNumber(outTradeNo);
            if(pay!=null&&pay.getIsPayment()!=0){
                return "SUCCESS";
            }

            //获取成交金额记录
            EduDealMoney eduDealMoney = dealMoneyService.getByOrderNumber(outTradeNo);
            // 插入一条记录
            if(eduDealMoney==null){
                eduDealMoney = new EduDealMoney();
                eduDealMoney.setOrderNo(outTradeNo);
                eduDealMoney.setCountry(pay.getCountry());
                eduDealMoney.setArea(pay.getArea());
                eduDealMoney.setProvince(pay.getProvince());
                eduDealMoney.setCity(pay.getCity());
                eduDealMoney.setIsp(pay.getIsp());
                eduDealMoney.setBuyType(pay.getVipId());
                eduDealMoney.setMemberId(pay.getMemberId());
                eduDealMoney.setPrice(pay.getPrice());
                eduDealMoney.setUpdateId(pay.getMemberId());
                eduDealMoney.setCreateId(pay.getMemberId());
                eduDealMoney.setRemarks(pay.getRemarks());
                eduDealMoney.setPayChannel(pay.getPayChannel());
                dealMoneyService.save(eduDealMoney);
            }

            //更新状态
            pay.setIsPayment(1);//已付款
            memberBuyVipService.updatePayment(pay);

            // 更新用户的会员类型
            EduMember tempEduMember = new EduMember();
            tempEduMember.setVipId(pay.getVipId());
            tempEduMember.setId(pay.getMemberId());
            memberService.updateVip(tempEduMember);

            try {
                Map<String, Object> map = new HashMap<String, Object>();
                ObjectMapper mapper = new ObjectMapper();
                map.put("status", 1);
                map.put("msg", "支付成功,请退出网站，重新登录！");
                String json = mapper.writeValueAsString(map);
                WebSocketServer.sendInfo(json,outTradeNo);
            } catch (JsonProcessingException e) {
                e.printStackTrace();
            }

        }else{
            return "FAILURE";
        }
        return "SUCCESS";
    }


    /**
     *
     * @param request
     * @return
     * @throws IOException
     */
    @RequestMapping("/vipNotifyUrl2")
    public String testNotifyUrl2(HttpServletRequest request) throws IOException {
        try {
            String outTradeNo="2021020900001000030020384427";
            Map<String, Object> map = new HashMap<String, Object>();
            ObjectMapper mapper = new ObjectMapper();
            map.put("status", 1);
            map.put("msg", "支付成功,请退出网站，重新登录！");
            String json = mapper.writeValueAsString(map);
            WebSocketServer.sendInfo(json,outTradeNo);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return "SUCCESS";
    }


}
