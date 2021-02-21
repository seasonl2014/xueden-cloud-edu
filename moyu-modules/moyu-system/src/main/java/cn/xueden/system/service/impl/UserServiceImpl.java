package cn.xueden.system.service.impl;



import cn.xueden.common.core.web.domain.SysRole;
import cn.xueden.common.core.web.domain.SysUser;
import cn.xueden.common.security.utils.SecurityUtils;
import cn.xueden.system.dao.UserDao;

import cn.xueden.system.service.UserService;
/*import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;*/
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.google.common.collect.Maps;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;
import java.util.Set;

/**
 * @Auther:http://www.xueden.cn
 * @Date:2020/2/21
 * @Description:cn.xueden.modules.system.service.impl
 * @version:1.0
 */
@Service("userService")
@Transactional(readOnly = true,rollbackFor = Exception.class)
public class UserServiceImpl extends ServiceImpl<UserDao, SysUser> implements UserService {
    @Override
    public SysUser findUserByLoginName(String name) {
        Map<String,Object> map = Maps.newHashMap();
        map.put("loginName",name);
        SysUser u= baseMapper.selectUserByMap(map);
        return u;
    }

    @Override
    public SysUser findUserById(Long id) {
        Map<String,Object> map = Maps.newHashMap();
        map.put("id",id);
        return baseMapper.selectUserByMap(map);
    }

    /**
     * 功能描述：统计登录名称
     * @param param
     * @return
     */
    @Override
    public int userCount(String param) {
        QueryWrapper<SysUser> wrapper = new QueryWrapper<>();
        wrapper.eq("login_name",param).or().eq("email",param).or().eq("tel",param);
        int count = baseMapper.selectCount(wrapper);
        return count;
    }

    /**
     * 功能描述：保存用户信息
     * @param user
     * @return
     */
    @Override
    @Transactional(readOnly = false,rollbackFor = Exception.class)
    public SysUser saveUser(SysUser user) {
        user.setPassword(SecurityUtils.encryptPassword(user.getPassword()));
        user.setLocked(false);
        baseMapper.insert(user);
        return findUserById(user.getId());
    }

    /**
     * 保存用户和角色关系
     * @param id
     * @param roleSet
     */
    @Override
    @Transactional(readOnly = false,rollbackFor = Exception.class)
    public void saveUserRoles(Long id, Set<SysRole> roleSet) {
        baseMapper.saveUserRoles(id,roleSet);
    }

    /**
     * 功能描述：更新用户信息
     * @param user
     * @return
     */
    @Override
    @Transactional(readOnly = false,rollbackFor = Exception.class)
    public SysUser updateUser(SysUser user) {
        baseMapper.updateById(user);
        return user;
    }

    /**
     * 功能描述：删除用户和角色关系
     * @param id
     */
    @Override
    @Transactional(readOnly = false,rollbackFor = Exception.class)
    public void dropUserRolesByUserId(Long id) {
        baseMapper.dropUserRolesByUserId(id);
    }

    /**
     * 删除用户信息（单条）
     * @param user
     */
    @Override
    @Transactional(readOnly = false,rollbackFor = Exception.class)
    public void deleteUser(SysUser user) {
        user.setDelFlag(true);
        user.updateById();
    }
}
