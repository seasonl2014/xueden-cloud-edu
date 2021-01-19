package cn.xueden.gateway.handler;

import cn.xueden.common.core.exception.CaptchaException;
import cn.xueden.common.core.web.domain.AjaxResult;
import cn.xueden.gateway.service.IValidateCodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.server.HandlerFunction;
import org.springframework.web.reactive.function.server.ServerRequest;
import org.springframework.web.reactive.function.server.ServerResponse;
import reactor.core.publisher.Mono;

import java.io.IOException;

/**功能描述：验证码获取
 * @Auther:梁志杰
 * @Date:2020/9/25
 * @Description:cn.xueden.gateway.handler
 * @version:1.0
 */
@Component
public class ValidateCodeHandler implements HandlerFunction<ServerResponse> {

    @Autowired
    private IValidateCodeService validateCodeService;

    @Override
    public Mono<ServerResponse> handle(ServerRequest serverRequest){
        AjaxResult ajax;
        try
        {
            ajax = validateCodeService.createCapcha();
        }
        catch (CaptchaException | IOException e)
        {
            return Mono.error(e);
        }
        return ServerResponse.status(HttpStatus.OK).body(BodyInserters.fromValue(ajax));
    }
}
