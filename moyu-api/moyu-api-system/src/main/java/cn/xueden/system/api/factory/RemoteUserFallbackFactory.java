package cn.xueden.system.api.factory;

import cn.xueden.common.core.domain.R;
import cn.xueden.system.api.RemoteUserService;
import cn.xueden.system.api.model.LoginUser;
import feign.hystrix.FallbackFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**功能描述：用户服务降级处理
 * @Auther:梁志杰
 * @Date:2020/9/25
 * @Description:cn.xueden.system.api.factory
 * @version:1.0
 */
public class RemoteUserFallbackFactory implements FallbackFactory<RemoteUserService> {
    private static final Logger log = LoggerFactory.getLogger(RemoteUserFallbackFactory.class);

    @Override
    public RemoteUserService create(Throwable throwable)
    {
        log.error("用户服务调用失败:{}", throwable.getMessage());
        return new RemoteUserService()
        {
            @Override
            public R<LoginUser> getUserInfo(String username)
            {
                return R.fail("获取用户失败:" + throwable.getMessage());
            }
        };
    }
}
