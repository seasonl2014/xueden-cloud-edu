package cn.xueden.common.core.edu.vo;

import cn.xueden.common.core.edu.domain.EduCourse;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;

/**
 * @Auther:梁志杰
 * @Date:2021/2/18
 * @Description:cn.xueden.common.core.edu.vo
 * @version:1.0
 */
@Data
public class EduMemberBuyCourseVO {

    private String orderNo;

    private Long courseId;

    private Long memberId;

    private BigDecimal price;

    private Long buyType;

    private Integer isPayment;

    private String payChannel;

    private String country;

    private String area;

    private String province;

    private String city;

    private String isp;

    // 课程对象信息
    private EduCourse eduCourse;
}
