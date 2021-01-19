package cn.xueden.common.log.aspect;



import cn.xueden.common.core.utils.AddressUtil;
import cn.xueden.common.core.utils.ToolUtil;
import cn.xueden.common.core.utils.XudenStringUtils;
import cn.xueden.common.core.web.domain.SysLog;
import cn.xueden.common.log.annotation.XudenSysLog;
import cn.xueden.common.security.utils.SecurityUtils;
import com.alibaba.fastjson.JSONObject;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Method;
import java.util.Map;


/**功能描述：自定义日志切面
 * @Auther:http://www.xueden.cn
 * @Date:2020/3/6
 * @Description:cn.xueden.aspect
 * @version:1.0
 */
@Aspect
@Order(5)
@Component
public class WebLogAspect {


    private ThreadLocal<Long> startTime = new ThreadLocal<>();

    private SysLog sysLog = null;

    private static final Logger LOGGER = LoggerFactory.getLogger(WebLogAspect.class);

    @Pointcut("@annotation(cn.xueden.common.log.annotation.XudenSysLog)")
    public void webLog(){}

    /**
     * 前置通知，在方法执行之前执行
     */
    @Before("webLog()")
    public void doBefore(JoinPoint joinPoint){
        startTime.set(System.currentTimeMillis());
        //接收到请求，记录请求的内容
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = attributes.getRequest();
        HttpSession session = (HttpSession) attributes.resolveReference(RequestAttributes.REFERENCE_SESSION);
        sysLog = new SysLog();

        sysLog.setClassMethod(joinPoint.getSignature().getDeclaringTypeName()+"."+joinPoint.getSignature().getName());
        sysLog.setHttpMethod(request.getMethod());
        //获取传入目标方法的参数
        Object[] args = joinPoint.getArgs();
        for(int i = 0;i<args.length;i++){
            Object o = args[i];
            if(o instanceof ServletRequest ||(o instanceof ServletResponse)|| o instanceof MultipartFile){
                args[i] = o.toString();
            }
        }
        String str = JSONObject.toJSONString(args);
        sysLog.setParams(str.length()>5000?JSONObject.toJSONString("请求参数数据过长不与显示"):str);

        String ip = ToolUtil.getClientIp(request);
        if("0.0.0.0".equals(ip) || "0:0:0:0:0:0:0:1".equals(ip) || "localhost".equals(ip) || "127.0.0.1".equals(ip)){
            ip = "127.0.0.1";
        }

        sysLog.setRemoteAddr(ip);
        sysLog.setRequestUri(request.getRequestURL().toString());
        if(session != null){
            sysLog.setSessionId(session.getId());
        }
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();
        Method method = signature.getMethod();
        XudenSysLog mylog = method.getAnnotation(XudenSysLog.class);
        if(mylog != null){
            //注解上的描述
            sysLog.setTitle(mylog.value());
        }

        Map<String,String> browserMap = ToolUtil.getOsAndBrowserInfo(request);
        sysLog.setBrowser(browserMap.get("os")+"-"+browserMap.get("browser"));

        //根据Ip地址获取归属地
        if(!"127.0.0.1".equals(ip)){
          String cityAddress = AddressUtil.getCityInfo(ToolUtil.getClientIp(request));
            if(cityAddress!=null&&!cityAddress.equals("内网IP")){
                String addressInfo[] = cityAddress.split("\\|");
                sysLog.setArea(addressInfo[0]+addressInfo[1]);//国家或地区
                sysLog.setProvince(addressInfo[2].replace("省","")
                        .replace("自治区","")
                        .replace("壮族","")
                        .replace("回族","")
                        .replace("维吾尔",""));// 省份
                sysLog.setCity(addressInfo[3]=="0"?"未知":addressInfo[3].replace("市","")); //城市
                sysLog.setIsp(addressInfo[4]);//网络服务提供商
            }


        }

        sysLog.setType(ToolUtil.isAjax(request)?"Ajax请求":"普通请求");
        if(SecurityUtils.getUsername() != null) {
            sysLog.setUsername(SecurityUtils.getUsername());
        }else{
            sysLog.setUsername("未知");
        }

    }

    /**
     * 返回通知, 在方法返回结果之后执行
     * @param ret
     */
    @AfterReturning(returning = "ret", pointcut = "webLog()")
    public void doAfterReturning(Object ret) {

        if(SecurityUtils.getUsername() != null) {
            sysLog.setUsername(SecurityUtils.getUsername());
        }
        String retString = JSONObject.toJSONString(ret);
        sysLog.setResponse(retString.length()>5000?JSONObject.toJSONString("请求参数数据过长不与显示"):retString);
        sysLog.setUseTime(System.currentTimeMillis() - startTime.get());
        sysLog.insert();
    }

    /**
     * 环绕通知, 围绕着方法执行
     * @param proceedingJoinPoint
     * @return
     * @throws Throwable
     */
    @Around("webLog()")
    public Object doAround(ProceedingJoinPoint proceedingJoinPoint) throws Throwable {

        try {
            Object obj = proceedingJoinPoint.proceed();
            return obj;
        } catch (Exception e) {
            e.printStackTrace();
            sysLog.setException(e.getMessage());
            throw e;
        }
    }

}
