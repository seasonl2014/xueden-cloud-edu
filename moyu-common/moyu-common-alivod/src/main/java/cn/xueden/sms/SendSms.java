package cn.xueden.sms;

import cn.xueden.alivod.utils.ConstantPropertiesUtil;
import com.aliyuncs.CommonRequest;
import com.aliyuncs.CommonResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.exceptions.ServerException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;

/**功能描述：阿里云短信发送
 * @Auther:梁志杰
 * @Date:2021/1/28
 * @Description:cn.xueden.sms
 * @version:1.0
 */
public class SendSms {

    /**
     * 给手机发送验证码
     * @param code
     * @param phone
     * @return
     */
    public static String SendCodeByPhone(String code,String phone) {
        DefaultProfile profile = DefaultProfile.getProfile(ConstantPropertiesUtil.SMS_REGIONID, ConstantPropertiesUtil.ACCESS_KEY_ID, ConstantPropertiesUtil.ACCESS_KEY_SECRET);
        IAcsClient client = new DefaultAcsClient(profile);

        CommonRequest request = new CommonRequest();
        request.setSysMethod(MethodType.POST);
        request.setSysDomain("dysmsapi.aliyuncs.com");
        request.setSysVersion("2017-05-25");
        request.setSysAction("SendSms");
        request.putQueryParameter("RegionId", ConstantPropertiesUtil.SMS_REGIONID);
        request.putQueryParameter("PhoneNumbers", phone);
        request.putQueryParameter("SignName", ConstantPropertiesUtil.SIGN_NAME);
        request.putQueryParameter("TemplateCode", ConstantPropertiesUtil.TEMPLATE_CODE);
        request.putQueryParameter("TemplateParam", "{\"code\":\""+code+"\"}");
        try {
            CommonResponse response = client.getCommonResponse(request);
            System.out.println("返回值response："+response);
            System.out.println("返回值response.getData()："+response.getData());
            return response.getData();
        } catch (ServerException e) {
            e.printStackTrace();
        } catch (ClientException e) {
            e.printStackTrace();
        }

        return null;
    }

    public static void main(String[] args) {
        DefaultProfile profile = DefaultProfile.getProfile("cn-hangzhou", "", "");
        IAcsClient client = new DefaultAcsClient(profile);

        CommonRequest request = new CommonRequest();
        request.setSysMethod(MethodType.POST);
        request.setSysDomain("dysmsapi.aliyuncs.com");
        request.setSysVersion("2017-05-25");
        request.setSysAction("SendSms");
        request.putQueryParameter("RegionId", "cn-hangzhou");
        request.putQueryParameter("PhoneNumbers", "13558395109");
        request.putQueryParameter("SignName", "墨鱼课堂");
        request.putQueryParameter("TemplateCode", "SMS_209832260");
        request.putQueryParameter("TemplateParam", "{\"code\":\"256049\"}");
        try {
            CommonResponse response = client.getCommonResponse(request);
            System.out.println(response.getData());
        } catch (ServerException e) {
            e.printStackTrace();
        } catch (ClientException e) {
            e.printStackTrace();
        }
    }
}
