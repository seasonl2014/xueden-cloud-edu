package cn.xueden.common.core.edu.vo;

import lombok.Data;

/**功能描述：会员权益视图对象
 * @Auther:梁志杰
 * @Date:2021/1/31
 * @Description:cn.xueden.common.core.edu.vo
 * @version:1.0
 */
@Data
public class EduVipTypeSubjectVO {
    private Long id;

    private Long vipId; // 会员类型ID

    private String vipName;// 会员类型名称

    private Long subjectId; // 课程栏目ID

    private String subjectName;// 课程栏目名称
}
