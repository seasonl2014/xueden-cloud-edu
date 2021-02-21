package cn.xueden.common.core.utils;

import javax.servlet.http.HttpServletRequest;

/**功能描述：Ip地址工具类
 * @Auther:梁志杰
 * @Date:2021/1/30
 * @Description:cn.xueden.common.core.utils
 * @version:1.0
 */
public class IPUtil {
    private static final String UNKNOWN = "unknown";

    protected IPUtil(){

    }

    /**
     * 获取 IP地址
     * 使用 Nginx等反向代理软件， 则不能通过 request.getRemoteAddr()获取 IP地址
     * 如果使用了多级反向代理的话，X-Forwarded-For的值并不止一个，而是一串IP地址，
     * X-Forwarded-For中第一个非 unknown的有效IP字符串，则为真实IP地址
     */
    public static String getIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        System.out.println("x-forwarded-for，获取用户真实ip地址：-------"+ip);
        if (ip == null || ip.length() == 0 || UNKNOWN.equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
            System.out.println("Proxy-Client-IP，获取用户真实ip地址：-------"+ip);
        }
        if (ip == null || ip.length() == 0 || UNKNOWN.equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
            System.out.println("WL-Proxy-Client-IP，获取用户真实ip地址：-------"+ip);
        }
        if (ip == null || ip.length() == 0 || UNKNOWN.equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
            System.out.println("getRemoteAddr，获取用户真实ip地址：-------"+ip);
        }
        System.out.println("工具类最后，获取用户真实ip地址：-------"+ip);
        String[] ips = ip.split(",");
        System.out.println("转换后的，获取用户真实ip地址：-------"+ips[0]);
        ip = ips[0];
        return "0:0:0:0:0:0:0:1".equals(ip) ? "127.0.0.1" : ip;
    }
}
