package cn.xueden.common.log.annotation;

import java.lang.annotation.*;

/**功能描述:其他系统日志注解
 * @Auther:http://www.xueden.cn
 * @Date:2021/1/21
 * @Description:cn.xueden.annotation
 * @version:1.0
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface XudenOtherSystemLog {

    String value() default "";
}
