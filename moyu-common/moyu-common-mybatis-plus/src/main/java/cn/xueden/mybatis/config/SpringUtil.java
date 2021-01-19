package cn.xueden.mybatis.config;

/**功能描述：写的工具类为SpringUtil，实现ApplicationContextAware接口，
 * 并加入Component注解，让spring扫描到该bean
 * @Auther:梁志杰
 * @Date:2020/12/13
 * @Description:cn.xueden.mybatis.config
 * @version:1.0
 */

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

@Component
public class SpringUtil implements ApplicationContextAware {

    private Logger logger = LoggerFactory.getLogger(getClass());

    private static ApplicationContext applicationContext;

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        if(SpringUtil.applicationContext == null) {
            SpringUtil.applicationContext = applicationContext;
        }


        logger.info("---------------------------------------------------------------------");

        logger.info("---------------------------------------------------------------------");

        logger.info("---------------cn.xueden.mybatis.config.SpringUtil------------------------------------------------------");

        logger.info("========ApplicationContext配置成功,在普通类可以通过调用SpringUtils.getAppContext()获取applicationContext对象,applicationContext="+SpringUtil.applicationContext+"========");

        logger.info("---------------------------------------------------------------------");
    }

    //获取applicationContext
    public static ApplicationContext getApplicationContext() {
        return applicationContext;
    }

    //通过name获取 Bean.
    public static Object getBean(String name){
        return getApplicationContext().getBean(name);
    }

    //通过class获取Bean.
    public static <T> T getBean(Class<T> clazz){
        return getApplicationContext().getBean(clazz);
    }

    //通过name,以及Clazz返回指定的Bean
    public static <T> T getBean(String name,Class<T> clazz){
        return getApplicationContext().getBean(name, clazz);
    }

}
