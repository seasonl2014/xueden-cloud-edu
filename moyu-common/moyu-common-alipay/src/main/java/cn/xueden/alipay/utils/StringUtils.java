package cn.xueden.alipay.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;

/**
 * @Auther:梁志杰
 * @Date:2021/5/22
 * @Description:cn.xueden.alipay.utils
 * @version:1.0
 */
public class StringUtils {
    // 读取文件
    public static String readFileOfTxt(File file) {
        String result = "";
                 try{
                         BufferedReader br = new BufferedReader(new FileReader(file));//构造一个BufferedReader类来读取文件
                         String s = null;
                         while((s = br.readLine())!=null){//使用readLine方法，一次读一行
                                 result = result  +s;
                            }
                         br.close();
                    }catch(Exception e){
                         e.printStackTrace();
                     }
                 return result;

    }
}
