package cn.xueden.edu.service;

import cn.xueden.common.core.edu.domain.EduMemberBuyVip;
import cn.xueden.common.core.edu.domain.EduVipType;
import cn.xueden.common.core.edu.vo.EduVipTypeSubjectVO;
import cn.xueden.common.core.edu.vo.EduVipTypeVO;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;


import java.util.List;
import java.util.Set;

/**功能描述：会员类型业务接口
 * @Auther:梁志杰
 * @Date:2021/1/31
 * @Description:cn.xueden.edu.service
 * @version:1.0
 */
public interface IEduVipTypeService extends IService<EduVipType> {

    // 获取所有会员类型
    List<EduVipTypeVO> getAllVip();

    // 根据会员类型ID获取该会员类型下的权益
    List<EduVipTypeSubjectVO> getVipSubject(Long vipId);

    // 用户加入VIP
    EduMemberBuyVip addVip(Long id, String token, String ipAddress);

    // 分页获取会员类型列表
    Page<EduVipTypeVO> findVipTypeList(Integer page,Integer limit, EduVipTypeVO eduVipTypeVO);

    // 分配权益
    void assignVipType(Long id, Set<Long> rids);
}
