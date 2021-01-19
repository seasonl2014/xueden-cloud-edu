package cn.xueden.auth;

import cn.xueden.common.security.annotation.EnableMoYuFeignClients;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.cloud.client.SpringCloudApplication;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 认证授权中心
 *
 */
@EnableMoYuFeignClients
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class })
@RestController
@RefreshScope
public class MoYuAuthApplication
{
    public static void main( String[] args )
    {
        SpringApplication.run(MoYuAuthApplication.class, args);
    }

   /* @Value("${nacos.config}")
    private String config;

    @RequestMapping("/getValue")
    public String getValue() {
        return config;
    }*/
}
