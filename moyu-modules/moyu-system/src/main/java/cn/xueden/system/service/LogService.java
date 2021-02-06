package cn.xueden.system.service;



import cn.xueden.common.core.web.domain.SysLog;
import com.baomidou.mybatisplus.extension.service.IService;
/*import com.baomidou.mybatisplus.service.IService;*/

import java.util.Map;

/**功能描述:系统日志服务类
 * @Auther:http://www.xueden.cn
 * @Date:2020/3/6
 * @Description:cn.xueden.modules.system.service
 * @version:1.0
 */
public interface LogService extends IService<SysLog> {

    public Map<String,Object>  selectSelfMonthData();

    public Map<String,Object> selectSelfMonthDataByProvince();

}
