package cn.xueden.system.controller;





import cn.xueden.common.core.utils.AddressUtil;
import cn.xueden.common.core.utils.LayerData;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.common.core.utils.ToolUtil;
import cn.xueden.common.core.web.domain.AjaxResult;

import cn.xueden.common.core.web.domain.SysLog;
import cn.xueden.common.log.annotation.XudenSysLog;
import cn.xueden.common.security.annotation.PreAuthorize;
import cn.xueden.system.entity.Log;
import cn.xueden.system.service.LogService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import org.apache.commons.lang3.StringUtils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.WebUtils;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**功能描述:日志 前端控制器
 * @Auther:http://www.xueden.cn
 * @Date:2020/3/6
 * @Description:cn.xueden.modules.system.controller
 * @version:1.0
 */
@RestController
@RequestMapping("system/log")
public class LogController  {

    private ThreadLocal<Long> startTime = new ThreadLocal<>();

    @Autowired
    protected LogService logService;

    private static final Logger LOGGER = LoggerFactory.getLogger(LogController.class);

    @PostMapping(value = "list")
    public LayerData<SysLog> list(@RequestParam(value = "page",defaultValue = "1")Integer page,
                               @RequestParam(value = "limit",defaultValue = "10")Integer limit,
                               ServletRequest request){

        Map map = WebUtils.getParametersStartingWith(request,"s_");
        LayerData<SysLog> layerData = new LayerData<>();
        EntityWrapper<SysLog> wrapper = new EntityWrapper<>();

        if(!map.isEmpty()){
            String keys = (String) map.get("type");
            if(StringUtils.isNotBlank(keys)){
                wrapper.eq("type",keys);
            }

            String title = (String) map.get("title");
            if(StringUtils.isNotBlank(title)){
                wrapper.like("title",title);
            }

            String username = (String) map.get("username");
            if(StringUtils.isNotBlank(username)){
                wrapper.eq("username",username);
            }

            String httpMethod = (String)map.get("method");
            if(StringUtils.isNotBlank(httpMethod)){
                wrapper.eq("http_method",httpMethod);
            }
        }

        Page<SysLog> logPage = logService.selectPage(new Page<>(page,limit),wrapper);
        layerData.setCount(logPage.getTotal());
        layerData.setData(logPage.getRecords());
        return layerData;

    }

    /**
     * 批量删除数据（前端layui项目使用）
     * @param ids
     * @return
     */
    @PreAuthorize(hasPermi = "sys:log:delete")
    @PostMapping("delete")
    public RestResponse delete(@RequestParam("ids[]")List<Long> ids){
        if(ids==null||ids.size()==0){
            RestResponse.failure("请选择要删除的记录");
        }
        logService.deleteBatchIds(ids);
        return RestResponse.success();
    }

    /**
     * 删除单条数据（前端vue3项目使用）
     * @param id
     * @return
     */
    @PreAuthorize(hasPermi = "sys:log:delete")
    @DeleteMapping("delete/{id}")
    public RestResponse delete(@PathVariable(value="id") Long id){
        if(id==null){
            RestResponse.failure("请选择要删除的记录");
        }
        logService.deleteById(id);
        return RestResponse.success();
    }

    /**
     * 批量删除数据（前端vue3项目使用）
     * @param list
     * @return
     */
    @PreAuthorize(hasPermi = "sys:log:delete")
    @DeleteMapping("deleteBatch")
    public RestResponse deleteBatch(@RequestBody List<SysLog> list){
        if(list==null||list.size()==0){
            RestResponse.failure("请选择要删除的记录");
        }

        // 定义List用来存放日志ID
        List<Long> ids = new ArrayList<Long>();

        // 获取日志ID列表
        for (SysLog log:list){
            ids.add(log.getId());
        }

        // 根据日志列表ID删除日志数据
        logService.deleteBatchIds(ids);
        return RestResponse.success();
    }

    /**
     * 其他系统保存日志
     * @param sysOperLog
     * @return
     */
    @PostMapping("operlog")
    public AjaxResult saveLog(@RequestBody SysLog sysOperLog){
        // 返回结果集
        AjaxResult ajaxResult = toAjax(logService.insert(sysOperLog)?1:0);
        return ajaxResult;
    }

    /**
     * 保存日志
     * @param username
     * @param status
     * @param message
     * @return
     */
    @PostMapping
    public AjaxResult add(@RequestParam("username") String username, @RequestParam("status") String status,
                          @RequestParam("message") String message,
                          HttpServletRequest request){
        startTime.set(System.currentTimeMillis());
        SysLog sysLog = new SysLog();
        sysLog.setUsername(username); // 操作用户
        sysLog.setTitle(status); // 说明
        sysLog.setClassMethod(LogController.class.getName());//类名
        sysLog.setHttpMethod(request.getMethod());// 请求方式 get\post\....
        sysLog.setType(ToolUtil.isAjax(request)?"Ajax请求":"普通请求");// 请求类型

        String ip = ToolUtil.getClientIp(request);
        if("0.0.0.0".equals(ip) || "0:0:0:0:0:0:0:1".equals(ip) || "localhost".equals(ip) || "127.0.0.1".equals(ip)){
            ip = "127.0.0.1";
        }

        sysLog.setRemoteAddr(ip);// 获取请求Ip地址
        sysLog.setParams("[\""+username+"\",\""+message+"\"]");
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

        sysLog.setRequestUri(request.getRequestURL().toString()); // 请求路径

        if(request.getSession() != null){ //SessionID
            sysLog.setSessionId(request.getSession() .getId());
        }

        // 获取客户端浏览器
        Map<String,String> browserMap = ToolUtil.getOsAndBrowserInfo(request);
        sysLog.setBrowser(browserMap.get("os")+"-"+browserMap.get("browser"));

        // 请求耗时
        sysLog.setUseTime(System.currentTimeMillis() - startTime.get());
        sysLog.setResponse("{\"code\":0,\"success\":true,\"message\":\""+message+"\"}");
        // 返回结果集
        AjaxResult ajaxResult = toAjax(logService.insert(sysLog)?1:0);


        return ajaxResult;
    }

    /**
     * 响应返回结果
     *
     * @param rows 影响行数
     * @return 操作结果
     */
    protected AjaxResult toAjax(int rows)
    {
        return rows > 0 ? AjaxResult.success() : AjaxResult.error();
    }

    @GetMapping("pvs")

    public RestResponse getPV(){
        Map<String,Object> map = logService.selectSelfMonthData();
        return RestResponse.success().setData(map);
    }

    /**
     * 统计用户归属省份
     * @return
     */
    @GetMapping("pvprovince")
    public RestResponse getPVByProvince(){
        Map<String,Object> map = logService.selectSelfMonthDataByProvince();
        return RestResponse.success().setData(map);
    }

}
