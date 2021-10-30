package cn.xueden.common.core.utils;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Date;

/**功能描述：字符串工具类, 继承org.apache.commons.lang3.StringUtils类
 * @Auther:梁志杰
 * @Date:2021/5/27
 * @Description:cn.xueden.common.core.utils
 * @version:1.0
 */
public class StringUtils extends org.apache.commons.lang3.StringUtils{

    /**
     * LocalDate转Date
     * @param localDate
     * @return
     */
    public static Date localDate2Date(LocalDate localDate) {
        if(null == localDate) {
            return null;
        }
        ZonedDateTime zonedDateTime = localDate.atStartOfDay(ZoneId.systemDefault());
        return Date.from(zonedDateTime.toInstant());
    }

    public static void main(String[] args) {
        LocalDate localDate = LocalDate.now();
       /* LocalDate yesterday = localDate.plusDays(-1);
        System.out.println(yesterday.getDayOfMonth());
        System.out.println(yesterday.getMonthValue());
        System.out.println(yesterday.getYear());*/
       System.out.println(""+localDate.minusDays(1).toString());
        System.out.println(""+localDate.minusDays(0).toString());

    }
}
