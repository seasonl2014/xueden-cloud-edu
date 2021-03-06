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

    @Value("${aliyun.oss.file.bucketcoursename}")
    private String bucketCourseName;

    //读取图片文件夹名称
    @Value("${aliyun.oss.file.host}")
    private String host;

    //读取存放课程资料文件夹名称
    @Value("${aliyun.oss.file.hostcourse}")
    private String hostCourse;

    //文件访问域名
    @Value("${aliyun.oss.file.hostpath}")
    private String hostpath;

    @Value("${aliyun.vod.file.keyid}")
    private String keyid;

    @Value("${aliyun.vod.file.keysecret}")
    private String keysecret;

    @Value("${aliyun.vod.file.templategroupid}")
    private String templategroupid;//转码组ID


    // 短信站点
    @Value("${aliyun.sms.regionid}")
    private String smsRegionid;

    // 短信签名
    @Value("${aliyun.sms.signname}")
    private String signName;

    // 短信模板
    @Value("${aliyun.sms.templatecode}")
    private String templateCode;




    //定义常量，为了能够使用
    public static String END_POINT;
    public static String BUCKET_NAME;
    public static String HOST;
    public static String BUCKET_COURSE_NAME;
    public static String HOST_COURSE;
    public static String HOST_PATH;
    public static String ACCESS_KEY_ID;
    public static String ACCESS_KEY_SECRET;

    public static String TEMPLATE_GROUPID;

    public static String SMS_REGIONID;

    public static String SIGN_NAME;

    public static String TEMPLATE_CODE;



    @Override
    public void afterPropertiesSet() throws Exception {
        BUCKET_NAME = bucketname;
        HOST = host;
        BUCKET_COURSE_NAME = bucketCourseName;
        HOST_COURSE = hostCourse;
        HOST_PATH = hostpath;
        END_POINT = endpoint;
        ACCESS_KEY_ID = keyid;
        ACCESS_KEY_SECRET = keysecret;
        TEMPLATE_GROUPID = templategroupid;
        SMS_REGIONID = smsRegionid;
        SIGN_NAME = signName;
        TEMPLATE_CODE = templateCode;
        LOGGER.info("----------完成初始化阿里云配置信息---------{}");
    }
}
