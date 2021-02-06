package cn.xueden.auth.form;

import lombok.Data;

/**
 * @Auther:梁志杰
 * @Date:2021/1/30
 * @Description:cn.xueden.auth.form
 * @version:1.0
 */
@Data
public class LoginMemberBody {

    /**
     * 手机号
     */
    private String mobile;

    /**
     * 用户密码
     */
    private String password;

    /**
     * 验证码
     */
    private String code;

    /**
     * 唯一标识
     */
    private String uuid = "";
}
