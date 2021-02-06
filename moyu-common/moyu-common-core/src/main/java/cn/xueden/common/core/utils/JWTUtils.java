package cn.xueden.common.core.utils;



import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTDecodeException;
import com.auth0.jwt.interfaces.DecodedJWT;

import java.io.UnsupportedEncodingException;
import java.util.Date;

/**功能描述：JWT工具类
 * @Auther:梁志杰
 * @Date:2021/1/30
 * @Description:cn.xueden.common.core.utils
 * @version:1.0
 */
public class JWTUtils {
    /**
     * 过期时间，单位毫秒
     */
    private static final long EXPIRE_TIME = 7*24*3600*1000;

    /**
     * 校验token是否正确
     * @param token 密钥
     * @param secret 用户的密码
     * @return 是否正确
     */
    public static boolean verify(String token, String mobile, String secret) {
        try {
            Algorithm algorithm = Algorithm.HMAC256(secret);
            JWTVerifier verifier = JWT.require(algorithm)
                    .withClaim("mobile", mobile)
                    .build();
            DecodedJWT jwt = verifier.verify(token);
            return true;
        } catch (Exception exception) {
            return false;
        }
    }

    /**
     * 生成签名
     * @param mobile 手机号
     * @param secret 用户的密码
     * @return 加密的token
     */
    public static String sign(String mobile, String secret) {
        try {
            Date date = new Date(System.currentTimeMillis()+EXPIRE_TIME);
            Algorithm algorithm = Algorithm.HMAC256(secret);
            // 附带username信息
            return JWT.create()
                    .withClaim("mobile", mobile)
                    .withExpiresAt(date)
                    .sign(algorithm);
        } catch (UnsupportedEncodingException e) {
            return null;
        }
    }

    /**
     * 获得token中的信息无需secret解密也能获得
     * @return token中包含的手机号
     */
    public static String getMobile(String token) {
        try {
            DecodedJWT jwt = JWT.decode(token);
            return jwt.getClaim("mobile").asString();
        } catch (JWTDecodeException e) {
            return null;
        }
    }

    /**
     * 获得token中的信息无需secret解密也能获得
     * @return token中包含的用户名
     */
 /*   public static JWTMember getJWTMember(String token) {
        try {
            JWTMember jwtMember = new JWTMember();
            DecodedJWT jwt = JWT.decode(token);
            jwtMember.setMobile(jwt.getClaim("mobile").asString());
            jwtMember.setNickname(jwt.getClaim("nickname").asString());
            return jwtMember;
        } catch (JWTDecodeException e) {
            return null;
        }
    }*/

    /**
     * 判断过期
     * @param token
     * @return
     */
    public static boolean isExpire(String token){
        DecodedJWT jwt = JWT.decode(token);
        return System.currentTimeMillis()>jwt.getExpiresAt().getTime();
    }

}

