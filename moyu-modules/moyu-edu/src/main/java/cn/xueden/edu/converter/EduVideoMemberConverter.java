package cn.xueden.edu.converter;

import cn.xueden.common.core.edu.domain.EduCourse;
import cn.xueden.common.core.edu.domain.EduVideo;
import cn.xueden.common.core.edu.domain.EduVideoMember;
import cn.xueden.common.core.edu.vo.EduVideoMemberVO;
import cn.xueden.edu.service.IEduCourseService;
import cn.xueden.edu.service.IEduVideoService;
import org.springframework.beans.BeanUtils;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;

/**功能描述：视频观看记录转换类
 * @Auther:梁志杰
 * @Date:2021/2/18
 * @Description:cn.xueden.edu.converter
 * @version:1.0
 */
public class EduVideoMemberConverter {

    /**
     * 转voList
     * @param eduVideoMembers
     * @param eduVideoService
     * @return
     */
    public static List<EduVideoMemberVO> converterToVOList(List<EduVideoMember> eduVideoMembers, IEduVideoService eduVideoService) {
        List<EduVideoMemberVO> eduVideoMemberVOS=new ArrayList<>();
        if(!CollectionUtils.isEmpty(eduVideoMembers)){
            for (EduVideoMember eduVideoMember : eduVideoMembers) {
                EduVideoMemberVO eduVideoMemberVO = new EduVideoMemberVO();
                BeanUtils.copyProperties(eduVideoMember,eduVideoMemberVO);
                EduVideo eduVideo = eduVideoService.getById(eduVideoMember.getVideoId());
                eduVideoMemberVO.setEduVideo(eduVideo);
                eduVideoMemberVOS.add(eduVideoMemberVO);
            }
        }
        return eduVideoMemberVOS;
    }

}
