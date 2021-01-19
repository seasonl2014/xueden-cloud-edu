package cn.xueden.system;

import cn.xueden.common.security.annotation.EnableCustomConfig;
import cn.xueden.common.security.annotation.EnableMoYuFeignClients;
import cn.xueden.common.swagger.annotation.EnableCustomSwagger2;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.cloud.client.SpringCloudApplication;

/**
 * 系统模块
 *
 */
@EnableCustomConfig
@EnableMoYuFeignClients
@EnableCustomSwagger2
@SpringCloudApplication
public class MoYuSystemApplication
{
    public static void main( String[] args )
    {
        SpringApplication.run(MoYuSystemApplication.class, args);
    }
}
