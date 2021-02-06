package cn.xueden.common.core.edu.domain;

import cn.xueden.common.core.web.domain.DataEntity;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

/**功能描述：会员视频播放记录实体类
 * @Auther:梁志杰
 * @Date:2021/1/30
 * @Description:cn.xueden.common.core.edu.domain
 * @version:1.0
 */
@Data
@TableName("edu_video_member")
public class EduVideoMember extends DataEntity<EduVideoMember> {

    @ApiModelProperty(value = "会员ID")
    private Long memberId;

    @ApiModelProperty(value = "视频ID")
    private Long videoId;

    @ApiModelProperty(value = "播放次数")
    private Long playCount;

    @ApiModelProperty(value = "上次已经播放时长")
    private Float duration;

    @ApiModelProperty(value = "操作者IP")
    private String ip;

    @ApiModelProperty(value = "所属国家或地区")
    private String country;

    @ApiModelProperty(value = "区域，如华南")
    private String area;

    @ApiModelProperty(value = "所属省份")
    private String province;

    @ApiModelProperty(value = "所属城市")
    private String city;

    @ApiModelProperty(value = "网络服务提供商")
    private String isp;


}
