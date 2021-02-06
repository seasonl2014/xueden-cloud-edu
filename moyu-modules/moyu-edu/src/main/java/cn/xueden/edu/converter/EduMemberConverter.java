package cn.xueden.edu.converter;

import cn.xueden.common.core.edu.domain.EduMember;
import cn.xueden.common.core.edu.domain.EduVipType;
import cn.xueden.common.core.edu.vo.EduMemberVO;
import cn.xueden.edu.dao.EduVipTypeDao;
import org.springframework.beans.BeanUtils;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;

/**功能描述：会员转换类
 * @Auther:梁志杰
 * @Date:2021/1/30
 * @Description:cn.xueden.edu.converter
 * @version:1.0
 */
public class EduMemberConverter {

    /**
     * 转VO
     * @param member
     * @return
     */
    public static EduMemberVO converterToEduMemberVO(EduMember member){
        EduMemberVO eduMemberVO = new EduMemberVO();
        BeanUtils.copyProperties(member,eduMemberVO);
        return eduMemberVO;
    }

    /**
     * 转voList
     * @param members
     * @return
     */
    public static List<EduMemberVO>   converterToEduMemberVOList(List<EduMember> members, EduVipTypeDao vipTypeDao){
        List<EduMemberVO> eduMemberVOS = new ArrayList<>();
        if(!CollectionUtils.isEmpty(members)){
            for(EduMember eduMember:members){
                EduMemberVO d = new EduMemberVO();
                BeanUtils.copyProperties(eduMember,d);

                // 根据会员ID获取会员类型
                EduVipType eduVipType = vipTypeDao.selectById(eduMember.getVipId());
                d.setVipType(eduVipType.getName());
                eduMemberVOS.add(d);

            }
        }

        return eduMemberVOS;
    }

}
