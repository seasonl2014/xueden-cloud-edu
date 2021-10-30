package cn.xueden.gateway.handler;

import cn.xueden.common.core.exception.CaptchaException;
import cn.xueden.common.core.web.domain.AjaxResult;
import cn.xueden.common.redis.service.RedisService;
import cn.xueden.gateway.config.GeetestConfig;
import cn.xueden.gateway.config.GeetestLib;
import cn.xueden.gateway.response.ErrorResponse;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.server.HandlerFunction;
import org.springframework.web.reactive.function.server.ServerRequest;
import org.springframework.web.reactive.function.server.ServerResponse;
import reactor.core.publisher.Mono;

import java.io.IOException;
import java.util.HashMap;

/**极验滑动验证码
 * @Auther:梁志杰
 * @Date:2021/10/30
 * @Description:cn.xueden.gateway.handler
 * @version:1.0
 */
@Component
public class GeetestHandler implements HandlerFunction<ServerResponse> {

    @Autowired
    private RedisService redisService;

    @Override
    public Mono<ServerResponse> handle(ServerRequest serverRequest) {
        String resStr = "{}";
        try{
            String mobile=serverRequest.exchange().getRequest().getQueryParams().getFirst("mobile");
            if(StringUtils.isEmpty(mobile)){
                return ServerResponse.status(HttpStatus.OK).body(BodyInserters.fromValue(new ErrorResponse("0001", "手机号不能为空！")));
            }

            //初始化验证码
            GeetestLib gtSdk = new GeetestLib(GeetestConfig.getGeetest_id(), GeetestConfig.getGeetest_key(),
                    GeetestConfig.isnewfailback());

            String userid = mobile;

            //自定义参数,可选择添加
            HashMap<String, String> param = new HashMap<String, String>();
            param.put("user_id", userid); //网站用户id
            param.put("client_type", "web"); //web:电脑上的浏览器；h5:手机上的浏览器，包括移动应用内完全内置的web_view；native：通过原生SDK植入APP应用的方式
            param.put("ip_address", "127.0.0.1"); //传输用户请求验证时所携带的IP

            //进行验证预处理
            int gtServerStatus = gtSdk.preProcess(param);
            // 将服务器状态设置到redis中
            redisService.setCacheObject(gtSdk.gtServerStatusSessionKey,gtServerStatus);
            //将userid设置到session中
            redisService.setCacheObject("userid",userid);
            resStr = gtSdk.getResponseStr();
        }
        catch (CaptchaException e){
            return Mono.error(e);
        }
        return ServerResponse.status(HttpStatus.OK).body(BodyInserters.fromValue(resStr));
    }
}
