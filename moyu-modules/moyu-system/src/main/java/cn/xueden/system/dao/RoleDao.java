package cn.xueden.system.dao;


import cn.xueden.common.core.web.domain.SysMenu;
import cn.xueden.common.core.web.domain.SysRole;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.Set;

/**功能描述:用户角色 Mapper 接口
 * @Auther:http://www.xueden.cn
 * @Date:2020/2/25
 * @Description:cn.xueden.modules.system.dao
 * @version:1.0
 */
public interface RoleDao extends BaseMapper<SysRole> {

    //保存角色和菜单关系
    void saveRoleMenus(@Param("roleId") Long id, @Param("menus") Set<SysMenu> menus);

    //删除角色和菜单关系
    void dropRoleMenus(@Param("roleId") Long roleId);

    //根据角色Id获取角色信息
    SysRole selectRoleById(@Param("id") Long id);

    //删除角色和用户的关系
    void dropRoleUsers(@Param("roleId") Long roleId);
}
