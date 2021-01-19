package cn.xueden.auth.controller;

import cn.xueden.auth.form.LoginBody;
import cn.xueden.auth.service.SysLoginService;
import cn.xueden.common.core.domain.R;
import cn.xueden.common.core.utils.XudenStringUtils;
import cn.xueden.common.security.service.TokenService;
import cn.xueden.system.api.model.LoginUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

/**功能描述：token 控制
 * @Auther:梁志杰
 * @Date:2020/9/25
 * @Description:cn.xueden.auth.controller
 * @version:1.0
 */
@RestController
public class TokenController {

    @Autowired
    private TokenService tokenService;

    @Autowired
    private SysLoginService sysLoginService;

    @PostMapping("/login")
    public R<?> login(@RequestBody LoginBody form){
        // 用户登录
        LoginUser userInfo = sysLoginService.login(form.getUsername(), form.getPassword());
        // 获取登录token
        return R.ok(tokenService.createToken(userInfo),"登录成功");
    }

    @DeleteMapping("/logout")
    public R<?> logout(HttpServletRequest request){
        LoginUser loginUser = tokenService.getLoginUser(request);
        if (XudenStringUtils.isNotNull(loginUser))
        {
            String username = loginUser.getUsername();
            // 删除用户缓存记录
            tokenService.delLoginUser(loginUser.getToken());
            // 记录用户退出日志
            sysLoginService.logout(username);
        }
        return R.ok();
    }

}
