package cn.xueden.common.core.edu.vo;

import lombok.Data;

/**功能描述：讲师提现视图对象
 * @Auther:梁志杰
 * @Date:2021/5/28
 * @Description:cn.xueden.common.core.edu.vo
 * @version:1.0
 */
@Data
public class EduCashOutDetailsVO {

    private Long teacherId;

    private String bankCard;

    private Integer status;

}
