package cn.xueden.edu.service;

import cn.xueden.common.core.edu.domain.EduIncomeDetails;

import cn.xueden.common.core.edu.vo.EduIncomeDetailsVO;
import cn.xueden.common.core.edu.vo.PageVO;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**功能描述：讲师收入明细业务接口
 * @Auther:梁志杰
 * @Date:2021/5/26
 * @Description:cn.xueden.edu.service
 * @version:1.0
 */
public interface IEduIncomeDetailsService extends IService<EduIncomeDetails> {

    /**
     * 根据条件分页回去讲师收益记录
     * @return
     */
    PageVO<EduIncomeDetailsVO> getList(Integer pageNum, Integer pageSize, EduIncomeDetailsVO incomeDetailsVO);

    /**
     * 技术讲师分成收益
     * @param orderNo
     */
    public void teacherIncome(String orderNo);


}
