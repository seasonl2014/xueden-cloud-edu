package cn.xueden.edu.service.impl;

import cn.xueden.common.core.edu.domain.EduMember;
import cn.xueden.edu.dao.EduMemberDao;
import cn.xueden.edu.service.IEduMemberService;
/*import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;*/
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**功能描述：会员业务接口实现类
 * @Auther:梁志杰
 * @Date:2021/1/30
 * @Description:cn.xueden.edu.service.impl
 * @version:1.0
 */
@Service
public class EduMemberServiceImpl extends ServiceImpl<EduMemberDao, EduMember> implements IEduMemberService {

    @Autowired
    private EduMemberDao eduMemberDao;
    /**
     * 统计注册会员
     * @return
     */
    @Override
    public int getMemberTotal() {
        QueryWrapper<EduMember> EduMemberEntityWrapper = new QueryWrapper();
        return eduMemberDao.selectCount(EduMemberEntityWrapper);
    }
}
