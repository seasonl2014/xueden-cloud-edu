package cn.xueden.common.core.web.domain;


import com.baomidou.mybatisplus.annotation.FieldStrategy;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.google.common.collect.Sets;

import java.util.Set;

/**功能描述：系统用户对象实体类 sys_user
 * @Auther:梁志杰
 * @Date:2020/9/24
 * @Description:cn.xueden.system.api.domain
 * @version:1.0
 */
@TableName("sys_user")
public class SysUser extends DataEntity<SysUser> {
    private static final long serialVersionUID = 1L;

    /**
     * 登录名
     */
    @TableField("login_name")
    private String loginName;

    /**
     * 昵称
     */
    @TableField(value = "nick_name",updateStrategy= FieldStrategy.IGNORED)
    private String nickName;

    /**
     * 密码
     */
    private String password;


    /**
     * 手机号码
     */
    @TableField(updateStrategy= FieldStrategy.IGNORED)
    private String tel;

    /**
     * 邮箱地址
     */
    @TableField(updateStrategy= FieldStrategy.IGNORED)
    private String email;

    /**
     * 账户是否锁定
     */
    private Boolean locked;

    @TableField(updateStrategy= FieldStrategy.IGNORED)
    private String icon;

    @TableField(exist=false)
    private Set<SysRole> roleLists = Sets.newHashSet();

    @TableField(exist=false)
    private Set<String> roleSets = Sets.newHashSet();

    @TableField(exist=false)
    private Set<SysMenu> menus = Sets.newHashSet();

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Boolean getLocked() {
        return locked;
    }

    public void setLocked(Boolean locked) {
        this.locked = locked;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public Set<SysRole> getRoleLists() {
        return roleLists;
    }

    public void setRoleLists(Set<SysRole> roleLists) {
        this.roleLists = roleLists;
    }

    public Set<SysMenu> getMenus() {
        return menus;
    }

    public void setMenus(Set<SysMenu> menus) {
        this.menus = menus;
    }

    public Set<String> getRoleSets() {
        return roleSets;
    }

    public void setRoleSets(Set<String> roleSets) {
        this.roleSets = roleSets;
    }
}
