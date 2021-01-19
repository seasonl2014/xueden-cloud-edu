package cn.xueden.common.security.config;

import org.springframework.boot.autoconfigure.jackson.Jackson2ObjectMapperBuilderCustomizer;
import org.springframework.context.annotation.Bean;

import java.util.TimeZone;

/**功能描述：系统配置
 * @Auther:梁志杰
 * @Date:2020/9/24
 * @Description:cn.xueden.common.security.config
 * @version:1.0
 */
public class ApplicationConfig {

    /**
     * 时区配置
     */
    @Bean
    public Jackson2ObjectMapperBuilderCustomizer jacksonObjectMapperCustomization()
    {
        return jacksonObjectMapperBuilder -> jacksonObjectMapperBuilder.timeZone(TimeZone.getDefault());
    }
}
