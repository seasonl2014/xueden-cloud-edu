package cn.xueden.common.core.edu.domain;

import cn.xueden.common.core.web.domain.DataEntity;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

/**功能描述：会员类型实体类
 * @Auther:梁志杰
 * @Date:2021/1/31
 * @Description:cn.xueden.common.core.edu.domain
 * @version:1.0
 */
@Data
@TableName("edu_vip_type")
public class EduVipType extends DataEntity<EduVipType> {

    @ApiModelProperty(value = "类型名称")
    private String name;

    @ApiModelProperty(value = "会员价格")
    private Double vipMoney;

}