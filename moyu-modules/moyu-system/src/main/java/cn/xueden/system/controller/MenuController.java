package cn.xueden.system.controller;


import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.common.core.utils.XudenStringUtils;
import cn.xueden.common.core.web.domain.SysMenu;

import cn.xueden.common.log.annotation.XudenSysLog;
import cn.xueden.common.security.annotation.PreAuthorize;
import com.baomidou.mybatisplus.mapper.Condition;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.google.common.collect.Maps;


import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**功能描述:菜单 前端控制器
 * @Auther:http://www.xueden.cn
 * @Date:2020/2/24
 * @Description:cn.xueden.modules.system.controller
 * @version:1.0
 */
@RestController
@RequestMapping("/system/menu")
public class MenuController extends BaseController {

    /**
     * 统计菜单数据
     * @return
     */
    @GetMapping("list")
    public RestResponse countMenu(){
        EntityWrapper<SysMenu> menuEntityWrapper = new EntityWrapper();
        menuEntityWrapper.eq("del_flag",false);
        int menuCount = menuService.selectCount(menuEntityWrapper);
        Map<String,Object> map = new HashMap<>();
        map.put("menuCount",menuCount);
        return RestResponse.success().setData(map);
    }

    /**
     * 功能描述：获取全部菜单列表
     * @return
     */
    @RequestMapping("treelist")
    public RestResponse treelist(){
        Map<String,Object> map = Maps.newHashMap();
        map.put("parentId",null);
        map.put("isShow",false);
        return RestResponse.success().setData(menuService.selectAllMenus(map));
    }


    /**
     * 功能描述：添加菜单，包括添加父级菜单和子菜单（前端layui项目使用）
     * @param menu
     * @return
     */
    @XudenSysLog("添加菜单数据")
    @PreAuthorize(hasPermi = "sys:menu:add")
    @RequestMapping("add")
    public RestResponse add(SysMenu menu){

        if(XudenStringUtils.isBlank(menu.getName())){
            return RestResponse.failure("菜单名称不能为空");
        }

        if(menuService.getCountByName(menu.getName())>0){
            return RestResponse.failure("菜单名称已存在");
        }

        if(XudenStringUtils.isNotBlank(menu.getPermission())){
            if(menuService.getCountByPermission(menu.getPermission())>0){
                return RestResponse.failure("权限标识已经存在");
            }
        }

        //处理菜单排序
        if(menu.getParentId()==null){
            menu.setLevel(1);
            Object o = menuService.selectObj(Condition.create().setSqlSelect("max(sort)").isNull("parent_id"));
            int sort = 0;
            if(null!=o){
                sort = (Integer) o+10;
            }
            menu.setSort(sort);
        }else{
            SysMenu parentMenu = menuService.selectById(menu.getParentId());
            if(null==parentMenu){
                return RestResponse.failure("父菜单不存在");
            }

            menu.setParentIds(parentMenu.getParentIds());
            menu.setLevel(parentMenu.getLevel()+1);
            Object o = menuService.selectObj(Condition.create()
                    .setSqlSelect("max(sort)")
                    .eq("parent_id",menu.getParentId()));
            int sort = 0;
            if(null!=o){
                sort = (Integer) o+10;
            }
            menu.setSort(sort);
        }
        menuService.saveOrUpdateMenu(menu);
        return RestResponse.success();
    }

    /**
     * 功能描述：添加菜单，包括添加父级菜单和子菜单(前端vue3项目使用)
     * @param menu
     * @return
     */
    @XudenSysLog("添加菜单数据")
    @PreAuthorize(hasPermi = "sys:menu:add")
    @PostMapping("addMenu")
    public RestResponse addMenu(@RequestBody SysMenu menu){

        if(XudenStringUtils.isBlank(menu.getName())){
            return RestResponse.failure("菜单名称不能为空");
        }

        if(menuService.getCountByName(menu.getName())>0){
            return RestResponse.failure("菜单名称已存在");
        }

        if(XudenStringUtils.isNotBlank(menu.getPermission())){
            if(menuService.getCountByPermission(menu.getPermission())>0){
                return RestResponse.failure("权限标识已经存在");
            }
        }

        //处理菜单排序
        if(menu.getParentId()==null||menu.getParentId()==0){
            menu.setLevel(1);
            Object o = menuService.selectObj(Condition.create().setSqlSelect("max(sort)").isNull("parent_id"));
            int sort = 0;
            if(null!=o){
                sort = (Integer) o+10;
            }
            menu.setSort(sort);
            menu.setParentId(null);
        }else{
            SysMenu parentMenu = menuService.selectById(menu.getParentId());
            if(null==parentMenu){
                return RestResponse.failure("父菜单不存在");
            }

            menu.setParentIds(parentMenu.getParentIds());
            menu.setLevel(parentMenu.getLevel()+1);
            Object o = menuService.selectObj(Condition.create()
                    .setSqlSelect("max(sort)")
                    .eq("parent_id",menu.getParentId()));
            int sort = 0;
            if(null!=o){
                sort = (Integer) o+10;
            }
            menu.setSort(sort);
        }
        menuService.saveOrUpdateMenu(menu);
        return RestResponse.success();
    }

    /**
     * 功能描述：获取菜单详情数据(前端vue3项目使用)
     * @param id
     * @return
     */
    @PreAuthorize(hasPermi = "sys:menu:edit")
    @GetMapping("get/{id}")
    public RestResponse getMenu(@PathVariable Long id){
        if(null==id){
            return RestResponse.failure("菜单ID不能为空");
        }
        SysMenu menu = menuService.selectById(id);
        return RestResponse.success().setData(menu);
    }

    /**
     * 功能描述：编辑菜单（前端layui项目使用）
     * @param menu
     * @return
     */
    @XudenSysLog("编辑菜单数据")
    @PreAuthorize(hasPermi = "sys:menu:edit")
    @RequestMapping("edit")
    public RestResponse edit(SysMenu menu){
        if(null==menu.getId()){
            return RestResponse.failure("菜单ID不能为空");
        }

        if (XudenStringUtils.isBlank(menu.getName())) {
            return RestResponse.failure("菜单名称不能为空");
        }

        SysMenu oldMenu = menuService.selectById(menu.getId());

        if(!oldMenu.getName().equals(menu.getName())){
            if(menuService.getCountByName(menu.getName())>0){
                return RestResponse.failure("菜单名称已存在");
            }

        }

        if (XudenStringUtils.isNotBlank(menu.getPermission())) {
            if(!oldMenu.getPermission().equals(menu.getPermission())) {
                if (menuService.getCountByPermission(menu.getPermission()) > 0) {
                    return RestResponse.failure("权限标识已经存在");
                }
            }
        }

        if(null==menu.getSort()){
            return RestResponse.failure("排序值不能为空");
        }

        menuService.saveOrUpdateMenu(menu);
        return RestResponse.success();

    }

    /**
     * 功能描述：编辑菜单（前端vue3.0项目使用）
     * @param menu
     * @return
     */
    @XudenSysLog("编辑菜单数据")
    @PreAuthorize(hasPermi = "sys:menu:edit")
    @PutMapping("edit/{id}")
    public RestResponse editMenu(@PathVariable Long id, @RequestBody SysMenu menu){
        if(null==id){
            return RestResponse.failure("菜单ID不能为空");
        }

        if (XudenStringUtils.isBlank(menu.getName())) {
            return RestResponse.failure("菜单名称不能为空");
        }

        SysMenu oldMenu = menuService.selectById(id);

        if(!oldMenu.getName().equals(menu.getName())){
            if(menuService.getCountByName(menu.getName())>0){
                return RestResponse.failure("菜单名称已存在");
            }

        }

        if (XudenStringUtils.isNotBlank(menu.getPermission())) {
            if(!oldMenu.getPermission().equals(menu.getPermission())) {
                if (menuService.getCountByPermission(menu.getPermission()) > 0) {
                    return RestResponse.failure("权限标识已经存在");
                }
            }
        }

        if(null==menu.getSort()){
            return RestResponse.failure("排序值不能为空");
        }
        menu.setId(id);
        menu.setHref(oldMenu.getHref());
        menuService.saveOrUpdateMenu(menu);
        return RestResponse.success();

    }

    /**
     * 功能描述：删除菜单(前端layui项目使用)
     * @param id
     * @return
     */
    @XudenSysLog("删除菜单数据")
    @PreAuthorize(hasPermi = "sys:menu:delete")
    @RequestMapping("delete")
     public RestResponse delete(@RequestParam(value = "id",required = true)Long id){
        if(null==id){
            return RestResponse.failure("菜单ID不能为空");
        }
        SysMenu menu = menuService.selectById(id);
        menu.setDelFlag(true);
        menuService.saveOrUpdateMenu(menu);

        return RestResponse.success();
     }

    /**
     * 功能描述：删除菜单(前端vue3项目使用)
     * @param id
     * @return
     */
    @XudenSysLog("删除菜单数据")
    @PreAuthorize(hasPermi = "sys:menu:delete")
    @DeleteMapping("delete/{id}")
    public RestResponse deleteMenu(@PathVariable Long id){
        if(null==id){
            return RestResponse.failure("菜单ID不能为空");
        }
        SysMenu menu = menuService.selectById(id);
        menu.setDelFlag(true);
        menuService.saveOrUpdateMenu(menu);

        return RestResponse.success();
    }

}
