package cn.xueden.auth.service;

import cn.xueden.common.core.constant.Constants;
import cn.xueden.common.core.constant.UserConstants;
import cn.xueden.common.core.domain.R;
import cn.xueden.common.core.enums.UserStatus;
import cn.xueden.common.core.exception.BaseException;
import cn.xueden.common.core.utils.XudenStringUtils;
import cn.xueden.common.core.web.domain.SysUser;
import cn.xueden.common.security.utils.SecurityUtils;
import cn.xueden.system.api.RemoteLogService;
import cn.xueden.system.api.RemoteUserService;
import cn.xueden.system.api.model.LoginUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**功能描述：登录校验方法
 * @Auther:梁志杰
 * @Date:2020/9/25
 * @Description:cn.xueden.auth.service
 * @version:1.0
 */
@Component
public class SysLoginService {

    @Autowired
    private RemoteLogService remoteLogService;

    @Autowired
    private RemoteUserService remoteUserService;

    /**
     * 登录
     */
    public LoginUser login(String username, String password){
        // 用户名或密码为空 错误
        if (XudenStringUtils.isAnyBlank(username, password)){
            remoteLogService.saveLogininfor(username, Constants.LOGIN, "用户/密码必须填写");
            throw new BaseException("用户/密码必须填写");
        }
        // 密码如果不在指定范围内 错误
        if (password.length() < UserConstants.PASSWORD_MIN_LENGTH
                || password.length() > UserConstants.PASSWORD_MAX_LENGTH){
            remoteLogService.saveLogininfor(username, Constants.LOGIN, "用户密码不在指定范围");
            throw new BaseException("用户密码不在指定范围");
        }
        // 用户名不在指定范围内 错误
        if (username.length() < UserConstants.USERNAME_MIN_LENGTH
                || username.length() > UserConstants.USERNAME_MAX_LENGTH){
            remoteLogService.saveLogininfor(username, Constants.LOGIN, "用户名不在指定范围");
            throw new BaseException("用户名不在指定范围");
        }
        // 查询用户信息
        R<LoginUser> userResult = remoteUserService.getUserInfo(username);

        if (R.FAIL == userResult.getCode()){
            throw new BaseException(userResult.getMessage());
        }

        if (XudenStringUtils.isNull(userResult) || XudenStringUtils.isNull(userResult.getData())){
            remoteLogService.saveLogininfor(username, Constants.LOGIN, "登录用户：" + username + " 不存在");
            throw new BaseException("登录用户：" + username + " 不存在");
        }
        LoginUser userInfo = userResult.getData();
        SysUser user = userResult.getData().getSysUser();
        if (UserStatus.DELETED.getCode().equals(user.getDelFlag())){
            remoteLogService.saveLogininfor(username, Constants.LOGIN, "对不起，您的账号：" + username + " 已被删除");
            throw new BaseException("对不起，您的账号：" + username + " 已被删除");
        }
        if (UserStatus.DISABLE.getCode().equals(user.getLocked())){
            remoteLogService.saveLogininfor(username, Constants.LOGIN, "对不起，您的账号：" + username + " 已停用");
            throw new BaseException("对不起，您的账号：" + username + " 已停用");
        }
        if (!SecurityUtils.matchesPassword(password, user.getPassword())){
            remoteLogService.saveLogininfor(username, Constants.LOGIN, "用户不存在/密码错误");
            throw new BaseException("用户不存在/密码错误");
        }
        remoteLogService.saveLogininfor(username, Constants.LOGIN, "登录成功");
        return userInfo;
    }

    /**
     * 记录用户退出日志
     * @param loginName
     */
    public void logout(String loginName){
        remoteLogService.saveLogininfor(loginName, Constants.LOGOUT, "退出成功");
    }
}
