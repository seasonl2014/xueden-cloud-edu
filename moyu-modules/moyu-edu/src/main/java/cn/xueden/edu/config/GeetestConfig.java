package cn.xueden.edu.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * GeetestWeb配置文件
 * 
 *
 */
@Configuration
@ConfigurationProperties(prefix = "xueden.geetest")
@Data
public class GeetestConfig {

	// 填入自己的captcha_id和private_key
	private  String geetest_id ;

	private  String geetest_key ;

	private  boolean newfailback = true;



}
