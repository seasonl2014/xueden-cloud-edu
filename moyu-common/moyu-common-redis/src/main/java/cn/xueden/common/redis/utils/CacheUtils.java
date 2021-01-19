package cn.xueden.common.redis.utils;

import cn.xueden.common.core.web.domain.SysUser;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Caching;

/**功能描述：缓存工具类
 * @Auther:梁志杰
 * @Date:2020/9/25
 * @Description:cn.xueden.common.redis.utils
 * @version:1.0
 */
public class CacheUtils {
    /**
     * 清除当前用户redis缓存
     */
    @Caching(evict = {
            @CacheEvict(value = "user", key = "'user_id_'+T(String).valueOf(#result.id)",condition = "#result.id != null and #result.id != 0"),
            @CacheEvict(value = "user", key = "'user_name_'+#result.loginName", condition = "#result.loginName !=null and #result.loginName != ''"),
            @CacheEvict(value = "user", key = "'user_email_'+#result.email", condition = "#result.email != null and #result.email != ''"),
            @CacheEvict(value = "user", key = "'user_tel_'+#result.tel", condition = "#result.tel != null and #result.tel != ''" ),
    })
    public SysUser clearUserCache(Long userId){
        SysUser user = new SysUser();
        user.setId(userId);
        return user.selectById();
    }
}
