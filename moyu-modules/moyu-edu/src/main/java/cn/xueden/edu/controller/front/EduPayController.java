package cn.xueden.edu.controller.front;

import cn.xueden.common.core.edu.domain.EduDealMoney;
import cn.xueden.common.core.edu.domain.EduMember;
import cn.xueden.common.core.edu.domain.EduMemberBuyCourse;
import cn.xueden.common.core.edu.domain.EduMemberBuyVip;
import cn.xueden.edu.dto.WxCiphertextDto;
import cn.xueden.edu.dto.WxResultDto;
import cn.xueden.edu.service.*;
import cn.xueden.edu.websocket.WebSocketServer;
import cn.xueden.wechat.config.WechatConfig;
import com.alibaba.fastjson.JSON;
import com.alipay.easysdk.factory.Factory;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Base64Utils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.crypto.Cipher;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import java.nio.charset.StandardCharsets;
import java.security.GeneralSecurityException;
import java.security.Security;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

/**
 * @Auther:梁志杰
 * @Date:2021/5/21
 * @Description:cn.xueden.edu.controller.front
 * @version:1.0
 */
@RestController
@Api(tags = "支付返回接口")
@RequestMapping("/edu/pay")
@Slf4j
public class EduPayController {

    @Autowired
    private WechatConfig wechatConfig;

    @Autowired
    private IEduMemberBuyCourseService memberBuyCourseService;

    @Autowired
    private IEduDealMoneyService dealMoneyService;

    @Autowired
    private IEduCourseService courseService;

    @Autowired
    private IEduMemberBuyVipService memberBuyVipService;

    @Autowired
    private IEduMemberService memberService;

    /**
     * 购买课程微信支付返回通知
     * 通知频率为15s/15s/30s/3m/10m/20m/30m/30m/30m/60m/3h/3h/3h/6h/6h - 总计 24h4m
     */
    @ApiOperation("购买课程微信支付返回通知")
    @RequestMapping("/wxCourseCallback")
    public Map<String,Object> wxCallback(@RequestBody WxResultDto wxResultDto){
        log.info("购买VIP微信支付开始返回通知");
        Map<String,Object> returnMap = new HashMap<>();
        try {
            if (Security.getProvider("BC") == null) {
                Security.addProvider(new BouncyCastleProvider());
            }
            log.info("algorithm",wxResultDto.getResource().getAlgorithm());
            log.info("nonce",wxResultDto.getResource().getNonce());
            log.info("associated_data",wxResultDto.getResource().getAssociated_data());

            String nonce = wxResultDto.getResource().getNonce();
            String associatedData = wxResultDto.getResource().getAssociated_data();
            String ciphertext = wxResultDto.getResource().getCiphertext();
            //使用key、nonce和associated_data，对数据密文resource.ciphertext进行解密，得到JSON形式的资源对象
            Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding", "BC");
            SecretKeySpec key = new SecretKeySpec(wechatConfig.getAPIv3key().getBytes(StandardCharsets.UTF_8), "AES");
            GCMParameterSpec spec = new GCMParameterSpec(128, nonce.getBytes(StandardCharsets.UTF_8));

            cipher.init(Cipher.DECRYPT_MODE, key, spec);
            cipher.updateAAD(associatedData.getBytes(StandardCharsets.UTF_8));

            byte[] bytes;
            try {
                bytes = cipher.doFinal(Base64Utils.decodeFromString(ciphertext));
                String rt = new String(bytes, StandardCharsets.UTF_8);
                WxCiphertextDto wxCiphertextDto= JSON.parseObject(rt,WxCiphertextDto.class);
                if(wxCiphertextDto!=null&& wxCiphertextDto.getTrade_state().equals("SUCCESS")){ // 支付成功
                    String Out_trade_no = wxCiphertextDto.getOut_trade_no();
                    if(Out_trade_no!=null){
                        EduMemberBuyCourse pay=memberBuyCourseService.getByOrderNumber(Out_trade_no);
                        //获取成交金额记录
                        EduDealMoney eduDealMoney = dealMoneyService.getByOrderNumber(Out_trade_no);
                        // 插入一条记录
                        if(eduDealMoney==null){
                            eduDealMoney = new EduDealMoney();
                            eduDealMoney.setOrderNo(Out_trade_no);
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
                            WebSocketServer.sendInfo(json,Out_trade_no);
                        } catch (JsonProcessingException e) {
                            e.printStackTrace();
                        }

                    }

                }
                log.info("out_trade_no微信支付返回处理结果："+rt);
            } catch (GeneralSecurityException e) {
                e.printStackTrace();
            }


        }catch (Exception e) {
            log.info("微信支付返回通知，失败处理结束");
            log.error(e.getMessage(),e);
            returnMap.put("code","ERROR");
            returnMap.put("message","失败");
            return returnMap;
        }
        log.info("微信支付结束返回通知");
        returnMap.put("code","SUCCESS");
        returnMap.put("message","成功");
        return returnMap;
    }

    /**
     * 购买VIP微信支付返回通知
     * 通知频率为15s/15s/30s/3m/10m/20m/30m/30m/30m/60m/3h/3h/3h/6h/6h - 总计 24h4m
     */
    @ApiOperation("购买VIP微信支付返回通知")
    @RequestMapping("/wxVipCallback")
    public Map<String,Object> wxVipCallback(@RequestBody WxResultDto wxResultDto){
        log.info("购买VIP微信支付开始返回通知");
        Map<String,Object> returnMap = new HashMap<>();
        try {
            if (Security.getProvider("BC") == null) {
                Security.addProvider(new BouncyCastleProvider());
            }
            log.info("algorithm",wxResultDto.getResource().getAlgorithm());
            log.info("nonce",wxResultDto.getResource().getNonce());
            log.info("associated_data",wxResultDto.getResource().getAssociated_data());

            String nonce = wxResultDto.getResource().getNonce();
            String associatedData = wxResultDto.getResource().getAssociated_data();
            String ciphertext = wxResultDto.getResource().getCiphertext();
            //使用key、nonce和associated_data，对数据密文resource.ciphertext进行解密，得到JSON形式的资源对象
            Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding", "BC");
            SecretKeySpec key = new SecretKeySpec(wechatConfig.getAPIv3key().getBytes(StandardCharsets.UTF_8), "AES");
            GCMParameterSpec spec = new GCMParameterSpec(128, nonce.getBytes(StandardCharsets.UTF_8));

            cipher.init(Cipher.DECRYPT_MODE, key, spec);
            cipher.updateAAD(associatedData.getBytes(StandardCharsets.UTF_8));

            byte[] bytes;
            try {
                bytes = cipher.doFinal(Base64Utils.decodeFromString(ciphertext));
                String rt = new String(bytes, StandardCharsets.UTF_8);
                WxCiphertextDto wxCiphertextDto= JSON.parseObject(rt,WxCiphertextDto.class);
                if(wxCiphertextDto!=null&& wxCiphertextDto.getTrade_state().equals("SUCCESS")){ // 支付成功
                    String Out_trade_no = wxCiphertextDto.getOut_trade_no();
                    if(Out_trade_no!=null){
                        EduMemberBuyVip pay=memberBuyVipService.getByOrderNumber(Out_trade_no);
                        if(pay!=null&&pay.getIsPayment()!=0){
                            returnMap.put("code","SUCCESS");
                            returnMap.put("message","成功");
                            return returnMap;
                        }

                        //获取成交金额记录
                        EduDealMoney eduDealMoney = dealMoneyService.getByOrderNumber(Out_trade_no);
                        // 插入一条记录
                        if(eduDealMoney==null){
                            eduDealMoney = new EduDealMoney();
                            eduDealMoney.setOrderNo(Out_trade_no);
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
                            WebSocketServer.sendInfo(json,Out_trade_no);
                        } catch (JsonProcessingException e) {
                            e.printStackTrace();
                        }

                    }

                }
                log.info("out_trade_no微信支付返回处理结果："+rt);
            } catch (GeneralSecurityException e) {
                e.printStackTrace();
            }


        }catch (Exception e) {
            log.info("微信支付返回通知，失败处理结束");
            log.error(e.getMessage(),e);
            returnMap.put("code","ERROR");
            returnMap.put("message","失败");
            return returnMap;
        }
        log.info("微信支付结束返回通知");
        returnMap.put("code","SUCCESS");
        returnMap.put("message","成功");
        return returnMap;
    }



    /**
     * 购买课程支付宝返回通知
     */
    @ApiOperation("购买课程支付宝支付返回通知")
    @RequestMapping("/aliCourseCallback")
    public String aliCourseCallback(HttpServletRequest request){
        log.info("购买课程支付宝支付开始返回通知");
        try {
            Map<String, String> params = getAllRequestParam(request);
            if (!Factory.Payment.Common().verifyNotify(params)) {
                System.out.println("校验失败");
                return "fail";
            }
            String trade_status = params.get("trade_status");

            if (trade_status.equals("TRADE_SUCCESS")) {
                String outTradeNo = params.get("out_trade_no");
                if(outTradeNo!=null){ // 订单编号
                    EduMemberBuyCourse pay=memberBuyCourseService.getByOrderNumber(outTradeNo);
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


                }
                System.out.println("支付宝支付成功：" + trade_status);
                log.info("支付宝支付返回通知，正确处理结束");
                return "success";
            }
        } catch (Exception e) {
            log.info("支付宝支付返回通知，失败处理结束");
            log.error(e.getMessage(),e);
        }
        return "success";
    }

    /**
     * 购买VIP支付宝支付返回通知
     */
    @ApiOperation("购买VIP支付宝支付返回通知")
    @RequestMapping("/aliVipCallback")
    public String aliVipCallback(HttpServletRequest request){
        log.info("购买VIP支付宝支付开始返回通知");
        try {
            Map<String, String> params = getAllRequestParam(request);
            if (!Factory.Payment.Common().verifyNotify(params)) {
                System.out.println("校验失败");
                return "fail";
            }
            String trade_status = params.get("trade_status");

            if (trade_status.equals("TRADE_SUCCESS")) {
                String outTradeNo = params.get("out_trade_no");
                if(outTradeNo!=null){ // 订单编号
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


                }
                System.out.println("支付宝支付成功：" + trade_status);
                log.info("支付宝支付返回通知，正确处理结束");
                return "success";
            }
        } catch (Exception e) {
            log.info("支付宝支付返回通知，失败处理结束");
            log.error(e.getMessage(),e);
        }
        return "success";
    }

    /**
     * 功能描述：得到支付宝请求的参数
     * @param request
     * @return
     */
    private Map<String, String> getAllRequestParam(final HttpServletRequest request) {
        Map<String, String> res = new HashMap<>();
        Enumeration<?> temp = request.getParameterNames();
        while (temp.hasMoreElements()) {
            String en = (String) temp.nextElement();
            String value = request.getParameter(en);
            res.put(en, value);
        }
        return res;
    }


}
