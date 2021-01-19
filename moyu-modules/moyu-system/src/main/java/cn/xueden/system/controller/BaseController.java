package cn.xueden.system.controller;


import cn.xueden.system.service.LogService;
import cn.xueden.system.service.MenuService;
import cn.xueden.system.service.RoleService;
import cn.xueden.system.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;

/**功能描述：基础Controller类
 * @Auther:梁志杰
 * @Date:2020/9/25
 * @Description:cn.xueden.system.controller
 * @version:1.0
 */
public class BaseController {
    @Autowired
    protected UserService userService;

    @Autowired
    protected MenuService menuService;

    @Autowired
    protected RoleService roleService;

    @Autowired
    protected LogService logService;


    /**
     * 功能描述：获取当前用户信息
     * @return
     *//*
    public User getCurrentUser(){

        ShiroUser shiroUser = (ShiroUser)SecurityUtils.getSubject().getPrincipal();
        if(null==shiroUser){
            return null ;
        }

        User loginUser = userService.selectById(shiroUser.getId());
        return loginUser;
    }*/
}

