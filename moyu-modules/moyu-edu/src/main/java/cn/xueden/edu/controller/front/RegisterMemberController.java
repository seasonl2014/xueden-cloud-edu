package cn.xueden.edu.controller.front;

import cn.xueden.common.core.edu.domain.EduKeyword;
import cn.xueden.common.core.edu.domain.EduMember;
import cn.xueden.common.core.edu.vo.EduMemberVO;
import cn.xueden.common.core.edu.vo.PassWordVO;
import cn.xueden.common.core.edu.vo.RegisterMemberVO;
import cn.xueden.common.core.utils.GeetestLib;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.common.core.utils.ToolUtil;
import cn.xueden.common.log.annotation.XudenOtherSystemLog;
import cn.xueden.common.redis.service.RedisService;
import cn.xueden.common.security.utils.SecurityUtils;
import cn.xueden.edu.config.GeetestConfig;
import cn.xueden.edu.dto.GeetestDto;
import cn.xueden.edu.service.IEduMemberService;
import cn.xueden.sms.SendSms;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**功能描述：会员注册控制层
 * @Auther:梁志杰
 * @Date:2021/2/17
 * @Description:cn.xueden.edu.controller.front
 * @version:1.0
 */
@Api(tags = "前台会员注册接口")
@RestController
@RequestMapping("/edu/front/register")
public class RegisterMemberController {

    @Autowired
    private IEduMemberService memberService;

    @Autowired
    private RedisService redisService;

    @Autowired
    private GeetestConfig geetestConfig;

    @ApiOperation(value = "前台会员注册", notes = "前台会员注册")
    @PostMapping("/registerMember")
    @XudenOtherSystemLog("前台会员注册")
    public RestResponse registerMember(@RequestBody RegisterMemberVO registerMemberVO) {
        if(registerMemberVO==null){
            return RestResponse.failure("注册失败，请填写完整信息");
        }
        if(registerMemberVO.getMobile()==null){
            return RestResponse.failure("注册失败，请填写手机号");
        }
        if(registerMemberVO.getPassword()==null){
            return RestResponse.failure("注册失败，请填写密码");
        }
        if(registerMemberVO.getRePassword()==null){
            return RestResponse.failure("注册失败，请填写确认密码");
        }
        if(registerMemberVO.getCode()==null){
            return RestResponse.failure("注册失败，请填写验证码");
        }

        if(!registerMemberVO.getPassword().equals(registerMemberVO.getRePassword())){
            return RestResponse.failure("注册失败，两次输入密码不一致");
        }

        String code = redisService.getCacheObject(registerMemberVO.getMobile());
        if(code==null){
            return RestResponse.failure("注册失败，验证码过期");
        }
        if(!code.equalsIgnoreCase(registerMemberVO.getCode())){
            return RestResponse.failure("注册失败，验证码不正确");
        }
        // 根据手机号查询是否存在
        QueryWrapper<EduMember> memberQueryWrapper = new QueryWrapper<>();
        memberQueryWrapper.eq("mobile",registerMemberVO.getMobile());
        EduMember eduMember = memberService.getOne(memberQueryWrapper);
        if(eduMember!=null){
            return RestResponse.failure("注册失败，该手机号已存在");
        }else{
            eduMember = new EduMember();
        }

        eduMember.setAvatar("http://www.xueden.cn/128.png");
        eduMember.setMobile(registerMemberVO.getMobile());
        eduMember.setPassword(SecurityUtils.encryptPassword(registerMemberVO.getPassword()));
        eduMember.setIsTeacher(0);
        eduMember.setVipId(1l);
        memberService.save(eduMember);
        return RestResponse.success("注册成功");
    }

    @ApiOperation(value = "前台发送会员注册验证码", notes = "前台发送会员注册验证码")
    @PostMapping("/code/{phone}")
    @XudenOtherSystemLog("前台发送会员注册验证码")
    public RestResponse registerCode(@PathVariable String phone,@RequestBody GeetestDto geetestDto) {

        if(phone==null){
            return RestResponse.failure("手机号不能为空");
        }else {
            String code = redisService.getCacheObject(phone);
            if(code!=null){
                return RestResponse.success("验证码已经发到您手机了，请注意查看").setCode(200);
            }else{

                //验证码验证
                GeetestLib gtSdk = new GeetestLib(geetestConfig.getGeetest_id(), geetestConfig.getGeetest_key(),
                        geetestConfig.isNewfailback());

                String challenge = geetestDto.getGeetest_challenge();
                String validate = geetestDto.getGeetest_validate();
                String seccode = geetestDto.getGeetest_seccode();

                //从redis中获取gt-server状态
                int gt_server_status_code = (Integer) redisService.getCacheObject(gtSdk.gtServerStatusSessionKey);

                //从redis中获取userid
                String userid = (String)redisService.getCacheObject("userid");

                //自定义参数,可选择添加
                HashMap<String, String> param = new HashMap<String, String>();
                param.put("user_id", userid); //网站用户id
                param.put("client_type", "web"); //web:电脑上的浏览器；h5:手机上的浏览器，包括移动应用内完全内置的web_view；native：通过原生SDK植入APP应用的方式
                param.put("ip_address", "127.0.0.1"); //传输用户请求验证时所携带的IP

                int gtResult = 0;

                if (gt_server_status_code == 1) {
                    //gt-server正常，向gt-server进行二次验证
                    gtResult = gtSdk.enhencedValidateRequest(challenge, validate, seccode, param);
                    System.out.println(gtResult);
                } else {
                    // gt-server非正常情况下，进行failback模式验证
                    System.out.println("failback:use your own server captcha validate");
                    gtResult = gtSdk.failbackValidateRequest(challenge, validate, seccode);
                    System.out.println(gtResult);
                }

                if(gtResult != 1){
                    return RestResponse.failure("请先通过验证");
                }

                // 根据手机号查询是否存在
                QueryWrapper<EduMember> memberQueryWrapper = new QueryWrapper<>();
                memberQueryWrapper.eq("mobile",phone);
                EduMember eduMember = memberService.getOne(memberQueryWrapper);
                if(eduMember!=null){
                    return RestResponse.failure("验证码发送失败，该手机号已注册");
                }

                SendSms sendSms = new SendSms();
                code = ToolUtil.getRandom();
                JSONObject smsResult = JSONObject.parseObject(sendSms.SendCodeByPhone(code,phone));
                if(null==smsResult){
                    return RestResponse.failure("发送失败");
                }
                String semsResultCode = smsResult.getString("Code");
                if(semsResultCode!=null&&semsResultCode.equalsIgnoreCase("ok")){
                    redisService.setCacheObject(phone,code,30l, TimeUnit.MINUTES);
                }else if (semsResultCode!=null&&semsResultCode.equalsIgnoreCase("isv.MOBILE_NUMBER_ILLEGAL")){
                    return RestResponse.failure("发送失败,手机号码不正确");
                }else {
                    return RestResponse.failure("发送失败");
                }

            }

        }

        return RestResponse.success("验证码已经发到您手机了，请注意查看").setCode(200);
    }

    @ApiOperation(value = "前台发送找回密码验证码", notes = "前台发送找回密码验证码")
    @PostMapping("/find/code/{phone}")
    @XudenOtherSystemLog("前台发送找回密码验证码")
    public RestResponse findPwdCode(@PathVariable String phone) {

        if(phone==null){
            return RestResponse.failure("手机号不能为空");
        }else {
            String code = redisService.getCacheObject(phone);
            if(code!=null){
                return RestResponse.success("验证码已经发到您手机了，请注意查看").setCode(200);
            }else{

                // 根据手机号查询是否存在
                QueryWrapper<EduMember> memberQueryWrapper = new QueryWrapper<>();
                memberQueryWrapper.eq("mobile",phone);
                EduMember eduMember = memberService.getOne(memberQueryWrapper);
                if(eduMember==null){
                    return RestResponse.failure("验证码发送失败，该手机号未注册");
                }

                SendSms sendSms = new SendSms();
                code = ToolUtil.getRandom();
                JSONObject smsResult = JSONObject.parseObject(sendSms.SendCodeByPhone(code,phone));
                if(null==smsResult){
                    return RestResponse.failure("发送失败");
                }
                String semsResultCode = smsResult.getString("Code");
                if(semsResultCode!=null&&semsResultCode.equalsIgnoreCase("ok")){
                    redisService.setCacheObject(phone,code,30l, TimeUnit.MINUTES);
                }else if (semsResultCode!=null&&semsResultCode.equalsIgnoreCase("isv.MOBILE_NUMBER_ILLEGAL")){
                    return RestResponse.failure("发送失败,手机号码不正确");
                }else {
                    return RestResponse.failure("发送失败");
                }

            }

        }

        return RestResponse.success("验证码已经发到您手机了，请注意查看").setCode(200);
    }

    @ApiOperation(value = "会员找回个人密码", notes = "会员找回个人密码")
    @PostMapping("/saveFindPassWord")
    @XudenOtherSystemLog("会员找回个人密码")
    public RestResponse saveFindPassWord(@RequestBody PassWordVO passWordVO, HttpServletRequest request) {

        if(passWordVO==null||passWordVO.getMobile()==null||passWordVO.getCode()==null||passWordVO.getNewPassWord()==null){
            return RestResponse.failure("请填写完整信息！");
        }

        // 根据手机号获取用户信息
        QueryWrapper<EduMember> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("mobile",passWordVO.getMobile());
        EduMember dbEduMember = memberService.getOne(queryWrapper);
        if(dbEduMember==null){
            return RestResponse.failure("找回失败,该手机号未注册！");
        }else{
            if(passWordVO==null){
                return RestResponse.failure("更改失败,请填写完整信息！");
            }

           String code = redisService.getCacheObject(passWordVO.getMobile());
            if(code==null){
                return RestResponse.failure("更改失败,验证码已经过期！");
            }

            if(!code.equalsIgnoreCase(passWordVO.getCode())){
                return RestResponse.failure("更改失败,验证码不正确！");
            }

            if(!passWordVO.getNewPassWord().equalsIgnoreCase(passWordVO.getResNewPassWord())){
                return RestResponse.failure("更改失败,两次输入密码不一致！");
            }

            dbEduMember.setPassword(SecurityUtils.encryptPassword(passWordVO.getNewPassWord()));
            dbEduMember.setUpdateId(dbEduMember.getId());
            memberService.updateById(dbEduMember);
        }


        return RestResponse.success("找回密码成功");
    }

}
