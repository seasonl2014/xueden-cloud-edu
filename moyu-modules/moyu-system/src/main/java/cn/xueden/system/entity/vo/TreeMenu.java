package cn.xueden.system.entity.vo;

import com.google.common.collect.Lists;

import java.util.List;

/**功能描述:树形菜单
 * @Auther:http://www.xueden.cn
 * @Date:2020/2/18
 * @Description:cn.xueden.modules.system.entity.vo
 * @version:1.0
 */
public class TreeMenu {

    private Long id;
    private  Long pid;
    private String title;
    private String icon;
    private String href;
    private Boolean spread;
    List<TreeMenu> children = Lists.newArrayList();

    public TreeMenu(Boolean spread) {
        this.spread = false;
    }

    public TreeMenu(Long id, Long pid, String title,String icon, String href) {
        this.id = id;
        this.pid = pid;
        this.title = title;
        this.icon = icon;
        this.href = href;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getPid() {
        return pid;
    }

    public void setPid(Long pid) {
        this.pid = pid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href;
    }

    public Boolean getSpread() {
        return spread;
    }

    public void setSpread(Boolean spread) {
        this.spread = spread;
    }

    public List<TreeMenu> getChildren() {
        return children;
    }

    public void setChildren(List<TreeMenu> children) {
        this.children = children;
    }
}
