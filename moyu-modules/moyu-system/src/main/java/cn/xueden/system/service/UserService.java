package cn.xueden.system.service;


import cn.xueden.common.core.web.domain.SysRole;
import cn.xueden.common.core.web.domain.SysUser;
import com.baomidou.mybatisplus.service.IService;

import java.util.Set;

/**功能描述:用户信息 服务类
 * @Auther:http://www.xueden.cn
 * @Date:2020/2/21
 * @Description:cn.xueden.modules.system.service
 * @version:1.0
 */
public interface UserService extends IService<SysUser> {

    SysUser findUserByLoginName(String name);

    SysUser findUserById(Long id);

    int userCount(String param);

    SysUser saveUser(SysUser user);

    //保存用户和角色的关系
    void saveUserRoles(Long id, Set<SysRole> roleSet);

    //更新用户信息
    SysUser updateUser(SysUser user);

    //删除用户和角色关系
    void  dropUserRolesByUserId(Long id);

    //删除单条记录
    void deleteUser(SysUser user);
}
