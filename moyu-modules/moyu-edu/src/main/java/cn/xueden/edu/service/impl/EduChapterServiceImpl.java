package cn.xueden.edu.service.impl;

import cn.xueden.common.core.edu.domain.EduChapter;
import cn.xueden.common.core.edu.domain.EduVideo;
import cn.xueden.common.core.edu.vo.EduChapterTreeNodeVO;
import cn.xueden.common.core.edu.vo.EduChapterVO;
import cn.xueden.common.core.edu.vo.PageVO;
import cn.xueden.common.core.utils.EduChapterTreeBuilder;
import cn.xueden.common.core.utils.ListPageUtils;
import cn.xueden.edu.converter.EduChapterConverter;
import cn.xueden.edu.dao.EduChapterDao;
import cn.xueden.edu.dao.EduVideoDao;
import cn.xueden.edu.service.IEduChapterService;
/*import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;*/
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**功能描述：课程大章业务接口实现类
 * @Auther:梁志杰
 * @Date:2021/1/24
 * @Description:cn.xueden.edu.service.impl
 * @version:1.0
 */
@Service
public class EduChapterServiceImpl extends ServiceImpl<EduChapterDao, EduChapter> implements IEduChapterService {

    @Autowired
    private EduChapterDao eduChapterDao;

    @Autowired
    private EduVideoDao eduVideoDao;

    /**
     * 章节树形结构
     * @param pageNum
     * @param pageSize
     * @param eduChapterVO
     * @return
     */
    @Override
    public PageVO<EduChapterTreeNodeVO> chapterTree(Integer pageNum, Integer pageSize, EduChapterVO eduChapterVO) {
        // 获取课程大章
        List<EduChapterVO> eduChapterVOS = findAllByEduChapter(eduChapterVO);
        List<EduChapterTreeNodeVO> nodeVOS=EduChapterConverter.converterToTreeNodeVO(eduChapterVOS,eduVideoDao);
        List<EduChapterTreeNodeVO> tree = EduChapterTreeBuilder.build(nodeVOS);
        List<EduChapterTreeNodeVO> page;
        if(pageSize!=null&&pageNum!=null){
            page= ListPageUtils.page(tree, pageSize, pageNum);
            return new PageVO<>(tree.size(),page);
        }else {
            return new PageVO<>(tree.size(), tree);
        }
    }

    /**
     * 根据课程ID获取所有章节
     * @param eduChapterVO
     * @return
     */
    @Override
    public List<EduChapterVO> findAllByEduChapter(EduChapterVO eduChapterVO) {
        QueryWrapper<EduChapter> chapterEntityWrapper = new QueryWrapper();
        chapterEntityWrapper.eq("course_id",eduChapterVO.getCourseId());
        List<EduChapter> eduChapters = eduChapterDao.selectList(chapterEntityWrapper);
        return EduChapterConverter.converterToVOList(eduChapters);
    }

    /**
     * 获取课程大纲
     * @param eduChapterVO
     * @return
     */
    @Override
    public List<EduChapterVO> findAllByEduChapterAndVideo(EduChapterVO eduChapterVO) {
        QueryWrapper<EduChapter> chapterEntityWrapper = new QueryWrapper();
        chapterEntityWrapper.eq("course_id",eduChapterVO.getCourseId());
        List<EduChapter> eduChapters = eduChapterDao.selectList(chapterEntityWrapper);
        List<EduChapterVO> eduChapterVOList = EduChapterConverter.converterToVOList(eduChapters);

        // 获取课程视频小节
        for (EduChapterVO chapterVO:eduChapterVOList){
            QueryWrapper<EduVideo> videoEntityWrapper = new QueryWrapper();
            videoEntityWrapper.eq("chapter_id",chapterVO.getId());
            videoEntityWrapper.orderByAsc("sort");
            List<EduVideo> eduVideoList = eduVideoDao.selectList(videoEntityWrapper);
            chapterVO.setChildren(eduVideoList);
        }
        return eduChapterVOList;
    }

}
