package cn.xueden.system.service.impl;


import cn.xueden.common.core.web.domain.SysMenu;
import cn.xueden.system.dao.MenuDao;

import cn.xueden.system.entity.vo.ShowMenu;
import cn.xueden.system.service.MenuService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.google.common.collect.Maps;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**功能描述:菜单 服务实现类
 * @Auther:http://www.xueden.cn
 * @Date:2020/2/24
 * @Description:cn.xueden.modules.system.service.impl
 * @version:1.0
 */
@Service
@Transactional(readOnly = true,rollbackFor = Exception.class)
public class MenuServiceImpl extends ServiceImpl<MenuDao, SysMenu> implements MenuService {

    @Override
    public List<ShowMenu> getShowMenuByUser(Long id) {
        Map<String,Object> map = Maps.newHashMap();
        map.put("userId",id);
        map.put("parentId",null);
        return baseMapper.selectShowMenuByUser(map);
    }

    @Override
    public List<SysMenu> selectAllMenus(Map<String, Object> map) {
        return baseMapper.getMenus(map);
    }

    @Override
    public int getCountByName(String name) {
        EntityWrapper<SysMenu> wrapper = new EntityWrapper();
        wrapper.eq("del_flag",false);
        wrapper.eq("name",name);
        return baseMapper.selectCount(wrapper);
    }

    @Override
    public int getCountByPermission(String permission) {
        EntityWrapper<SysMenu> wrapper = new EntityWrapper();
        wrapper.eq("del_flag",false);
        wrapper.eq("permission",permission);
        return baseMapper.selectCount(wrapper);
    }

    @Transactional(readOnly = false,rollbackFor = Exception.class)
    @Override
    public void saveOrUpdateMenu(SysMenu menu) {
        insertOrUpdate(menu);
    }
}
