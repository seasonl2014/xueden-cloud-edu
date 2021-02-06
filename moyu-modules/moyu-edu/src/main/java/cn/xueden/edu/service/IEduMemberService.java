package cn.xueden.edu.service;

import cn.xueden.common.core.edu.domain.EduMember;
import com.baomidou.mybatisplus.extension.service.IService;
/*import com.baomidou.mybatisplus.service.IService;*/

/**功能描述：会员业务接口
 * @Auther:梁志杰
 * @Date:2021/1/30
 * @Description:cn.xueden.edu.service
 * @version:1.0
 */
public interface IEduMemberService extends IService<EduMember> {

    // 统计注册会员
    int getMemberTotal();
}
