package cn.xueden.common.core.edu.domain;

import com.baomidou.mybatisplus.annotations.TableName;
import lombok.Data;

import java.util.Date;

/**功能描述：课程分类实体类
 * @Auther:梁志杰
 * @Date:2021/1/19
 * @Description:cn.xueden.common.core.edu.domain
 * @version:1.0
 */
@Data
@TableName("edu_subject")
public class EduSubject {

    private Long id;

    private String name;

    private Long cateId;// 对应阿里云视频点播分类

    private Integer sort;

    private Date createDate;

    private Date updateDate;

    private Long parentId;
}
