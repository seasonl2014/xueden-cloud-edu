package cn.xueden.common.core.edu.vo;

import cn.xueden.common.core.edu.domain.EduSubject;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Set;

/**功能描述：会员类型视图对象类
 * @Auther:梁志杰
 * @Date:2021/1/31
 * @Description:cn.xueden.common.core.edu.vo
 * @version:1.0
 */
@Data
public class EduVipTypeVO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;

    private String name;

    private Double vipMoney;

    private int memberTotal;

    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd")
    private Date createDate;

    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd")
    private Date updateDate;

    // 会员类型已有权益
    private Set<Long> courseTypeSets;

    // 课程类别列表数据
    private List<EduSubject> courseTypeList;
}
