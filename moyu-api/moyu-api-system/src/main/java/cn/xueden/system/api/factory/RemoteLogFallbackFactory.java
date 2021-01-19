package cn.xueden.system.api.factory;

import cn.xueden.common.core.domain.R;
import cn.xueden.common.core.web.domain.SysLog;
import cn.xueden.system.api.RemoteLogService;
import feign.hystrix.FallbackFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**功能描述：日志服务降级处理
 * @Auther:梁志杰
 * @Date:2020/9/27
 * @Description:cn.xueden.system.api.factory
 * @version:1.0
 */
@Component
public class RemoteLogFallbackFactory implements FallbackFactory<RemoteLogService> {
    private static final Logger log = LoggerFactory.getLogger(RemoteLogFallbackFactory.class);

    @Override
    public RemoteLogService create(Throwable throwable)
    {
        log.error("日志服务调用失败:{}", throwable.getMessage());
        return new RemoteLogService()
        {
            @Override
            public R<Boolean> saveLog(SysLog sysOperLog)
            {
                return null;
            }

            @Override
            public R<Boolean> saveLogininfor(String username, String status, String message)
            {
                return null;
            }
        };

    }
}
