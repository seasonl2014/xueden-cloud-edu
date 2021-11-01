package cn.xueden.edu.dao;

import cn.xueden.search.domain.CourseESItem;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**功能描述：Elasticsearch持久层
 * @Auther:梁志杰
 * @Date:2021/2/15
 * @Description:cn.xueden.edu.dao
 * @version:1.0
 */

public interface EduCourseElasticsearchDao extends ElasticsearchRepository<CourseESItem, Long> {
}
