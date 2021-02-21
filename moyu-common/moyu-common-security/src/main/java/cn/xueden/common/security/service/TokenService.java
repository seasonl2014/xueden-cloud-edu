package cn.xueden.common.security.service;

import cn.xueden.common.core.constant.CacheConstants;
import cn.xueden.common.core.constant.Constants;
import cn.xueden.common.core.edu.vo.EduMemberVO;
import cn.xueden.common.core.utils.IdUtils;
import cn.xueden.common.core.utils.ServletUtils;
import cn.xueden.common.redis.service.RedisService;
import cn.xueden.system.api.model.LoginUser;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**功能描述：token验证处理
 * @Auther:梁志杰
 * @Date:2020/9/24
 * @Description:cn.xueden.common.security.service
 * @version:1.0
 */
@Component("tokenService")
public class TokenService {

    @Autowired
    private RedisService redisService;

    private final static long EXPIRE_TIME = Constants.TOKEN_EXPIRE * 60;

    private final static String ACCESS_TOKEN = CacheConstants.LOGIN_TOKEN_KEY;

    protected static final long MILLIS_SECOND = 1000;

    /**
     * 创建会员令牌（前台使用）
     */
    public Map<String, Object> createMemberToken(EduMemberVO memberVO){
        // 生成token
        String token = IdUtils.fastUUID();
        memberVO.setToken(token);
        refreshMemberToken(memberVO);

        // 保存或更新用户token
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("access_token", token);
        // 会员ID
        map.put("userid", memberVO.getId());
        // 会员昵称
        map.put("username", memberVO.getNickname()==null?memberVO.getNickname():memberVO.getMobile());
        // 会员手机号
        map.put("mobile", memberVO.getMobile());
        // 会员头像
        map.put("avatar", memberVO.getAvatar());
        // 会员VIP的ID
        map.put("vipId", memberVO.getVipId());
        // 会员VIP类型
        map.put("vipType", memberVO.getVipType());
        map.put("expires_in", EXPIRE_TIME);
        memberVO.setUserid(memberVO.getId());
        memberVO.setUsername(memberVO.getNickname()==null?memberVO.getMobile():memberVO.getNickname());
        redisService.setCacheObject(ACCESS_TOKEN + token, memberVO, EXPIRE_TIME, TimeUnit.SECONDS);
        return map;
    }


    /**
     * 刷新会员令牌有效期（前台使用）
     *
     * @param memberVO 登录信息
     */
    public Long refreshMemberToken(EduMemberVO memberVO){
        memberVO.setLoginTime(System.currentTimeMillis());
        memberVO.setExpireTime(memberVO.getLoginTime() + EXPIRE_TIME * MILLIS_SECOND);
        // 根据uuid将EduMemberVO缓存
        String memberKey = getTokenKey(memberVO.getToken());
        redisService.setCacheObject(memberKey, memberVO, EXPIRE_TIME, TimeUnit.SECONDS);
        return EXPIRE_TIME;
    }

    /**
     * 获取会员身份信息
     *
     * @return 会员信息
     */
    public EduMemberVO getLoginMember()
    {
        return getLoginMember(ServletUtils.getRequest());
    }


    /**
     * 获取会员身份信息
     *
     * @return 会员信息
     */
    public EduMemberVO getLoginMember(HttpServletRequest request)
    {
        // 获取请求携带的令牌
        String token = getToken(request);
        if (StringUtils.isNotEmpty(token))
        {
            String memberKey = getTokenKey(token);
            EduMemberVO memberVO = redisService.getCacheObject(memberKey);
            return memberVO;
        }
        return null;
    }


    /**
     * 创建令牌
     */
    public Map<String, Object> createToken(LoginUser loginUser){
        // 生成token
        String token = IdUtils.fastUUID();
        loginUser.setToken(token);
        loginUser.setUserid(loginUser.getSysUser().getId());
        loginUser.setUsername(loginUser.getSysUser().getLoginName());
        refreshToken(loginUser);

        // 保存或更新用户token
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("access_token", token);
        map.put("nickName", loginUser.getSysUser().getNickName()==null?loginUser.getUsername():loginUser.getSysUser().getNickName());
        map.put("user_permissions", loginUser.getPermissions());
        map.put("expires_in", EXPIRE_TIME);
        redisService.setCacheObject(ACCESS_TOKEN + token, loginUser, EXPIRE_TIME, TimeUnit.SECONDS);
        return map;
    }

    /**
     * 获取用户身份信息
     *
     * @return 用户信息
     */
    public LoginUser getLoginUser()
    {
        return getLoginUser(ServletUtils.getRequest());
    }

    /**
     * 获取用户身份信息
     *
     * @return 用户信息
     */
    public LoginUser getLoginUser(HttpServletRequest request)
    {
        // 获取请求携带的令牌
        String token = getToken(request);
        if (StringUtils.isNotEmpty(token))
        {
            String userKey = getTokenKey(token);
            LoginUser user = redisService.getCacheObject(userKey);
            return user;
        }
        return null;
    }

    /**
     * 删除用户缓存
     * @param token
     */
    public void delLoginUser(String token)
    {
        if (StringUtils.isNotEmpty(token))
        {
            String userKey = getTokenKey(token);
            redisService.deleteObject(userKey);
        }
    }


    /**
     * 刷新令牌有效期
     *
     * @param loginUser 登录信息
     */
    public Long refreshToken(LoginUser loginUser){
        loginUser.setLoginTime(System.currentTimeMillis());
        loginUser.setExpireTime(loginUser.getLoginTime() + EXPIRE_TIME * MILLIS_SECOND);
        // 根据uuid将loginUser缓存
        String userKey = getTokenKey(loginUser.getToken());
        redisService.setCacheObject(userKey, loginUser, EXPIRE_TIME, TimeUnit.SECONDS);
        return EXPIRE_TIME;
    }

    private String getTokenKey(String token)
    {
        return ACCESS_TOKEN + token;
    }

    /**
     * 获取请求token
     */
    private String getToken(HttpServletRequest request)
    {
        String token = request.getHeader(CacheConstants.HEADER);
        if (StringUtils.isNotEmpty(token) && token.startsWith(CacheConstants.TOKEN_PREFIX))
        {
            token = token.replace(CacheConstants.TOKEN_PREFIX, "");
        }
        return token;
    }

}
