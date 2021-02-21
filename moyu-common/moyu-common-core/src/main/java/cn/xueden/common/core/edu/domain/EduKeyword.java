package cn.xueden.common.core.edu.domain;

import cn.xueden.common.core.web.domain.DataEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**功能描述：关键词实体类
 * @Auther:梁志杰
 * @Date:2021/2/17
 * @Description:cn.xueden.common.core.edu.domain
 * @version:1.0
 */
@Data
@TableName("edu_keyword")
public class EduKeyword extends DataEntity<EduKeyword> {

    @ApiModelProperty(value = "关键词")
    private String name;

    @ApiModelProperty(value = "搜索次数")
    private Integer num;
}
