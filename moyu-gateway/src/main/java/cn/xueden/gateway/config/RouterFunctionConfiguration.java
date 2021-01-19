package cn.xueden.gateway.config;

import cn.xueden.gateway.handler.ValidateCodeHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.web.reactive.function.server.RequestPredicates;
import org.springframework.web.reactive.function.server.RouterFunction;
import org.springframework.web.reactive.function.server.RouterFunctions;

/**功能描述：路由配置信息
 * @Auther:梁志杰
 * @Date:2020/9/24
 * @Description:cn.xueden.gateway.config
 * @version:1.0
 */
@Configuration
public class RouterFunctionConfiguration {

    @Autowired
    private ValidateCodeHandler validateCodeHandler;

    @Bean
    public RouterFunction routerFunction()
    {
        return RouterFunctions.route(
                RequestPredicates.GET("/code").and(RequestPredicates.accept(MediaType.TEXT_PLAIN)),
                validateCodeHandler);
    }
}
