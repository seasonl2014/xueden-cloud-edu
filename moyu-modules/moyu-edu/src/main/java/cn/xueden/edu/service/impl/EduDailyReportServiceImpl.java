package cn.xueden.edu.service.impl;


import cn.xueden.common.core.edu.domain.EduDailyReport;

import cn.xueden.edu.dao.EduDailyReportDao;

import cn.xueden.edu.service.IEduDailyReportService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**功能描述：每日统计业务接口实现类
 * @Auther:梁志杰
 * @Date:2021/5/27
 * @Description:cn.xueden.edu.service.impl
 * @version:1.0
 */
@Service
public class EduDailyReportServiceImpl extends ServiceImpl<EduDailyReportDao, EduDailyReport> implements IEduDailyReportService {
}
