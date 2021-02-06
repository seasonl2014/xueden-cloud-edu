package cn.xueden.edu.dao;

import cn.xueden.common.core.edu.domain.EduSubject;
/*import com.baomidou.mybatisplus.mapper.BaseMapper;*/
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.springframework.stereotype.Repository;

/**功能描述：课程分类持久层
 * @Auther:梁志杰
 * @Date:2021/1/20
 * @Description:cn.xueden.edu.dao
 * @version:1.0
 */
@Repository
public interface EduSubjectDao extends BaseMapper<EduSubject> {
}
