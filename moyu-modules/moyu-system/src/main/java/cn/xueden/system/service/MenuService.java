package cn.xueden.system.service;


import cn.xueden.common.core.web.domain.SysMenu;

import cn.xueden.system.entity.vo.ShowMenu;
import com.baomidou.mybatisplus.service.IService;

import java.util.List;
import java.util.Map;

/**功能描述:菜单 服务接口
 * @Auther:http://www.xueden.cn
 * @Date:2020/2/24
 * @Description:cn.xueden.modules.system.service
 * @version:1.0
 */
public interface MenuService extends IService<SysMenu> {

    List<ShowMenu> getShowMenuByUser(Long id);

    List<SysMenu> selectAllMenus(Map<String, Object> map);

    int getCountByName(String name);

    int getCountByPermission(String permission);

    void saveOrUpdateMenu(SysMenu menu);
}
