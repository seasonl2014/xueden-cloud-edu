package cn.xueden.edu.service.impl;

import cn.xueden.common.core.edu.domain.EduCourse;

import cn.xueden.common.core.edu.vo.EduCourseVO;
import cn.xueden.edu.converter.EduCourseConverter;
import cn.xueden.edu.dao.EduCourseDao;
import cn.xueden.edu.service.IEduCourseService;
/*import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;*/
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**课程 服务实现类
 * @Auther:梁志杰
 * @Date:2021/1/23
 * @Description:cn.xueden.edu.service.impl
 * @version:1.0
 */
@Service
public class EduCourseServiceImpl extends ServiceImpl<EduCourseDao, EduCourse> implements IEduCourseService {



    @Autowired
    private EduCourseDao eduCourseDao;

    /**
     * 获取课程信息
     * @param id
     * @return
     */
    @Override
    public EduCourseVO getVoById(Long id) {
        EduCourse eduCourse = eduCourseDao.selectById(id);
        return EduCourseConverter.converterToCourseVO(eduCourse);
    }

    /**
     * 前台首页获取课程列表
     * @param pageNum
     * @param pageSize
     * @param eduCourseVO
     * @return
     */
    @Override
    public List<EduCourseVO> findIndexCourseList(Integer pageNum, Integer pageSize, EduCourseVO eduCourseVO) {

        List<EduCourse> eduCourses = new ArrayList<EduCourse>();
        QueryWrapper<EduCourse> eduCourseEntityWrapper = new QueryWrapper();
        if (eduCourseVO.getCourseType() != null) {
            eduCourseEntityWrapper.eq("course_type",eduCourseVO.getCourseType());
        }
        // 获取已发布的课程
        eduCourseEntityWrapper.eq("status","Normal");
        eduCourses = eduCourseDao.selectList(eduCourseEntityWrapper);
        List<EduCourseVO> eduCourseVOList= EduCourseConverter.converterToVOList(eduCourses);
        return eduCourseVOList;
    }

    /**
     * 更新课程查看次数
     * @param eduCourseVO
     */
    @Override
    public void updateViewCount(EduCourseVO eduCourseVO) {
        eduCourseVO.setViewCount(eduCourseVO.getViewCount()+1);
        EduCourse eduCourse = new EduCourse();
        BeanUtils.copyProperties(eduCourseVO,eduCourse);
        eduCourse.setUpdateId(1l);
        eduCourseDao.updateById(eduCourse);
    }
}
