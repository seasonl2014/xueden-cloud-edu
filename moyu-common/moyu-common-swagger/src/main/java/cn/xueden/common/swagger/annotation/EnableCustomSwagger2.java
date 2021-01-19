package cn.xueden.common.swagger.annotation;

import cn.xueden.common.swagger.config.SwaggerAutoConfiguration;
import org.springframework.context.annotation.Import;

import java.lang.annotation.*;

/**功能描述：自定义注解
 * @Auther:梁志杰
 * @Date:2020/9/25
 * @Description:cn.xueden.common.swagger.annotation
 * @version:1.0
 */
@Target({ ElementType.TYPE })
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Inherited
@Import({ SwaggerAutoConfiguration.class })
public @interface EnableCustomSwagger2 {
}
