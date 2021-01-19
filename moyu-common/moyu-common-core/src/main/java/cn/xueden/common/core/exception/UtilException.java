package cn.xueden.common.core.exception;

/**功能描述：工具类异常
 * @Auther:梁志杰
 * @Date:2020/9/24
 * @Description:cn.xueden.common.core.exception
 * @version:1.0
 */
public class UtilException extends RuntimeException{
    private static final long serialVersionUID = 8247610319171014183L;

    public UtilException(Throwable e)
    {
        super(e.getMessage(), e);
    }

    public UtilException(String message)
    {
        super(message);
    }

    public UtilException(String message, Throwable throwable)
    {
        super(message, throwable);
    }

    /**
     * 将CheckedException转换为UncheckedException.
     */
    public static RuntimeException unchecked(Exception e) {
        if (e instanceof RuntimeException) {
            return (RuntimeException) e;
        } else {
            return new RuntimeException(e);
        }
    }
}
