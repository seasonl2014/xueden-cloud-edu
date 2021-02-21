package cn.xueden.edu.service.impl;

import cn.xueden.common.core.edu.domain.EduDealMoney;
import cn.xueden.edu.dao.EduDealMoneyDao;
import cn.xueden.edu.service.IEduDealMoneyService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**功能描述：成交金额业务接口实现类
 * @Auther:梁志杰
 * @Date:2021/2/9
 * @Description:cn.xueden.edu.service.impl
 * @version:1.0
 */
@Service
public class EduDealMoneyServiceImpl extends ServiceImpl<EduDealMoneyDao, EduDealMoney> implements IEduDealMoneyService {

    @Autowired
    private EduDealMoneyDao eduDealMoneyDao;

    /**
     * 根据订单编号获取成交金额记录
     * @param outTradeNo
     * @return
     */
    @Override
    public EduDealMoney getByOrderNumber(String outTradeNo) {
        QueryWrapper<EduDealMoney> tempEduDealMoney = new QueryWrapper<>();
        tempEduDealMoney.eq("order_no",outTradeNo);
        return eduDealMoneyDao.selectOne(tempEduDealMoney);
    }
}
