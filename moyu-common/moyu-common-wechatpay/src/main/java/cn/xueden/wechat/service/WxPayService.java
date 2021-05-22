package cn.xueden.wechat.service;

import cn.xueden.wechat.config.WechatConfig;
import cn.xueden.wechat.dto.WxOrderDto;
import cn.xueden.wechat.utils.WxPayUtil;
import com.alibaba.fastjson.JSONArray;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.nio.charset.Charset;

/**功能描述：微信支付自定义接口
 * @Auther:梁志杰
 * @Date:2021/5/21
 * @Description:cn.xueden.wechat.service
 * @version:1.0
 */
@Component
@Slf4j
public class WxPayService {

    private final WechatConfig wechatConfig;

    public WxPayService(WechatConfig wechatConfig) {
        this.wechatConfig = wechatConfig;
    }


    /**
     * Native支付统一下单
     * @throws Exception
     */
    public String CreateNativeOrder(WxOrderDto wxOrderDto) throws Exception{
        HttpPost httpPost = new HttpPost(wechatConfig.getNativeV3Api());
        Object obj = JSONArray.toJSON(wxOrderDto);
        String reqdata = obj.toString();
        StringEntity entity = new StringEntity(reqdata, Charset.forName("UTF-8"));
        entity.setContentType("application/json");
        httpPost.setEntity(entity);
        httpPost.setHeader("Accept", "application/json");
        httpPost.addHeader("Content-type","application/json; charset=utf-8");
        //完成签名并执行请求
        CloseableHttpResponse response = WxPayUtil.getClient(wechatConfig.getMchId(),wechatConfig.getMcHserialNo(),wechatConfig.getPrivateKey(),wechatConfig.getWechatpaykey()).execute(httpPost);

        try {
            int statusCode = response.getStatusLine().getStatusCode();
            if (statusCode == 200) { //处理成功
                System.out.println("success,return body = " + EntityUtils.toString(response.getEntity()));
                return EntityUtils.toString(response.getEntity());
            } else if (statusCode == 204) { //处理成功，无返回Body
                System.out.println("success");
            } else {
                System.out.println("failed,resp code = " + statusCode+ ",return body = " + EntityUtils.toString(response.getEntity()));
                throw new IOException("request failed");
            }
        } finally {
            response.close();
        }
        return null;
    }
}
