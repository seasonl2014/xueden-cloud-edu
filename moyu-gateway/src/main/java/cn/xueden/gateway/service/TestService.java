package cn.xueden.gateway.service;

import com.alibaba.csp.sentinel.annotation.SentinelResource;
import org.springframework.stereotype.Service;

/**
 * @Auther:梁志杰
 * @Date:2020/12/11
 * @Description:cn.xueden.gateway.service
 * @version:1.0
 */
@Service
public class TestService {
    @SentinelResource(value = "sayHello")
    public String sayHello(String name) {
        return "Hello, " + name;
    }
}
