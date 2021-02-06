package cn.xueden.edu.api;

import cn.xueden.common.core.constant.ServiceNameConstants;
import cn.xueden.common.core.domain.R;

import cn.xueden.common.core.edu.vo.EduMemberVO;
import cn.xueden.edu.api.factory.RemoteMemberFallbackFactory;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/**功能描述：教育平台服务接口
 * @Auther:梁志杰
 * @Date:2021/1/30
 * @Description:cn.xueden.edu.api
 * @version:1.0
 */
@FeignClient(contextId = "remoteMemberService", value = ServiceNameConstants.EDU_SERVICE, fallbackFactory = RemoteMemberFallbackFactory.class)
public interface RemoteMemberService {

    /**
     * 通过手机号查询用户信息
     *
     * @param mobile 手机号
     * @return 结果
     */
    @GetMapping(value = "/edu/member/info/{mobile}")
    public R<EduMemberVO> getMemberInfo(@PathVariable("mobile") String mobile);
}
