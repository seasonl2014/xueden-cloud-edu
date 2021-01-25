package cn.xueden.edu.service;

import cn.xueden.common.core.edu.domain.EduChapter;
import cn.xueden.common.core.edu.vo.EduChapterTreeNodeVO;
import cn.xueden.common.core.edu.vo.EduChapterVO;
import cn.xueden.common.core.edu.vo.PageVO;
import com.baomidou.mybatisplus.service.IService;

import java.util.List;

/**功能描述：课程大章大章业务接口
 * @Auther:梁志杰
 * @Date:2021/1/24
 * @Description:cn.xueden.edu.service
 * @version:1.0
 */
public interface IEduChapterService extends IService<EduChapter> {

    /**
     * 章节树形
     * @return
     */
    PageVO<EduChapterTreeNodeVO> chapterTree(Integer pageNum, Integer pageSize, EduChapterVO eduChapterVO);

    /**
     * 查询所课程章节
     * @return
     */
    List<EduChapterVO> findAllByEduChapter(EduChapterVO eduChapterVO);

    /**
     * 获取课程大纲
     * @param eduChapterVO
     * @return
     */
    List<EduChapterVO> findAllByEduChapterAndVideo(EduChapterVO eduChapterVO);

}
