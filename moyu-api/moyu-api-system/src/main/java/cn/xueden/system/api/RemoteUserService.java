package cn.xueden.system.api;

import cn.xueden.common.core.constant.ServiceNameConstants;
import cn.xueden.common.core.domain.R;
import cn.xueden.system.api.factory.RemoteUserFallbackFactory;
import cn.xueden.system.api.model.LoginUser;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/**功能描述：用户服务
 * @Auther:梁志杰
 * @Date:2020/9/25
 * @Description:cn.xueden.system.api
 * @version:1.0
 */
@FeignClient(contextId = "remoteUserService", value = ServiceNameConstants.SYSTEM_SERVICE, fallbackFactory = RemoteUserFallbackFactory.class)
public interface RemoteUserService {
    /**
     * 通过用户名查询用户信息
     *
     * @param username 用户名
     * @return 结果
     */
    @GetMapping(value = "/system/user/info/{username}")
    public R<LoginUser> getUserInfo(@PathVariable("username") String username);
}
