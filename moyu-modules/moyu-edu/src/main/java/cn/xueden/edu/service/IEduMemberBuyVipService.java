package cn.xueden.edu.service;

import cn.xueden.common.core.edu.domain.EduMemberBuyVip;

/**功能描述：用户加入VIP订单业务接口
 * @Auther:梁志杰
 * @Date:2021/2/9
 * @Description:cn.xueden.edu.service
 * @version:1.0
 */
public interface IEduMemberBuyVipService {

    // 根据订单编号获取订单信息
    EduMemberBuyVip getByOrderNumber(String outTradeNo);

    // 更新订单状态
    void updatePayment(EduMemberBuyVip pay);
}
