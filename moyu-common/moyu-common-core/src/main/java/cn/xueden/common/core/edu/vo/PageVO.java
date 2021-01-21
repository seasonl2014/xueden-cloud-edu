package cn.xueden.common.core.edu.vo;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**功能描述：页面视图对象
 * @Auther:梁志杰
 * @Date:2021/1/19
 * @Description:cn.xueden.common.core.edu.vo
 * @version:1.0
 */
@Data
public class PageVO<T> {
    private long total;

    private List<T> rows = new ArrayList<>();

    public PageVO(long total, List<T> rows) {
        this.total = total;
        this.rows = rows;
    }
}
