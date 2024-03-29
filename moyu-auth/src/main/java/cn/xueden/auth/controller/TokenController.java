package cn.xueden.auth.controller;

import cn.xueden.auth.form.LoginBody;
import cn.xueden.auth.form.LoginMemberBody;
import cn.xueden.auth.service.EduMemberLoginService;
import cn.xueden.auth.service.SysLoginService;
import cn.xueden.common.core.domain.R;
import cn.xueden.common.core.edu.vo.EduMemberVO;
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

    @Autowired
    private EduMemberLoginService eduMemberLoginService;

    @PostMapping("/login")
    public R<?> login(@RequestBody LoginBody form){
        // 用户登录
        LoginUser userInfo = sysLoginService.login(form.getUsername(), form.getPassword());
        // 获取登录token
        return R.ok(tokenService.createToken(userInfo),"登录成功");
    }

    @PostMapping("/member/login")
    public R<?> memberLogin(@RequestBody LoginMemberBody form){
        // 用户登录
        EduMemberVO memberInfo = eduMemberLoginService.login(form.getMobile(),form.getPassword());
        // 获取登录token
        return R.ok(tokenService.createMemberToken(memberInfo),"登录成功");
    }

    @PostMapping("/teacher/login")
    public R<?> techerLogin(@RequestBody LoginMemberBody form){
        // 用户登录
        EduMemberVO memberInfo = eduMemberLoginService.login(form.getMobile(),form.getPassword());
        if(memberInfo!=null&&memberInfo.getIsTeacher()==1){
            // 获取登录token
            return R.ok(tokenService.createMemberToken(memberInfo),"登录成功");
        }else{
            // 获取登录token
            return R.fail(403,"对不起，您不是讲师，请先去申请成为讲师再来登录吧！");
        }

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
