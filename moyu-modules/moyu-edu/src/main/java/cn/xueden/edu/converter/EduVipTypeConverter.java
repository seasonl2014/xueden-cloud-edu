package cn.xueden.edu.converter;

import cn.xueden.common.core.edu.domain.EduVipType;
import cn.xueden.common.core.edu.domain.EduVipTypeSubject;
import cn.xueden.common.core.edu.vo.EduVipTypeSubjectVO;
import cn.xueden.common.core.edu.vo.EduVipTypeVO;
import org.springframework.beans.BeanUtils;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;

/**功能描述：会员类型转换类
 * @Auther:梁志杰
 * @Date:2021/1/31
 * @Description:cn.xueden.edu.converter
 * @version:1.0
 */
public class EduVipTypeConverter {

    /**
     * 转VO
     * @param eduVipType
     * @return
     */
    public static EduVipTypeVO converterToEduVipTypeVO(EduVipType eduVipType){
        EduVipTypeVO eduVipTypeVO = new EduVipTypeVO();
        BeanUtils.copyProperties(eduVipType,eduVipTypeVO);
        return eduVipTypeVO;
    }

    /**
     * 转voList
     * @param eduVipTypes
     * @return
     */
    public static List<EduVipTypeVO> converterToVOList(List<EduVipType> eduVipTypes) {
        List<EduVipTypeVO> eduVipTypeVOS=new ArrayList<>();
        if(!CollectionUtils.isEmpty(eduVipTypes)){
            for (EduVipType eduVipType : eduVipTypes) {
                EduVipTypeVO eduVipTypeVO = new EduVipTypeVO();
                BeanUtils.copyProperties(eduVipType,eduVipTypeVO);
                eduVipTypeVOS.add(eduVipTypeVO);
            }
        }
        return eduVipTypeVOS;
    }

    /**
     * 转voList
     * @param eduVipTypeSubjectList
     * @return
     */
    public static List<EduVipTypeSubjectVO> converterTypeSubjectVOToVOList(List<EduVipTypeSubject> eduVipTypeSubjectList) {
        List<EduVipTypeSubjectVO> eduVipTypeVOS=new ArrayList<>();
        if(!CollectionUtils.isEmpty(eduVipTypeSubjectList)){
            for (EduVipTypeSubject eduVipType : eduVipTypeSubjectList) {
                EduVipTypeSubjectVO eduVipTypeVO = new EduVipTypeSubjectVO();
                BeanUtils.copyProperties(eduVipType,eduVipTypeVO);
                eduVipTypeVOS.add(eduVipTypeVO);
            }
        }
        return eduVipTypeVOS;
    }

}
