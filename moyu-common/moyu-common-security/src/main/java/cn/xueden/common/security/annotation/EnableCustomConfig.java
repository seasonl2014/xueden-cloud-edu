package cn.xueden.common.security.annotation;

import cn.xueden.common.security.config.ApplicationConfig;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.context.annotation.Import;
import org.springframework.scheduling.annotation.EnableAsync;

import java.lang.annotation.*;

/**功能描述：自定义注解
 * @Auther:梁志杰
 * @Date:2020/9/24
 * @Description:cn.xueden.common.security.annotation
 * @version:1.0
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Inherited
// 表示通过aop框架暴露该代理对象,AopContext能够访问
@EnableAspectJAutoProxy(exposeProxy = true)
// 指定要扫描的Mapper类的包的路径
@MapperScan("cn.xueden.system.dao")
// 开启线程异步执行
@EnableAsync
// 自动加载类
@Import({ApplicationConfig.class})
public @interface EnableCustomConfig {
}
