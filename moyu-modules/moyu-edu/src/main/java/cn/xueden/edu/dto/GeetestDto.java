package cn.xueden.edu.dto;

import lombok.Data;

/**Geetest返回参数，用于二次验证
 * @Auther:梁志杰
 * @Date:2021/10/30
 * @Description:cn.xueden.edu.dto
 * @version:1.0
 */
@Data
public class GeetestDto {

    private String geetest_challenge;

    private String geetest_validate;

    private String geetest_seccode;
}
