package cn.xueden.common.core.constant;

/**功能描述：缓存的key 常量
 * @Auther:梁志杰
 * @Date:2020/9/24
 * @Description:cn.xueden.common.core.constant
 * @version:1.0
 */
public class CacheConstants {

    /**
     * 令牌自定义标识
     */
    public static final String HEADER = "Authorization";

    /**
     * 令牌前缀
     */
    public static final String TOKEN_PREFIX = "Bearer ";

    /**
     * 权限缓存前缀
     */
    public final static String LOGIN_TOKEN_KEY = "login_tokens:";

    /**
     * 用户ID字段
     */
    public static final String DETAILS_USER_ID = "user_id";

    /**
     * 用户名字段
     */
    public static final String DETAILS_USERNAME = "username";
}
