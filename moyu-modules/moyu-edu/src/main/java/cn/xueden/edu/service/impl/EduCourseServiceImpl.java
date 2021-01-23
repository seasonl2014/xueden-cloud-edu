package cn.xueden.edu.service.impl;

import cn.xueden.common.core.edu.domain.EduCourse;

import cn.xueden.edu.dao.EduCourseDao;
import cn.xueden.edu.service.IEduCourseService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**课程 服务实现类
 * @Auther:梁志杰
 * @Date:2021/1/23
 * @Description:cn.xueden.edu.service.impl
 * @version:1.0
 */
@Service
public class EduCourseServiceImpl extends ServiceImpl<EduCourseDao, EduCourse> implements IEduCourseService {
}
