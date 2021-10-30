package cn.xueden.edu.task;

import cn.xueden.edu.service.IStatisticsService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**功能描述：每日统计任务
 * @Auther:梁志杰
 * @Date:2021/5/27
 * @Description:cn.xueden.edu.task
 * @version:1.0
 */
@EnableScheduling
@Slf4j
@Component
public class DailyScheduledTask {

    @Autowired
    private IStatisticsService statisticsService;

    /**
     * 每日0点统计讲师订单数量和收益金额记录
     */
    @Scheduled(cron="0 0 0 * * ?")
    public void countDaily() {
        log.info("每日0点统计讲师订单数量和收益金额记录");
        System.out.println("--------------- 定时器启动订单数量和收益金额统计 ---------------");
        statisticsService.countDaily();
        System.out.println("--------------- 定时器启动订单数量和收益金额完成 ---------------");
    }
}
