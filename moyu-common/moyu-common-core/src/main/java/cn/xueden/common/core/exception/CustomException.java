package cn.xueden.common.core.exception;

/**功能描述：自定义异常
 * @Auther:梁志杰
 * @Date:2020/9/24
 * @Description:cn.xueden.common.core.exception
 * @version:1.0
 */
public class CustomException extends RuntimeException{
    private static final long serialVersionUID = 1L;

    private Integer code;

    private String message;

    public CustomException(String message)
    {
        this.message = message;
    }

    public CustomException(String message, Integer code)
    {
        this.message = message;
        this.code = code;
    }

    public CustomException(String message, Throwable e)
    {
        super(message, e);
        this.message = message;
    }

    @Override
    public String getMessage()
    {
        return message;
    }

    public Integer getCode()
    {
        return code;
    }
}
