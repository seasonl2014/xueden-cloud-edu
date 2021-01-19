package cn.xueden.system.service;


import cn.xueden.common.core.web.domain.SysRole;

import com.baomidou.mybatisplus.service.IService;

import java.util.List;

/**功能描述:用户角色 服务接口
 * @Auther:http://www.xueden.cn
 * @Date:2020/2/25
 * @Description:cn.xueden.modules.system.service
 * @version:1.0
 */
public interface RoleService extends IService<SysRole> {

    //根据角色名称统计记录
    int getRoleNameCount(String name);

    //保存角色信息
    SysRole saveRole(SysRole role);

    //保存角色信息
    SysRole create(SysRole role);

    //更新角色信息
    void updateRole(SysRole role);


    //根据角色Id获取角色信息
    SysRole getRoleById(Long id);

    //删除角色信息
    void deleteRole(SysRole role);

    //获取所有角色列表
    List<SysRole> selectAll();


}
