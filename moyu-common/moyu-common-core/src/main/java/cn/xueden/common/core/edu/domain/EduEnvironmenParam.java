package cn.xueden.common.core.edu.domain;

import cn.xueden.common.core.web.domain.DataEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**功能描述：开发环境实体类
 * @Auther:梁志杰
 * @Date:2021/2/11
 * @Description:cn.xueden.common.core.edu.domain
 * @version:1.0
 */
@Data
@TableName("edu_environmen_param")
public class EduEnvironmenParam extends DataEntity<EduEnvironmenParam> {

    @ApiModelProperty(value = "课程ID")
    private Long courseId;

    @ApiModelProperty(value = "参数名称")
    private String name;

    @ApiModelProperty(value = "参数值")
    private String value;

}
