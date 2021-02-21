package cn.xueden.common.core.edu.vo;

import lombok.Data;

/**功能描述：密码实体对象
 * @Auther:梁志杰
 * @Date:2021/2/19
 * @Description:cn.xueden.common.core.edu.vo
 * @version:1.0
 */
@Data
public class PassWordVO {

    // 手机号
    private String mobile;

    // 验证码
    private String code;

    // 原密码
    private String passWord;

    // 新密码
    private String newPassWord;

    // 确认新密码
    private String resNewPassWord;
}
