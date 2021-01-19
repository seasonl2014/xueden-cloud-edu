package cn.xueden.system.dao;


import cn.xueden.common.core.web.domain.SysRole;
import cn.xueden.common.core.web.domain.SysUser;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.Map;
import java.util.Set;

/**功能描述:用户信息 Mapper 接口
 * @Auther:http://www.xueden.cn
 * @Date:2020/2/21
 * @Description:cn.xueden.modules.system.dao
 * @version:1.0
 */
public interface UserDao extends BaseMapper<SysUser> {
    SysUser selectUserByMap(Map<String, Object> map);

    //保存用户和角色关系
    void  saveUserRoles(@Param("userId") Long id, @Param("roleIds") Set<SysRole> roles);

    void dropUserRolesByUserId(@Param("userId") Long userId);
}
