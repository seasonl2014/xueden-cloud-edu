package cn.xueden.common.core.edu.vo;

import lombok.Data;

import java.util.Date;

/**功能描述：会员实体对象
 * @Auther:梁志杰
 * @Date:2021/1/30
 * @Description:cn.xueden.common.core.edu.vo
 * @version:1.0
 */
@Data
public class EduMemberVO {

    private Long id;

    private Long userid;

    private String username;

    private String openid;

    private String mobile;

    private String password;

    private String nickname;

    private String email;

    private Integer sex;

    private String avatar;

    private String sign;

    private int isTeacher;

    private Long teacherId;

    private Long vipId;

    private String vipType;

    private String token;

    /**
     * 登陆时间
     */
    private Long loginTime;

    /**
     * 过期时间
     */
    private Long expireTime;
}
