package cn.xueden.edu.service;

import cn.xueden.common.core.edu.domain.EduDealMoney;
import com.baomidou.mybatisplus.extension.service.IService;

/**功能描述：成交金额业务接口
 * @Auther:梁志杰
 * @Date:2021/2/9
 * @Description:cn.xueden.edu.service
 * @version:1.0
 */
public interface IEduDealMoneyService extends IService<EduDealMoney> {

    // 根据订单编号获取成交金额记录
    EduDealMoney getByOrderNumber(String outTradeNo);

}
