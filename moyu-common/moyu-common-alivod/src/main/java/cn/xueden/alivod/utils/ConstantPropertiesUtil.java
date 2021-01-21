package cn.xueden.alivod.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**初始化阿里云视频点播配置信息
 * @Auther:梁志杰
 * @Date:2021/1/20
 * @Description:cn.xueden.alivod.utils
 * @version:1.0
 */
@Component
public class ConstantPropertiesUtil implements InitializingBean {

    private static final Logger LOGGER = LoggerFactory.getLogger(ConstantPropertiesUtil.class);

    @Value("${aliyun.vod.file.keyid}")
    private String keyid;

    @Value("${aliyun.vod.file.keysecret}")
    private String keysecret;

    @Value("${aliyun.vod.file.templategroupid}")
    private String templategroupid;//转码组ID

    public static String ACCESS_KEY_ID;
    public static String ACCESS_KEY_SECRET;

    public static String TEMPLATE_GROUPID;

    @Override
    public void afterPropertiesSet() throws Exception {
        ACCESS_KEY_ID = keyid;
        ACCESS_KEY_SECRET = keysecret;
        TEMPLATE_GROUPID = templategroupid;
        LOGGER.info("----------完成初始化阿里云视频点播配置信息---------{}");
    }
}
