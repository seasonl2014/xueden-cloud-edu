package cn.xueden.common.security.annotation;

import org.springframework.cloud.openfeign.EnableFeignClients;

import java.lang.annotation.*;

/**功能描述：自定义feign注解
 *          添加basePackages路径
 * @Auther:梁志杰
 * @Date:2020/9/24
 * @Description:cn.xueden.common.security.annotation
 * @version:1.0
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@EnableFeignClients
public @interface EnableMoYuFeignClients {

    String[] value() default {};

    String[] basePackages() default { "cn.xueden" };

    Class<?>[] basePackageClasses() default {};

    Class<?>[] defaultConfiguration() default {};

    Class<?>[] clients() default {};
}
