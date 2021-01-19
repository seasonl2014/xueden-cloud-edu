package cn.xueden.system.service.impl;


import cn.xueden.common.core.utils.ToolUtil;
import cn.xueden.common.core.web.domain.SysLog;
import cn.xueden.system.dao.LogDao;

import cn.xueden.system.service.LogService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**功能描述:系统日志 服务实现类
 * @Auther:http://www.xueden.cn
 * @Date:2020/3/6
 * @Description:cn.xueden.modules.system.service.impl
 * @version:1.0
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class LogServiceImpl extends ServiceImpl<LogDao, SysLog> implements LogService {

    @Override
    public Map<String,Object>  selectSelfMonthData() {
        List<Map> list =  baseMapper.selectSelfMonthData();
        List<Integer> pv = Lists.newArrayList();
        ArrayList<LocalDate> pastDaysList = ToolUtil.creatPastDays(15);

        Map<String,Object> resultmap = Maps.newHashMap();
        resultmap.put("pastDaysList",pastDaysList);

        for(LocalDate localDate:pastDaysList){
            boolean flag=false;
            for(Map map : list){
                if(map.get("days").toString().equals(localDate.toString())){
                    System.out.println("日期"+map.get("days").toString());
                    pv.add(Integer.valueOf(map.get("total").toString()));
                    flag = true;
                }
            }
            if (!flag){
                pv.add(0);
            }
        }
        resultmap.put("pv",pv);
        return resultmap;
    }

    @Override
    public Map<String, Object> selectSelfMonthDataByProvince() {
        List<Map> list =  baseMapper.selectSelfMonthDataByProvince();
        Map<String,Object> resultmap = Maps.newHashMap();
        resultmap.put("pv",list);
        return resultmap;
    }
}
