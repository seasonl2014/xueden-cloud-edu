package cn.xueden.common.core.enums;

/**功能描述：用户状态
 * @Auther:梁志杰
 * @Date:2020/9/25
 * @Description:cn.xueden.common.core.enums
 * @version:1.0
 */
public enum UserStatus {
    OK("0", "正常"), DISABLE("1", "停用"), DELETED("2", "删除");

    private final String code;
    private final String info;

    UserStatus(String code, String info)
    {
        this.code = code;
        this.info = info;
    }

    public String getCode()
    {
        return code;
    }

    public String getInfo()
    {
        return info;
    }
}
