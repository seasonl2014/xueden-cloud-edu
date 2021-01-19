package cn.xueden.common.core.web.domain;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;

import java.util.Set;

/**功能描述：角色表 sys_role
 * @Auther:梁志杰
 * @Date:2020/9/24
 * @Description:cn.xueden.system.api.domain
 * @version:1.0
 */
@TableName("sys_role")
public class SysRole extends DataEntity<SysRole> {

    private static final long serialVersionUID = 1L;

    /**
     * 角色名称
     */
    private String name;

    @TableField(exist = false)
    private Set<SysMenu> menuSet;

    @TableField(exist = false)
    private Set<SysUser> userSet;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Set<SysMenu> getMenuSet() {
        return menuSet;
    }

    public void setMenuSet(Set<SysMenu> menuSet) {
        this.menuSet = menuSet;
    }

    public Set<SysUser> getUserSet() {
        return userSet;
    }

    public void setUserSet(Set<SysUser> userSet) {
        this.userSet = userSet;
    }
}
