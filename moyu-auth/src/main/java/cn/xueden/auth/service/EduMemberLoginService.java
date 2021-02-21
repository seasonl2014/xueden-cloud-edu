package cn.xueden.auth.service;

import cn.xueden.common.core.constant.Constants;
import cn.xueden.common.core.constant.UserConstants;
import cn.xueden.common.core.domain.R;
import cn.xueden.common.core.edu.vo.EduMemberVO;
import cn.xueden.common.core.exception.BaseException;
import cn.xueden.common.core.utils.XudenStringUtils;
import cn.xueden.common.security.utils.SecurityUtils;
import cn.xueden.edu.api.RemoteMemberService;
import cn.xueden.system.api.RemoteLogService;
import com.alibaba.nacos.common.utils.MD5Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;



/**功能描述：会员登录校验方法
 * @Auther:梁志杰
 * @Date:2021/1/30
 * @Description:cn.xueden.auth.service
 * @version:1.0
 */
@Component
public class EduMemberLoginService {

    @Autowired
    private RemoteLogService remoteLogService;

    @Autowired
    private RemoteMemberService remoteMemberService;

    /**
     * 登录
     */
    public EduMemberVO login(String mobile, String password){

        // 手机号或密码为空 错误
        if (XudenStringUtils.isAnyBlank(mobile, password)){
            remoteLogService.saveLogininfor(mobile, Constants.LOGIN, "手机号/密码必须填写");
            throw new BaseException("手机号/密码必须填写");
        }

        // 密码如果不在指定范围内 错误
        if (password.length() < UserConstants.PASSWORD_MIN_LENGTH
                || password.length() > UserConstants.PASSWORD_MAX_LENGTH){
            remoteLogService.saveLogininfor(mobile, Constants.LOGIN, "会员密码不在指定范围");
            throw new BaseException("会员密码不在指定范围");
        }

        // 手机号不在指定范围内 错误
        if (mobile.length() < UserConstants.MOBILE_MIN_LENGTH){
            remoteLogService.saveLogininfor(mobile, Constants.LOGIN, "手机号不在指定范围");
            throw new BaseException("用户名不在指定范围");
        }

        // 查询用户信息
        R<EduMemberVO> memberResult = remoteMemberService.getMemberInfo(mobile);

        if (R.FAIL == memberResult.getCode()){
            throw new BaseException(memberResult.getMessage());
        }

        if (XudenStringUtils.isNull(memberResult) || XudenStringUtils.isNull(memberResult.getData())){
            remoteLogService.saveLogininfor(mobile, Constants.LOGIN, "登录手机号：" + mobile + " 不存在");
            throw new BaseException("登录手机号：" + mobile + " 不存在");
        }

        EduMemberVO memberInfo = memberResult.getData();
        if (!SecurityUtils.matchesPassword(password, memberInfo.getPassword())){
            remoteLogService.saveLogininfor(mobile, Constants.LOGIN, "手机号不存在/密码错误");
            throw new BaseException("用户不存在/密码错误");
        }

        remoteLogService.saveLogininfor(mobile, Constants.LOGIN, "登录成功");

        return memberInfo;

    }
}
