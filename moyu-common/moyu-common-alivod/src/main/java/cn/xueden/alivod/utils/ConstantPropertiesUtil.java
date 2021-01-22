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

    @Value("${aliyun.oss.file.endpoint}")
    private String endpoint;

    @Value("${aliyun.oss.file.bucketname}")
    private String bucketname;

    //读取文件夹名称
    @Value("${aliyun.oss.file.host}")
    private String host;

    //文件访问域名
    @Value("${aliyun.oss.file.hostpath}")
    private String hostpath;

    @Value("${aliyun.vod.file.keyid}")
    private String keyid;

    @Value("${aliyun.vod.file.keysecret}")
    private String keysecret;

    @Value("${aliyun.vod.file.templategroupid}")
    private String templategroupid;//转码组ID

    //定义常量，为了能够使用
    public static String END_POINT;
    public static String BUCKET_NAME;
    public static String HOST;
    public static String HOST_PATH;
    public static String ACCESS_KEY_ID;
    public static String ACCESS_KEY_SECRET;

    public static String TEMPLATE_GROUPID;

    @Override
    public void afterPropertiesSet() throws Exception {
        BUCKET_NAME = bucketname;
        HOST = host;
        HOST_PATH = hostpath;
        END_POINT = endpoint;
        ACCESS_KEY_ID = keyid;
        ACCESS_KEY_SECRET = keysecret;
        TEMPLATE_GROUPID = templategroupid;
        LOGGER.info("----------完成初始化阿里云视频点播配置信息---------{}");
    }
}
