package cn.xueden.common.core.constant;

/**功能描述：通用常量信息
 * @Auther:梁志杰
 * @Date:2020/9/24
 * @Description:cn.xueden.common.core.constant
 * @version:1.0
 */
public class Constants {

    /**
     * 登录
     */
    public static final String LOGIN = "Login";

    /**
     * 注销
     */
    public static final String LOGOUT = "Logout";

    /**
     * 生成Hash值的迭代次数
     */
    public static final int HASH_INTERATIONS = 1024;

    /**
     * 生成盐的长度
     */
    public static final int SALT_SIZE = 8;

    /**
     *系统用户默认密码
     */
    public static final String DEFAULT_PASSWORD = "123456";

    /**
     * 登录成功
     */
    public static final String LOGIN_SUCCESS = "Success";

    /**
     * 登录失败
     */
    public static final String LOGIN_FAIL = "Error";

    /**
     * 验证码 redis key
     */
    public static final String CAPTCHA_CODE_KEY = "captcha_codes:";

    /**
     * 成功标记
     */
    public static final Integer SUCCESS = 200;

    /**
     * 失败标记
     */
    public static final Integer FAIL = 500;

    /**
     * 验证码有效期（分钟）
     */
    public static final long CAPTCHA_EXPIRATION = 2;

    /**
     * 令牌有效期（分钟）
     */
    public final static long TOKEN_EXPIRE = 720;
}
