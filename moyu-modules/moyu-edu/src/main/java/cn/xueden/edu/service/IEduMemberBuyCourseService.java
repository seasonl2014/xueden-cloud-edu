package cn.xueden.edu.service;

import cn.xueden.common.core.edu.domain.EduMemberBuyCourse;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * @Auther:梁志杰
 * @Date:2021/2/9
 * @Description:cn.xueden.edu.service
 * @version:1.0
 */
public interface IEduMemberBuyCourseService extends IService<EduMemberBuyCourse> {

    /**
     * 根据订单号获取订单详情
     * @param orderNo
     * @return
     */
    EduMemberBuyCourse getByOrderNumber(String orderNo);

    /**
     * 更改订单状态
     * @param pay
     */
    void updatePayment(EduMemberBuyCourse pay);
}
