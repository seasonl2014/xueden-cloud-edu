package cn.xueden.system.api;

import cn.xueden.common.core.constant.ServiceNameConstants;
import cn.xueden.common.core.domain.R;
import cn.xueden.common.core.web.domain.SysLog;
import cn.xueden.system.api.factory.RemoteLogFallbackFactory;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

/**功能描述：日志服务接口
 * @Auther:梁志杰
 * @Date:2020/9/27
 * @Description:cn.xueden.system.api
 * @version:1.0
 */
@FeignClient(contextId = "remoteLogService", value = ServiceNameConstants.SYSTEM_SERVICE, fallbackFactory = RemoteLogFallbackFactory.class)
public interface RemoteLogService {

    /**
     * 保存系统日志
     *
     * @param sysOperLog 日志实体
     * @return 结果
     */
    @PostMapping("/operlog")
    R<Boolean> saveLog(@RequestBody SysLog sysOperLog);

    /**
     * 保存访问记录
     *
     * @param username 用户名称
     * @param status 状态
     * @param message 消息
     * @return 结果
     */
    @PostMapping("/system/log")
    R<Boolean> saveLogininfor(@RequestParam("username") String username, @RequestParam("status") String status,
                              @RequestParam("message") String message);
}
