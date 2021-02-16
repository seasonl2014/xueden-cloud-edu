package cn.xueden.search.domain;

import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

import java.math.BigDecimal;

/**功能描述：Elasticsearch 对应实体类
 * @Auther:梁志杰
 * @Date:2021/2/15
 * @Description:cn.xueden.search.domain
 * @version:1.0
 */
@Document(indexName = "course", type = "itemList", shards = 1, replicas = 0)
public class CourseESItem {

    /**
     * 课程 ID
     */
    @Id
    private Long id;

    /**
     * 课程名称
     */
    @Field(type = FieldType.Text, analyzer = "ik_max_word")
    private String title;

    /**
     * 课程副标题
     */
    @Field(type = FieldType.Text, analyzer = "ik_max_word")
    private String shortTitle;

    /**
     * 课程售价
     */
    @Field(type = FieldType.Double)
    private BigDecimal price;

    @Field(type = FieldType.Keyword)
    private String cover;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getShortTitle() {
        return shortTitle;
    }

    public void setShortTitle(String shortTitle) {
        this.shortTitle = shortTitle;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getCover() {
        return cover;
    }

    public void setCover(String cover) {
        this.cover = cover;
    }
}
