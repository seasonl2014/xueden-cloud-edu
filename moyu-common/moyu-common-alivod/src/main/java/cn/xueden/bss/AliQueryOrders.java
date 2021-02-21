package cn.xueden.bss;

import cn.xueden.alivod.utils.AliyunVODSDKUtils;
import cn.xueden.alivod.utils.ConstantPropertiesUtil;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.bssopenapi.model.v20171214.GetOrderDetailRequest;
import com.aliyuncs.bssopenapi.model.v20171214.GetOrderDetailResponse;
import com.aliyuncs.bssopenapi.model.v20171214.QueryOrdersRequest;
import com.aliyuncs.bssopenapi.model.v20171214.QueryOrdersResponse;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.profile.DefaultProfile;
import com.google.gson.Gson;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**功能描述：查询订单列表以及单个订单详细信息
 * @Auther:梁志杰
 * @Date:2021/1/24
 * @Description:cn.xueden.bss
 * @version:1.0
 */
public class AliQueryOrders {

    /**
     * 查询订单列表
     */
    private QueryOrdersResponse queryOrders(QueryOrdersRequest request, IAcsClient client){
        try {
            // 调用SDK发送请求
            return client.getAcsResponse(request);
        } catch (ClientException e) {
            e.printStackTrace();
            // 发生调用错误，抛出运行时异常
            throw new RuntimeException();
        }
    }

    /**
     * 查询订单详情
     */
    private GetOrderDetailResponse getOrderDetail(GetOrderDetailRequest request, IAcsClient client){
        try {
            // 调用SDK发送请求
            return client.getAcsResponse(request);
        } catch (ClientException e) {
            e.printStackTrace();
            // 发生调用错误，抛出运行时异常
            throw new RuntimeException();
        }
    }

    private static void log_print(String functionName, Object result) {
        Gson gson = new Gson();
        System.out.println("-------------------------------" + functionName + "-------------------------------");
        System.out.println(gson.toJson(result));
    }

    public static void main(String[] args) {

        DateFormat  sdf = new SimpleDateFormat("YYYY-MM-dd'T'HH:mm:ssZ");
        try {
            //初始化客户端、请求对象和相应对象
            IAcsClient  client = AliyunVODSDKUtils.initVodClient("", "");

            AliQueryOrders aliQueryOrders = new AliQueryOrders();
            // 查询订单列表
            QueryOrdersRequest queryOrdersRequest = new QueryOrdersRequest();
            // 订单类型：续费
            //queryOrdersRequest.setOrderType("Renew");
            // 支付状态：已支付
            queryOrdersRequest.setPaymentStatus("Paid");

            //获取前一个月第一天
            Calendar calendar1 = Calendar.getInstance();
            calendar1.add(Calendar.MONTH, -1);
            calendar1.set(Calendar.DAY_OF_MONTH,1);
            String firstDay = sdf.format(calendar1.getTime());
            System.out.println("firstDay:"+firstDay);
            String endDay = sdf.format(new Date());
            queryOrdersRequest.setCreateTimeStart(firstDay);
            queryOrdersRequest.setCreateTimeEnd(endDay);
            QueryOrdersResponse queryOrdersResponse = aliQueryOrders.queryOrders(queryOrdersRequest, client);
            log_print("queryOrders",queryOrdersResponse);



        }catch (Exception e){
            e.printStackTrace();
        }
    }

}
