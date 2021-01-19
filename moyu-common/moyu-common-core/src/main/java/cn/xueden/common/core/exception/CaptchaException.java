package cn.xueden.common.core.exception;

/**功能描述：验证码错误异常类
 * @Auther:梁志杰
 * @Date:2020/9/25
 * @Description:cn.xueden.common.core.exception
 * @version:1.0
 */
public class CaptchaException extends RuntimeException{

    private static final long serialVersionUID = 1L;

    public CaptchaException(String msg)
    {
        super(msg);
    }
}
