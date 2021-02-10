package cn.xueden.edu.service.impl;

import cn.xueden.common.core.edu.domain.EduMemberBuyCourse;
import cn.xueden.edu.dao.EduMemberBuyCourseDao;
import cn.xueden.edu.service.IEduMemberBuyCourseService;
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
public class EduMemberBuyCourseServiceImpl extends ServiceImpl<EduMemberBuyCourseDao, EduMemberBuyCourse> implements IEduMemberBuyCourseService {

    @Autowired
    private EduMemberBuyCourseDao eduMemberBuyCourseDao;

    /**
     * 根据订单号获取订单详情
     * @param outTradeNo
     * @return
     */
    @Override
    public EduMemberBuyCourse getByOrderNumber(String outTradeNo) {
        QueryWrapper<EduMemberBuyCourse> queryWrapper = new QueryWrapper();
        queryWrapper.eq("order_no",outTradeNo);
        return eduMemberBuyCourseDao.selectOne(queryWrapper);
    }

    /**
     * 更改订单状态
     * @param pay
     */
    @Override
    public void updatePayment(EduMemberBuyCourse pay) {
        eduMemberBuyCourseDao.updateById(pay);
    }
}
