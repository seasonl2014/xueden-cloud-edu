package cn.xueden.common.core.domain;

import cn.xueden.common.core.constant.Constants;

import java.io.Serializable;

/**功能描述：响应信息主体
 * @Auther:梁志杰
 * @Date:2020/9/24
 * @Description:cn.xueden.common.core.domain
 * @version:1.0
 */
public class R<T> implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 成功 */
    public static final int SUCCESS = Constants.SUCCESS;

    /** 失败 */
    public static final int FAIL = Constants.FAIL;

    private int code;

    private String message;

    private T data;

    public static <T> R<T> ok()
    {
        return restResult(null, SUCCESS, null);
    }

    public static <T> R<T> ok(T data)
    {
        return restResult(data, SUCCESS, null);
    }

    public static <T> R<T> ok(T data, String msg)
    {
        return restResult(data, SUCCESS, msg);
    }

    public static <T> R<T> fail()
    {
        return restResult(null, FAIL, null);
    }

    public static <T> R<T> fail(String msg)
    {
        return restResult(null, FAIL, msg);
    }

    public static <T> R<T> fail(T data)
    {
        return restResult(data, FAIL, null);
    }

    public static <T> R<T> fail(T data, String msg)
    {
        return restResult(data, FAIL, msg);
    }

    public static <T> R<T> fail(int code, String msg)
    {
        return restResult(null, code, msg);
    }

    private static <T> R<T> restResult(T data, int code, String msg)
    {
        R<T> apiResult = new R<>();
        apiResult.setCode(code);
        apiResult.setData(data);
        apiResult.setMessage(msg);
        return apiResult;
    }

    public int getCode()
    {
        return code;
    }

    public void setCode(int code)
    {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public T getData()
    {
        return data;
    }

    public void setData(T data)
    {
        this.data = data;
    }

}
