package cn.xueden.common.core.edu.domain;

import cn.xueden.common.core.web.domain.DataEntity;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

/**功能描述：会员实体类
 * @Auther:梁志杰
 * @Date:2021/1/30
 * @Description:cn.xueden.common.core.edu.domain
 * @version:1.0
 */
@Data
@TableName("edu_member")
public class EduMember extends DataEntity<EduMember> {

    @ApiModelProperty(value = "微信openid")
    private String openid;

    @ApiModelProperty(value = "手机号")
    private String mobile;

    @ApiModelProperty(value = "登录密码")
    private String password;

    @ApiModelProperty(value = "会员昵称")
    private String nickname;

    @ApiModelProperty(value = "电子邮箱")
    private String email;

    @ApiModelProperty(value = "性别")
    private Integer sex;

    @ApiModelProperty(value = "会员头像图片路径")
    private String avatar;

    @ApiModelProperty(value = "用户签名")
    private String sign;


    @ApiModelProperty(value = "是否讲师，0否，1是")
    private int isTeacher;

    @ApiModelProperty(value = "讲师ID")
    private Long teacherId;

    @ApiModelProperty(value = "会员类别ID")
    private Long vipId;
}
