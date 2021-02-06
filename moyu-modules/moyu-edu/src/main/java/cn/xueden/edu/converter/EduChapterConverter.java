package cn.xueden.edu.converter;

import cn.xueden.common.core.edu.domain.EduChapter;
import cn.xueden.common.core.edu.domain.EduVideo;
import cn.xueden.common.core.edu.vo.EduChapterTreeNodeVO;
import cn.xueden.common.core.edu.vo.EduChapterVO;
import cn.xueden.edu.dao.EduVideoDao;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.beans.BeanUtils;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;

/**功能描述：章节转换类
 * @Auther:梁志杰
 * @Date:2021/1/24
 * @Description:cn.xueden.edu.converter
 * @version:1.0
 */
public class EduChapterConverter {
    /**
     * 转vo
     * @param eduChapter
     * @return
     */
    public static EduChapterVO converterToEduChapterVO(EduChapter eduChapter) {
        EduChapterVO eduChapterVO = new EduChapterVO();
        BeanUtils.copyProperties(eduChapter,eduChapterVO);
        return eduChapterVO;
    }

    /**
     * 转voList
     * @param eduChapters
     * @return
     */
    public static List<EduChapterVO> converterToVOList(List<EduChapter> eduChapters) {
        List<EduChapterVO> eduChapterVOS=new ArrayList<>();
        if(!CollectionUtils.isEmpty(eduChapters)){
            for (EduChapter eduChapter : eduChapters) {
                EduChapterVO eduChapterVO = new EduChapterVO();
                BeanUtils.copyProperties(eduChapter,eduChapterVO);
                eduChapterVOS.add(eduChapterVO);
            }
        }
        return eduChapterVOS;
    }


    /**
     * 转树节点
     * @param eduChapterVOList
     * @return
     */
    public static List<EduChapterTreeNodeVO> converterToTreeNodeVO(List<EduChapterVO> eduChapterVOList,
                                                                   EduVideoDao eduVideoMapper) {
        List<EduChapterTreeNodeVO> nodes=new ArrayList<>();
        if(!CollectionUtils.isEmpty(eduChapterVOList)){
            for (EduChapterVO eduChapterVO : eduChapterVOList) {
                QueryWrapper<EduVideo> videoEntityWrapper = new QueryWrapper();
                videoEntityWrapper.eq("chapter_id",eduChapterVO.getId());
                videoEntityWrapper.orderByAsc("sort");
                List<EduVideo> eduVideoList = eduVideoMapper.selectList(videoEntityWrapper);

                // 统计章节总时长
                float totalChapterDuration=0f;
                for (EduVideo video:eduVideoList){
                    totalChapterDuration+=video.getDuration();
                }
                eduChapterVO.setDuration(totalChapterDuration);
                eduChapterVO.setChildren(eduVideoList);
                EduChapterTreeNodeVO eduSubjectTreeNodeVO = new EduChapterTreeNodeVO();
                BeanUtils.copyProperties(eduChapterVO,eduSubjectTreeNodeVO);
                nodes.add(eduSubjectTreeNodeVO);
            }
        }
        return nodes;
    }
}

