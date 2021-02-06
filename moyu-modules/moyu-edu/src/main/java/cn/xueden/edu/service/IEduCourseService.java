package cn.xueden.edu.service;


import cn.xueden.common.core.edu.domain.EduCourse;
import cn.xueden.common.core.edu.vo.EduCourseVO;
import com.baomidou.mybatisplus.extension.service.IService;
/*import com.baomidou.mybatisplus.service.IService;*/

import java.util.List;

/**功能描述：课程 服务接口类
 * @Auther:梁志杰
 * @Date:2021/1/22
 * @Description:cn.xueden.edu.service
 * @version:1.0
 */
public interface IEduCourseService extends IService<EduCourse> {

    /**
     * 获取课程信息
     * @param id
     * @return
     */
    EduCourseVO getById(Long id);

    /**
     * 首页获取课程列表
     * @param pageNum
     * @param pageSize
     * @param eduCourseVO
     * @return
     */
    List<EduCourseVO> findIndexCourseList(Integer pageNum, Integer pageSize, EduCourseVO eduCourseVO);


    /**
     * 更新课程查看次数
     * @param eduCourseVO
     */
    void updateViewCount(EduCourseVO eduCourseVO);

}
