package cn.xueden.system.controller;


import cn.xueden.common.core.utils.LayerData;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.common.core.web.domain.SysMenu;
import cn.xueden.common.core.web.domain.SysRole;
import cn.xueden.common.core.web.domain.SysUser;

import cn.xueden.common.log.annotation.XudenSysLog;
import cn.xueden.common.security.annotation.PreAuthorize;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.google.common.collect.Maps;
import jakarta.servlet.ServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.WebUtils;


import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**功能描述:用户角色 前端控制器
 * @Auther:http://www.xueden.cn
 * @Date:2020/2/25
 * @Description:cn.xueden.modules.system.controller
 * @version:1.0
 */
@RestController
@RequestMapping("system/role")
public class RoleController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(RoleController.class);

    /**
     * 获取角色列表
     * @param page
     * @param limit
     * @param request
     * @return
     */
    @XudenSysLog("获取角色列表数据")
    @PreAuthorize(hasPermi = "sys:role:list")
    @PostMapping("list")
    public LayerData<SysRole> list(@RequestParam(value = "page",defaultValue = "1")Integer page,
                                @RequestParam(value = "limit",defaultValue = "10")Integer limit,
                                ServletRequest request){

        Map map = WebUtils.getParametersStartingWith(request,"s_");
        LayerData<SysRole> roleLayerData = new LayerData<>();
        QueryWrapper<SysRole> roleEntityWrapper = new QueryWrapper<>();
        // roleEntityWrapper.eq("del_flag",false);
        //查询条件
        if(!map.isEmpty()){
            String keys = (String)map.get("key");
            if(StringUtils.isNotBlank(keys)){
                roleEntityWrapper.like("name",keys);
            }
        }

        Page<SysRole> rolePage = roleService.page(new Page<>(page,limit),roleEntityWrapper);
        roleLayerData.setCount(rolePage.getTotal());
        roleLayerData.setData(setUserToRole(rolePage.getRecords()));
        return  roleLayerData;
    }

    //根据创建者id或者更新者id得到用户名称
    private List<SysRole> setUserToRole(List<SysRole> roles){
        for (SysRole r:roles){
            if(r.getCreateId()!=null && r.getCreateId()!=0){//用户id,创建者id
                SysUser u = userService.findUserById(r.getCreateId());
                if(StringUtils.isBlank(u.getNickName())){
                    u.setNickName(u.getLoginName());
                }
                r.setCreateUser(u);
            }

            if(r.getUpdateId()!=null && r.getUpdateId()!=0){//用户id,修改者id
                SysUser u = userService.findUserById(r.getUpdateId());
                if(StringUtils.isBlank(u.getNickName())){
                    u.setNickName(u.getLoginName());
                }
                r.setUpdateUser(u);
            }
        }

        return roles;
    }

    /**
     * 功能描述：获取所有菜单
     * @return
     */
    @GetMapping("getAllMenusList")
    public RestResponse getAllMenusList(){
        Map<String,Object> map = Maps.newHashMap();
        map.put("parentId",null);
        map.put("isShow",false);
        List<SysMenu> menuList = menuService.selectAllMenus(map);
        return RestResponse.success().setData(menuList);

    }

    /**
     * 功能描述： 新增用户角色（前端layui项目使用）
     * @param role
     * @return
     */
    @XudenSysLog("新增角色数据")
    @PreAuthorize(hasPermi = "sys:role:add")
    @PostMapping("add")
    public RestResponse add(@RequestBody SysRole role){
        if(StringUtils.isBlank(role.getName())){
            return RestResponse.failure("角色名称不能为空");
        }
        if(roleService.getRoleNameCount(role.getName())>0){
            return RestResponse.failure("角色名称已经存在");
        }

        roleService.saveRole(role);
        return RestResponse.success();
    }

    /**
     * 功能描述： 新增用户角色（前端vue3项目使用）
     * @param role
     * @return
     */
    @XudenSysLog("新增角色数据")
    @PreAuthorize(hasPermi = "sys:role:add")
    @PostMapping("create")
    public RestResponse create(@RequestBody SysRole role){
        if(StringUtils.isBlank(role.getName())){
            return RestResponse.failure("角色名称不能为空");
        }
        if(roleService.getRoleNameCount(role.getName())>0){
            return RestResponse.failure("角色名称已经存在");
        }

        roleService.create(role);
        return RestResponse.success();
    }

    /**
     * 功能描述：根据角色获取对应权限
     * @param id
     * @return
     */
    @GetMapping("getMenuByRole")
    public RestResponse getMenuByRole(Long id){

        //根据角色获取对应的菜单
        SysRole role = roleService.getRoleById(id);
        StringBuilder menuIds = new StringBuilder();
        if(null!=role){
            Set<SysMenu> menuSet = role.getMenuSet();
            if(menuSet!=null && menuSet.size()>0){
                for (SysMenu m:menuSet){
                    menuIds.append(m.getId().toString()).append(",");
                }
            }
        }

        //查询所有的菜单
        Map<String,Object> map = Maps.newHashMap();
        map.put("parentId",null);
        map.put("isShow",false);
        List<SysMenu> menuList = menuService.selectAllMenus(map);
        Map<String,Object> resultMap = Maps.newHashMap();
        resultMap.put("menuList",menuList);
        resultMap.put("menuIds",menuIds);

        return RestResponse.success().setData(resultMap);
    }

    /**
     * 功能描述：编辑角色（前端layui项目使用）
     * @param role
     * @return
     */
    @XudenSysLog("编辑角色数据")
    @PreAuthorize(hasPermi = "sys:role:edit")
    @PostMapping("edit")
    public RestResponse edit(@RequestBody SysRole role){
        if(role.getId()==null||role.getId()==0){
            return RestResponse.failure("角色ID不能为空");
        }

        if(StringUtils.isBlank(role.getName())){
            return RestResponse.failure("角色名称不能为空");
        }

        SysRole oldRole = roleService.getById(role.getId());
        if(!oldRole.getName().equals(role.getName())){
            if(roleService.getRoleNameCount(role.getName())>0){
                return RestResponse.failure("角色已经存在");
            }
        }

        roleService.updateRole(role);
        return RestResponse.success();

    }

    /**
     * 功能描述：编辑角色（前端vue3项目使用）
     * @param role
     * @return
     */
    @XudenSysLog("编辑角色数据")
    @PreAuthorize(hasPermi = "sys:role:edit")
    @PutMapping("edit/{id}")
    public RestResponse editRole(@PathVariable Long id ,@RequestBody SysRole role){
        if(id==null||id==0){
            return RestResponse.failure("角色ID不能为空");
        }

        if(StringUtils.isBlank(role.getName())){
            return RestResponse.failure("角色名称不能为空");
        }

        SysRole oldRole = roleService.getById(id);
        if(!oldRole.getName().equals(role.getName())){
            if(roleService.getRoleNameCount(role.getName())>0){
                return RestResponse.failure("角色已经存在");
            }
        }
        role.setId(id);
        roleService.updateById(role);
        return RestResponse.success();

    }


    /**
     * 功能描述：编辑角色(vue3前端项目使用)
     * @param id,menuId
     * @return
     */
    @XudenSysLog("编辑角色和菜单数据")
    @PreAuthorize(hasPermi = "sys:role:edit")
    @PostMapping("saveMenu/{id}")
    public RestResponse saveMenu(@PathVariable Long id,@RequestBody String[] menuIds){
        if(id==null||id==0){
            return RestResponse.failure("角色ID不能为空");
        }

        SysRole oldRole = roleService.getById(id);
        if(oldRole==null){
            return RestResponse.failure("角色不存在");
        }
        if(menuIds.length==0){
            return RestResponse.failure("请选择授权的菜单");
        }
        Set<SysMenu> menuSet = new HashSet<SysMenu>();
        for(String menuId:menuIds){
            SysMenu sysMenu = new SysMenu();
            sysMenu.setId(Long.parseLong(menuId));
            menuSet.add(sysMenu);
        }
        oldRole.setMenuSet(menuSet);
        roleService.updateRole(oldRole);
        return RestResponse.success();

    }

    /**
     * 功能描述：根据角色Id删除角色信息(单条记录,前端layui项目使用)
     * @param id
     * @return
     */
    @XudenSysLog("根据角色Id删除角色信息(单条记录)")
    @PreAuthorize(hasPermi = "sys:role:delete")
    @PostMapping("delete")
    public RestResponse delete(@RequestParam(value = "id",required = true)Long id){
        if(null==id||id==0){
            return RestResponse.failure("角色Id不能为空");
        }

        SysRole role = roleService.getRoleById(id);
        roleService.deleteRole(role);
        return RestResponse.success();
    }

    /**
     * 功能描述：根据角色Id删除角色信息(单条记录，前端vue3项目使用)
     * @param id
     * @return
     */
    @XudenSysLog("根据角色Id删除角色信息(单条记录)")
    @PreAuthorize(hasPermi = "sys:role:delete")
    @DeleteMapping("delete/{id}")
    public RestResponse deleteRole(@PathVariable Long id){
        if(null==id||id==0){
            return RestResponse.failure("角色Id不能为空");
        }

        SysRole role = roleService.getRoleById(id);
        if(role==null){
            return RestResponse.failure("该角色已被删除，请勿重复删除");
        }
        roleService.deleteRole(role);
        return RestResponse.success();
    }


    /**
     * 功能描述：批量删除角色
     * @param roles
     * @return
     */
    @XudenSysLog("根据角色Id删除角色信息(批量删除角色)")
    @PreAuthorize(hasPermi = "sys:role:delete")
    @PostMapping("deleteSome")
    public RestResponse deleteSome(@RequestBody List<SysRole> roles){

        if(null==roles||roles.size()==0){
            return RestResponse.failure("请选择需要删除的角色");
        }
        for (SysRole r:roles){
            roleService.deleteRole(r);
        }

    return RestResponse.success();
}



    /**
     * 功能描述：根据角色Id获取角色信息(前端vue3项目使用)
     * @param id
     * @return
     */
    @GetMapping("get/{id}")
    public RestResponse getRole(@PathVariable Long id){
        if(null==id||id==0){
            return RestResponse.failure("角色Id不能为空");
        }

        SysRole role = roleService.getById(id);
        if(role==null){
            return RestResponse.failure("该角色不存在");
        }
        return RestResponse.success().setData(role);
    }



}
