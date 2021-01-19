package cn.xueden.common.log.annotation;

import java.lang.annotation.*;

/**功能描述:系统日志注解
 * @Auther:http://www.xueden.cn
 * @Date:2020/3/6
 * @Description:cn.xueden.annotation
 * @version:1.0
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface XudenSysLog {

    String value() default "";
}
