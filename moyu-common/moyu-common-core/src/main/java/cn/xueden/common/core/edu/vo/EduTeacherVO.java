package cn.xueden.common.core.edu.vo;

import lombok.Data;

import java.util.Date;

/**功能描述：讲师视图对象类
 * @Auther:梁志杰
 * @Date:2021/1/22
 * @Description:cn.xueden.common.core.edu.vo
 * @version:1.0
 */
@Data
public class EduTeacherVO {

    // 讲师ID
    private Long id;

    // 讲师姓名
    private String name;

    // 讲师资历,一句话说明讲师
    private String intro;

    // 讲师简介
    private String remarks;

    // 讲师头像
    private String avatar;

    // 头衔 1高级讲师 2首席讲师
    private Integer level;

    // 排序
    private Integer sort;

    // 创建时间
    private Date createDate;

    // 修改时间
    private Date updateDate;
}
