package cn.xueden.system.dao;


import cn.xueden.common.core.web.domain.SysLog;

import com.baomidou.mybatisplus.mapper.BaseMapper;

import java.util.List;
import java.util.Map;

/**功能描述:系统日志 Mapper 接口
 * @Auther:http://www.xueden.cn
 * @Date:2020/3/6
 * @Description:cn.xueden.modules.system.dao
 * @version:1.0
 */
public interface LogDao extends BaseMapper<SysLog> {

    List<Map> selectSelfMonthData();

    List<Map> selectSelfMonthDataByProvince();
}
