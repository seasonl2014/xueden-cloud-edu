package cn.xueden.common.core.edu.vo;

import lombok.Data;

/**
 * @Auther:梁志杰
 * @Date:2021/2/17
 * @Description:cn.xueden.common.core.edu.vo
 * @version:1.0
 */
@Data
public class RegisterMemberVO {

    // 手机号
    private String mobile;

    // 注册密码
    private String password;

    // 确认密码
    private String rePassword;

    // 验证码
    private String code;

}
