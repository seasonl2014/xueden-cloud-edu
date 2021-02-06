package cn.xueden.edu.api.factory;

import cn.xueden.common.core.domain.R;
import cn.xueden.common.core.edu.vo.EduMemberVO;
import cn.xueden.edu.api.RemoteMemberService;
import feign.hystrix.FallbackFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @Auther:梁志杰
 * @Date:2021/1/30
 * @Description:cn.xueden.edu.api.factory
 * @version:1.0
 */
public class RemoteMemberFallbackFactory implements FallbackFactory<RemoteMemberService> {
    private static final Logger log = LoggerFactory.getLogger(RemoteMemberFallbackFactory.class);

    @Override
    public RemoteMemberService create(Throwable throwable)
    {
        log.error("用户服务调用失败:{}", throwable.getMessage());
        return new RemoteMemberService()
        {
            @Override
            public R<EduMemberVO> getMemberInfo(String mobile)
            {
                return R.fail("获取会员失败:" + throwable.getMessage());
            }
        };
    }
}
