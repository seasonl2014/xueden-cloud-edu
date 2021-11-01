package cn.xueden.edu.converter;

import cn.xueden.common.core.edu.domain.EduCourse;
import cn.xueden.common.core.edu.domain.EduIncomeDetails;
import cn.xueden.common.core.edu.domain.EduMemberBuyCourse;
import cn.xueden.common.core.edu.vo.EduIncomeDetailsVO;
import cn.xueden.edu.service.IEduCourseService;
import org.springframework.beans.BeanUtils;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;

/**功能描述：讲师收益转换类
 * @Auther:梁志杰
 * @Date:2021/5/26
 * @Description:cn.xueden.edu.converter
 * @version:1.0
 */
public class EduIncomeDetailsConverter {



    /**
     * 转voList
     * @param eduIncomeDetailsList
     * @return
     */
    public static List<EduIncomeDetailsVO> converterToVOList(List<EduIncomeDetails> eduIncomeDetailsList, IEduCourseService eduCourseService) {
        List<EduIncomeDetailsVO> eduIncomeDetailsVOS=new ArrayList<>();
        if(!CollectionUtils.isEmpty(eduIncomeDetailsList)){
            for (EduIncomeDetails eduIncomeDetails : eduIncomeDetailsList) {
                EduIncomeDetailsVO incomeDetailsVO = new EduIncomeDetailsVO();
                BeanUtils.copyProperties(eduIncomeDetails,incomeDetailsVO);
                EduCourse eduCourse = eduCourseService.getById(eduIncomeDetails.getCourseId());
                incomeDetailsVO.setCourseName(eduCourse.getTitle());
                eduIncomeDetailsVOS.add(incomeDetailsVO);
            }
        }
        return eduIncomeDetailsVOS;
    }
}
