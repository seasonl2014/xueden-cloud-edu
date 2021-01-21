package cn.xueden.common.core.edu.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Comparator;
import java.util.Date;
import java.util.List;

/**功能描述：课程分类树形视图对象
 * @Auther:梁志杰
 * @Date:2021/1/19
 * @Description:cn.xueden.common.core.edu.vo
 * @version:1.0
 */
@Data
public class EduSubjectTreeNodeVO {
    private Long id;

    private String name;

    private Long cateId;

    private Integer sort;

    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createDate;

    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateDate;

    private Long parentId;

    private int lev;

    private List<EduSubjectTreeNodeVO> children;

    /*
     * 排序,根据order排序
     */
    public static Comparator<EduSubjectTreeNodeVO> order(){
        Comparator<EduSubjectTreeNodeVO> comparator = (o1, o2) -> {
            if(o1.getSort() != o2.getSort()){
                return (int) (o1.getSort() - o2.getSort());
            }
            return 0;
        };
        return comparator;
    }
}
