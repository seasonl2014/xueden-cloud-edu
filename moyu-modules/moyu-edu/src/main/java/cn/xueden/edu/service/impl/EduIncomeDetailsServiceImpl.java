package cn.xueden.edu.service.impl;


import cn.xueden.common.core.edu.domain.EduCourse;
import cn.xueden.common.core.edu.domain.EduIncomeDetails;


import cn.xueden.common.core.edu.domain.EduMemberBuyCourse;
import cn.xueden.common.core.edu.domain.EduTeacher;
import cn.xueden.common.core.edu.vo.EduIncomeDetailsVO;
import cn.xueden.common.core.edu.vo.PageVO;
import cn.xueden.edu.dao.EduCourseDao;
import cn.xueden.edu.dao.EduIncomeDetailsDao;
import cn.xueden.edu.dao.EduMemberBuyCourseDao;
import cn.xueden.edu.dao.EduTeacherDao;
import cn.xueden.edu.service.IEduIncomeDetailsService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;

/**功能描述：讲师收入业务接口实现类
 * @Auther:梁志杰
 * @Date:2021/5/26
 * @Description:cn.xueden.edu.service.impl
 * @version:1.0
 */
@Service
@Slf4j
public class EduIncomeDetailsServiceImpl extends ServiceImpl<EduIncomeDetailsDao, EduIncomeDetails> implements IEduIncomeDetailsService {

    @Autowired
    private EduIncomeDetailsDao eduIncomeDetailsDao;

    @Autowired
    private EduMemberBuyCourseDao eduMemberBuyCourseDao;

    @Autowired
    private EduTeacherDao eduTeacherDao;

    @Override
    public PageVO<EduIncomeDetailsVO> getList(Integer pageNum, Integer pageSize, EduIncomeDetailsVO incomeDetailsVO) {
        return null;
    }

    /**
     * 计算讲师收益
     * @param orderNo
     */
    @Override
    public void teacherIncome(String orderNo) {
        log.info("订单号："+orderNo,"开始进入到计算提成方法");
        if(orderNo!=null){
            QueryWrapper<EduMemberBuyCourse> eduMemberBuyCourseQueryWrapper = new QueryWrapper<>();
            eduMemberBuyCourseQueryWrapper.eq("order_no",orderNo);
            EduMemberBuyCourse dbEduMemberBuyCourse = eduMemberBuyCourseDao.selectOne(eduMemberBuyCourseQueryWrapper);
            if(dbEduMemberBuyCourse!=null&&dbEduMemberBuyCourse.getIsPayment()==1){ // 已付款
                EduTeacher dbEduTeacher = eduTeacherDao.selectById(dbEduMemberBuyCourse.getTeacherId());
                if(dbEduTeacher!=null){
                    BigDecimal ratio = new BigDecimal(0.5);// 讲师提成比例50%
                    // 计算提成金额
                    BigDecimal amount = dbEduMemberBuyCourse.getPrice().multiply(ratio);
                    log.info("订单号："+dbEduMemberBuyCourse.getOrderNo(),"提成金额："+amount);
                    dbEduTeacher.setIncomeAmount(dbEduTeacher.getIncomeAmount().add(amount));// 累计收入
                    dbEduTeacher.setCashOutMoney(dbEduTeacher.getCashOutMoney().add(amount));// 可提现金额
                    eduTeacherDao.updateById(dbEduTeacher);
                    // 把记录保存到收益记录表
                    EduIncomeDetails tempEduIncomeDetails = new EduIncomeDetails();
                    tempEduIncomeDetails.setIncome(amount.doubleValue());// 收益金额
                    tempEduIncomeDetails.setPrice(dbEduMemberBuyCourse.getPrice().doubleValue());// 课程金额
                    tempEduIncomeDetails.setMemberId(dbEduMemberBuyCourse.getMemberId()); // 购买者ID
                    tempEduIncomeDetails.setTeacherId(dbEduMemberBuyCourse.getTeacherId());// 讲师ID
                    tempEduIncomeDetails.setOrderNo(orderNo);// 订单编号
                    tempEduIncomeDetails.setCourseId(dbEduMemberBuyCourse.getCourseId());// 课程ID
                    tempEduIncomeDetails.setCreateId(dbEduMemberBuyCourse.getTeacherId()); // 创建者ID
                    tempEduIncomeDetails.setUpdateId(dbEduMemberBuyCourse.getTeacherId());// 更新者ID
                    eduIncomeDetailsDao.insert(tempEduIncomeDetails);
                }
            }
        }

    }
}
