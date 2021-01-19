package cn.xueden.gateway.filter;

import cn.xueden.common.core.constant.CacheConstants;
import cn.xueden.common.core.constant.Constants;
import cn.xueden.common.core.domain.R;
import cn.xueden.common.core.utils.XudenStringUtils;
import cn.xueden.common.redis.service.RedisService;
import cn.xueden.gateway.config.properties.IgnoreWhiteProperties;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.Ordered;
import org.springframework.core.io.buffer.DataBufferFactory;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import javax.annotation.Resource;

/**功能描述：网关鉴权
 * @Auther:梁志杰
 * @Date:2020/9/24
 * @Description:cn.xueden.gateway.filter
 * @version:1.0
 */
@Component
public class AuthFilter implements GlobalFilter, Ordered {

    private static final Logger log = LoggerFactory.getLogger(AuthFilter.class);

    private final static long EXPIRE_TIME = Constants.TOKEN_EXPIRE * 60;

    // 排除过滤的 uri 地址，nacos自行添加
    @Autowired
    private IgnoreWhiteProperties ignoreWhite;

    @Resource(name = "stringRedisTemplate")
    private ValueOperations<String, String> sops;

    @Autowired
    private RedisService redisService;

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain){
        String url = exchange.getRequest().getURI().getPath();
        // 跳过不需要验证的路径
        if (XudenStringUtils.matches(url, ignoreWhite.getWhites()))
        {
            return chain.filter(exchange);
        }
        String token = getToken(exchange.getRequest());
        if (XudenStringUtils.isBlank(token))
        {
            return setUnauthorizedResponse(exchange, "令牌不能为空");
        }
        String userStr = sops.get(getTokenKey(token));
        if (XudenStringUtils.isNull(userStr))
        {
            return setUnauthorizedResponse(exchange, "登录状态已过期");
        }
        JSONObject obj = JSONObject.parseObject(userStr);
        String userid = obj.getString("userid");
        String username = obj.getString("username");
        if (XudenStringUtils.isBlank(userid) || XudenStringUtils.isBlank(username))
        {
            return setUnauthorizedResponse(exchange, "令牌验证失败");
        }

        // 设置过期时间
        redisService.expire(getTokenKey(token), EXPIRE_TIME);
        // 设置用户信息到请求
        ServerHttpRequest mutableReq = exchange.getRequest().mutate().header(CacheConstants.DETAILS_USER_ID, userid)
                .header(CacheConstants.DETAILS_USERNAME, username).build();
        ServerWebExchange mutableExchange = exchange.mutate().request(mutableReq).build();

        return chain.filter(mutableExchange);
    }

    private String getTokenKey(String token)
    {
        return CacheConstants.LOGIN_TOKEN_KEY + token;
    }

    private Mono<Void> setUnauthorizedResponse(ServerWebExchange exchange, String msg){
        ServerHttpResponse response = exchange.getResponse();
        response.getHeaders().setContentType(MediaType.APPLICATION_JSON);
        response.setStatusCode(HttpStatus.OK);

        log.error("[鉴权异常处理]请求路径:{}", exchange.getRequest().getPath());

        return response.writeWith(Mono.fromSupplier(() -> {
            DataBufferFactory bufferFactory = response.bufferFactory();
            return bufferFactory.wrap(JSON.toJSONBytes(R.fail(msg)));
        }));
    }


    /**
     * 获取请求token
     */
    private String getToken(ServerHttpRequest request)
    {
        String token = request.getHeaders().getFirst(CacheConstants.HEADER);
        if (XudenStringUtils.isNotEmpty(token) && token.startsWith(CacheConstants.TOKEN_PREFIX))
        {
            token = token.replace(CacheConstants.TOKEN_PREFIX, "");
        }
        return token;
    }

    @Override
    public int getOrder()
    {
        return -200;
    }

}
