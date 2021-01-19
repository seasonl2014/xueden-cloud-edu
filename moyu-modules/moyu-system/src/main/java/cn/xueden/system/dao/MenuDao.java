package cn.xueden.system.dao;


import cn.xueden.common.core.web.domain.SysMenu;

import cn.xueden.system.entity.vo.ShowMenu;
import com.baomidou.mybatisplus.mapper.BaseMapper;

import java.util.List;
import java.util.Map;

/**功能描述:菜单 Mapper 接口
 * @Auther:http://www.xueden.cn
 * @Date:2020/2/24
 * @Description:cn.xueden.modules.system.dao
 * @version:1.0
 */
public interface MenuDao extends BaseMapper<SysMenu> {

    List<ShowMenu> selectShowMenuByUser(Map<String, Object> map);

    List<SysMenu> getMenus(Map map);
}
