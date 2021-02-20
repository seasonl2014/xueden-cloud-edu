package cn.xueden.edu.controller.front;

import cn.xueden.common.core.edu.domain.EduKeyword;
import cn.xueden.common.core.edu.domain.EduMember;
import cn.xueden.common.core.edu.vo.EduMemberVO;
import cn.xueden.common.core.edu.vo.PassWordVO;
import cn.xueden.common.core.edu.vo.RegisterMemberVO;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.common.core.utils.ToolUtil;
import cn.xueden.common.log.annotation.XudenOtherSystemLog;
import cn.xueden.common.redis.service.RedisService;
import cn.xueden.common.security.utils.SecurityUtils;
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
    public RestResponse registerCode(@PathVariable String phone) {

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
