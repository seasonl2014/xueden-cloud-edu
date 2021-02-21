package cn.xueden.edu.converter;

import cn.xueden.common.core.edu.domain.EduCourse;
import cn.xueden.common.core.edu.domain.EduMemberBuyCourse;
import cn.xueden.common.core.edu.vo.EduMemberBuyCourseVO;
import cn.xueden.edu.service.IEduCourseService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;

/**功能描述：我的课程转换类
 * @Auther:梁志杰
 * @Date:2021/2/18
 * @Description:cn.xueden.edu.converter
 * @version:1.0
 */
public class EduMemberBuyCourseConverter {



    /**
     * 转voList
     * @param eduMemberBuyCourses
     * @return
     */
    public static List<EduMemberBuyCourseVO> converterToVOList(List<EduMemberBuyCourse> eduMemberBuyCourses,IEduCourseService eduCourseService) {
        List<EduMemberBuyCourseVO> eduMemberBuyCourseVOS=new ArrayList<>();
        if(!CollectionUtils.isEmpty(eduMemberBuyCourses)){
            for (EduMemberBuyCourse eduMemberBuyCourse : eduMemberBuyCourses) {
                EduMemberBuyCourseVO eduMemberBuyCourseVO = new EduMemberBuyCourseVO();
                BeanUtils.copyProperties(eduMemberBuyCourse,eduMemberBuyCourseVO);
                EduCourse eduCourse = eduCourseService.getById(eduMemberBuyCourse.getCourseId());
                eduMemberBuyCourseVO.setEduCourse(eduCourse);
                eduMemberBuyCourseVOS.add(eduMemberBuyCourseVO);
            }
        }
        return eduMemberBuyCourseVOS;
    }
}
