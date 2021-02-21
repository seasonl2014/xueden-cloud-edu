package cn.xueden.common.core.edu.domain;

import cn.xueden.common.core.web.domain.DataEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**功能描述：首页幻灯片实体类
 * @Auther:梁志杰
 * @Date:2021/2/19
 * @Description:cn.xueden.common.core.edu.domain
 * @version:1.0
 */
@Data
@TableName("edu_banner")
public class EduBanner extends DataEntity<EduBanner> {

    @ApiModelProperty(value = "链接地址")
    private String url;

    @ApiModelProperty(value = "标题")
    private String title;

    @ApiModelProperty(value = "封面")
    private String img;

    @ApiModelProperty(value = "等级排序")
    private Integer level;
}
