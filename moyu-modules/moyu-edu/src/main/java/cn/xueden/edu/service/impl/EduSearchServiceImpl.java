package cn.xueden.edu.service.impl;

import cn.xueden.common.core.edu.domain.EduCourse;
import cn.xueden.edu.dao.EduCourseDao;
import cn.xueden.edu.dao.EduCourseElasticsearchDao;
import cn.xueden.edu.service.IEduSearchService;
import cn.xueden.search.domain.CourseESItem;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @Auther:梁志杰
 * @Date:2021/2/16
 * @Description:cn.xueden.edu.service.impl
 * @version:1.0
 */
@Service
public class EduSearchServiceImpl implements IEduSearchService {

    @Autowired
    private EduCourseElasticsearchDao elasticsearchDao;

    @Autowired
    private EduCourseDao eduCourseDao;

    /**
     * 同步单个索引
     * @param type 0 更新索引 1 删除索引
     * @param courseId 课程 id
     */
    @Override
    public void refreshCourse(int type, Long courseId) {
        // 更新索引
        if (type == 0) {
            // 从数据库中查出数据
            EduCourse dbEduCourse = eduCourseDao.selectById(courseId);
            // 设置 ESItem
            if (dbEduCourse != null) {
                CourseESItem esCourse = new CourseESItem();
                esCourse.setId(dbEduCourse.getId());
                esCourse.setTitle(dbEduCourse.getTitle());
                esCourse.setCover(dbEduCourse.getCover());
                esCourse.setShortTitle(dbEduCourse.getShortTitle());
                esCourse.setPrice(dbEduCourse.getPrice());
                esCourse.setCourseType(dbEduCourse.getCourseType());
                esCourse.setLessonNum(dbEduCourse.getLessonNum());
                esCourse.setViewCount(dbEduCourse.getViewCount());
                // 更新索引
                elasticsearchDao.save(esCourse);
            }
        }

        // 删除索引
        else {
            elasticsearchDao.deleteById(courseId);
        }
    }

    /**
     * 同步所有索引
     *
     * @return
     */
    @Override
    public void importAllCourses() {
        // 从数据库中查询所有商品
        QueryWrapper<EduCourse> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("del_flag",false);
        List<EduCourse> tbItemList = eduCourseDao.selectList(queryWrapper);

        List<CourseESItem> esItems = new ArrayList<>();


        tbItemList.forEach(dbEduCourse->{

            CourseESItem esCourse = new CourseESItem();
            esCourse.setId(dbEduCourse.getId());
            esCourse.setTitle(dbEduCourse.getTitle());
            esCourse.setCover(dbEduCourse.getCover());
            esCourse.setShortTitle(dbEduCourse.getShortTitle());
            esCourse.setPrice(dbEduCourse.getPrice());
            esCourse.setCourseType(dbEduCourse.getCourseType());
            esCourse.setLessonNum(dbEduCourse.getLessonNum());
            esCourse.setViewCount(dbEduCourse.getViewCount());
            esItems.add(esCourse);

        });

        // 批量新增
        elasticsearchDao.saveAll(esItems);


    }
}
