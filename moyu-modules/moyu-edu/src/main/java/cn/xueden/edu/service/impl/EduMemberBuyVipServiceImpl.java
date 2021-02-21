package cn.xueden.edu.service.impl;

import cn.xueden.common.core.edu.domain.EduMemberBuyVip;
import cn.xueden.edu.dao.EduMemberBuyVipDao;
import cn.xueden.edu.service.IEduMemberBuyVipService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Auther:梁志杰
 * @Date:2021/2/9
 * @Description:cn.xueden.edu.service.impl
 * @version:1.0
 */
@Service
public class EduMemberBuyVipServiceImpl extends ServiceImpl<EduMemberBuyVipDao, EduMemberBuyVip> implements IEduMemberBuyVipService {

    @Autowired
    private EduMemberBuyVipDao eduMemberBuyVipDao;

    /**
     * 根据订单编号获取订单信息
     * @param outTradeNo
     * @return
     */
    @Override
    public EduMemberBuyVip getByOrderNumber(String outTradeNo) {
        QueryWrapper<EduMemberBuyVip> tempEduMemberBuyVip = new QueryWrapper<>();
        tempEduMemberBuyVip.eq("order_no",outTradeNo);
        return eduMemberBuyVipDao.selectOne(tempEduMemberBuyVip);
    }

    /**
     * 更新订单状态
     * @param pay
     */
    @Override
    public void updatePayment(EduMemberBuyVip pay) {
        eduMemberBuyVipDao.updateById(pay);
    }
}
