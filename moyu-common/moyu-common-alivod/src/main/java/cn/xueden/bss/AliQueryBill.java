package cn.xueden.bss;

import cn.xueden.alivod.utils.AliyunVODSDKUtils;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.bssopenapi.model.v20171214.*;
import com.aliyuncs.exceptions.ClientException;
import com.google.gson.Gson;

/**功能描述：查询账单总览、月账单以及账单明细等
 * @Auther:梁志杰
 * @Date:2021/1/24
 * @Description:cn.xueden.bss
 * @version:1.0
 */
public class AliQueryBill {

    /**
     * 账单总览查询
     */
    private QueryBillOverviewResponse queryBillOverview(QueryBillOverviewRequest request, IAcsClient client){
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
     * 账单查询
     */
    private QueryBillResponse queryBill(QueryBillRequest request, IAcsClient client){
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
     * 实例账单查询
     */
    private QueryInstanceBillResponse queryInstanceBill(QueryInstanceBillRequest request, IAcsClient client){
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
     * 月费用分摊查询
     */
    private QueryInstanceGaapCostResponse queryInstanceGaapCost(QueryInstanceGaapCostRequest request,IAcsClient client){
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

        try {
            //初始化客户端、请求对象和相应对象
            IAcsClient  client = AliyunVODSDKUtils.initVodClient("", "");


            AliQueryBill queryBillDemo = new AliQueryBill();
            // 账期，YYYY-MM。
            String billingCycle = "2021-01";

            // 账单总览查询
            QueryBillOverviewRequest queryBillOverviewRequest = new QueryBillOverviewRequest();
            queryBillOverviewRequest.setBillingCycle(billingCycle);
            QueryBillOverviewResponse queryBillOverviewResponse = queryBillDemo.queryBillOverview(queryBillOverviewRequest, client);
            log_print("queryBillOverview",queryBillOverviewResponse);
        }catch (Exception e){
            e.printStackTrace();
        }

    }


}
