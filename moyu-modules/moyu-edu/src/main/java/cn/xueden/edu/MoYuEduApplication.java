package cn.xueden.edu;

import cn.xueden.common.security.annotation.EnableCustomConfig;
import cn.xueden.common.security.annotation.EnableMoYuFeignClients;
import cn.xueden.common.swagger.annotation.EnableCustomSwagger2;
import org.springframework.boot.SpringApplication;
import org.springframework.cloud.client.SpringCloudApplication;
import org.springframework.scheduling.annotation.EnableAsync;

/**
 * 在线教育模块
 *
 */
@EnableCustomConfig
@EnableMoYuFeignClients
@EnableCustomSwagger2
@SpringCloudApplication
@EnableAsync
public class MoYuEduApplication
{
    public static void main( String[] args )
    {
        SpringApplication.run(MoYuEduApplication.class, args);
    }
}
