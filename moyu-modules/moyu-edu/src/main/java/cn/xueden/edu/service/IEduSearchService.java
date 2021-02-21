package cn.xueden.edu.service;

/**搜索服务
 * @Auther:梁志杰
 * @Date:2021/2/16
 * @Description:cn.xueden.edu.service
 * @version:1.0
 */
public interface IEduSearchService {

    /**
     * 同步单个索引
     *
     * @param type 0 更新索引 1 删除索引
     * @param courseId 课程 id
     * @return
     */
    void refreshCourse(int type, Long courseId);

    /**
     * 同步所有索引
     *
     * @return
     */
    void importAllCourses();


}
