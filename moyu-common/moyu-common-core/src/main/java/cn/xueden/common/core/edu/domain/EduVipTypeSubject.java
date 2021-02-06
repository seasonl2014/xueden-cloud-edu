package cn.xueden.common.core.edu.domain;

import cn.xueden.common.core.web.domain.DataEntity;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

/**功能描述：会员类别和栏目关系实体类
 * @Auther:梁志杰
 * @Date:2021/1/31
 * @Description:cn.xueden.common.core.edu.domain
 * @version:1.0
 */
@Data
@TableName("edu_vip_type_subject")
public class EduVipTypeSubject extends DataEntity<EduVipTypeSubject> {

    @ApiModelProperty(value = "会员类别ID")
    private Long vipId;

    @ApiModelProperty(value = "课程类别ID")
    private Long subjectId;

}
