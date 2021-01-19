package cn.xueden.system.entity.vo;

import com.google.common.collect.Lists;

import java.io.Serializable;
import java.util.List;

/**功能描述:菜单辅助类
 * @Auther:http://www.xueden.cn
 * @Date:2020/2/18
 * @Description:cn.xueden.modules.system.entity.vo
 * @version:1.0
 */
public class ShowMenu implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;

    private Long pid;

    private String title;

    private String icon;

    private String svgIcon;

    private String path;

    private String redirect;

    private String componentName;

    private String component;

    private String href;

    private Boolean spread = false;

    private List<ShowMenu> children = Lists.newArrayList();

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

    public List<ShowMenu> getChildren() {
        return children;
    }

    public void setChildren(List<ShowMenu> children) {
        this.children = children;
    }

    public String getSvgIcon() {
        return svgIcon;
    }

    public void setSvgIcon(String svgIcon) {
        this.svgIcon = svgIcon;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getComponentName() {
        return componentName;
    }

    public void setComponentName(String componentName) {
        this.componentName = componentName;
    }

    public String getComponent() {
        return component;
    }

    public void setComponent(String component) {
        this.component = component;
    }

    public String getRedirect() {
        return redirect;
    }

    public void setRedirect(String redirect) {
        this.redirect = redirect;
    }
}
