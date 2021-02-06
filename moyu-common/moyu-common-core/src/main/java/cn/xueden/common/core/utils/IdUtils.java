package cn.xueden.common.core.utils;

import cn.xueden.common.core.text.UUID;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**功能描述：ID生成器工具类
 * @Auther:梁志杰
 * @Date:2020/9/24
 * @Description:cn.xueden.common.core.utils
 * @version:1.0
 */
public class IdUtils {

    /**
     * 生成订单号
     * @return
     */
    public static String createOrderNumber(){
        String date = new SimpleDateFormat("yyyyMMdd").format(new Date());
        String seconds = new SimpleDateFormat("HHmmss").format(new Date());
        String result = date+"00001000"+getTwo()+"00"+seconds+getTwo();
        return result;
    }

    /**
     * * 产生随机的2位数
     * * @return
     * */
    public static String getTwo(){
        Random rad=new Random();
        String result  = rad.nextInt(100) +"";
        if(result.length()==1){
            result = "0" + result;
        }
        return result;
    }

    /**
     * 获取随机UUID
     *
     * @return 随机UUID
     */
    public static String randomUUID()
    {
        return UUID.randomUUID().toString();
    }

    /**
     * 简化的UUID，去掉了横线
     *
     * @return 简化的UUID，去掉了横线
     */
    public static String simpleUUID()
    {
        return UUID.randomUUID().toString(true);
    }

    /**
     * 获取随机UUID，使用性能更好的ThreadLocalRandom生成UUID
     *
     * @return 随机UUID
     */
    public static String fastUUID()
    {
        return UUID.fastUUID().toString();
    }

    /**
     * 简化的UUID，去掉了横线，使用性能更好的ThreadLocalRandom生成UUID
     *
     * @return 简化的UUID，去掉了横线
     */
    public static String fastSimpleUUID()
    {
        return UUID.fastUUID().toString(true);
    }
}
