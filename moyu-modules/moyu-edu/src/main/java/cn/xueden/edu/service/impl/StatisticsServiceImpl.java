package cn.xueden.edu.service.impl;

import cn.xueden.common.core.edu.domain.EduDailyReport;
import cn.xueden.common.core.edu.domain.EduIncomeDetails;
import cn.xueden.common.core.edu.domain.EduMemberBuyCourse;
import cn.xueden.common.core.edu.domain.EduTeacher;
import cn.xueden.common.core.utils.StringUtils;
import cn.xueden.edu.dao.EduDailyReportDao;
import cn.xueden.edu.dao.EduIncomeDetailsDao;
import cn.xueden.edu.dao.EduMemberBuyCourseDao;
import cn.xueden.edu.dao.EduTeacherDao;
import cn.xueden.edu.service.IStatisticsService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

/**功能描述：每日统计数据业务接口实现类
 * @Auther:梁志杰
 * @Date:2021/5/27
 * @Description:cn.xueden.edu.service.impl
 * @version:1.0
 */
@Service
public class StatisticsServiceImpl implements IStatisticsService {

    @Autowired
    private EduTeacherDao teacherDao;

    @Autowired
    private EduMemberBuyCourseDao memberBuyCourseDao;

    @Autowired
    private EduIncomeDetailsDao incomeDetailsDao;

    @Autowired
    private EduDailyReportDao dailyReportDao;

    /**
     * 每日统计讲师的订单数量和收益记录
     */
    @Override
    public void countDaily() {
        System.out.println("--------------- 开始统计 ---------------");
      LocalDate localDate = LocalDate.now();
      List<EduTeacher> teacherList =  teacherDao.selectList(new QueryWrapper<>());
      for (EduTeacher teacher: teacherList){
          // 统计讲师昨天的订单数量
          QueryWrapper<EduMemberBuyCourse> memberBuyCourseQueryWrapper = new QueryWrapper<>();
          memberBuyCourseQueryWrapper.ge("create_date",localDate.minusDays(1).toString());
          memberBuyCourseQueryWrapper.le("create_date",localDate.plusDays(0).toString());
          memberBuyCourseQueryWrapper.eq("teacher_id",teacher.getId());
          int lastOrderNum = memberBuyCourseDao.selectCount(memberBuyCourseQueryWrapper);
          EduDailyReport tempEduDailyReport = new EduDailyReport();
          tempEduDailyReport.setOrderNum(lastOrderNum); // 订单数量
          tempEduDailyReport.setDate(localDate.plusDays(-1).toString()); // 日期
          tempEduDailyReport.setCreateTime(StringUtils.localDate2Date(localDate.plusDays(-1)));// 创建日期
          tempEduDailyReport.setTeacherId(teacher.getId()); // 讲师ID
          tempEduDailyReport.setDayNo(localDate.plusDays(-1).getDayOfMonth()+"日");

          // 统计讲师收益
          QueryWrapper<EduIncomeDetails> eduIncomeDetailsQueryWrapper = new QueryWrapper<>();
          eduIncomeDetailsQueryWrapper.eq("teacher_id",teacher.getId());
          eduIncomeDetailsQueryWrapper.ge("create_date",localDate.minusDays(1).toString());
          eduIncomeDetailsQueryWrapper.le("create_date",localDate.plusDays(0).toString());
          List<EduIncomeDetails> eduIncomeDetailsList = incomeDetailsDao.selectList(eduIncomeDetailsQueryWrapper);
          //统计总收益
          double dealMoneys =  eduIncomeDetailsList.stream().mapToDouble(item->{
              return item.getIncome();
          }).sum();
          tempEduDailyReport.setIncomeMoney(dealMoneys);
          dailyReportDao.insert(tempEduDailyReport);
          System.out.println("--------------- 结束统计 ---------------");
      }
    }
}
