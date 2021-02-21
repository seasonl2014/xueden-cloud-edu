package cn.xueden.edu.controller;

import cn.xueden.alivod.PutObjectProgressListener;
import cn.xueden.alivod.utils.ConstantPropertiesUtil;
import cn.xueden.common.core.edu.domain.EduCourse;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.common.log.annotation.XudenOtherSystemLog;
import cn.xueden.common.redis.service.RedisService;
import cn.xueden.common.security.annotation.PreAuthorize;
import cn.xueden.edu.service.IEduCourseService;
import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.model.OSSObject;
import com.aliyun.oss.model.PutObjectRequest;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**功能描述：上传文件
 * @Auther:梁志杰
 * @Date:2021/1/22
 * @Description:cn.xueden.edu.controller
 * @version:1.0
 */
@RestController
@RequestMapping("/edu/oss")
public class FileUploadController {

    @Autowired
    private IEduCourseService eduCourseService;

    @Autowired
    private RedisService redisService;

    @Autowired
    private IEduCourseService educourseService;

    /**
     * 上传讲师头像的方法
     * @param file
     * @return
     */
    @PostMapping(value = "upload",produces = "application/json")
    public RestResponse uploadTeacherIcon(@RequestParam("file") MultipartFile file, @RequestParam(value = "host",required = false) String host){
        // Endpoint以杭州为例，其它Region请按实际情况填写。
        String endpoint = ConstantPropertiesUtil.END_POINT;
        // 阿里云主账号AccessKey拥有所有API的访问权限，风险很高。强烈建议您创建并使用RAM账号进行API访问或日常运维，请登录 https://ram.console.aliyun.com 创建RAM账号。
        String accessKeyId = ConstantPropertiesUtil.ACCESS_KEY_ID;
        String accessKeySecret = ConstantPropertiesUtil.ACCESS_KEY_SECRET;
        String yourBucketName = ConstantPropertiesUtil.BUCKET_NAME;
        String hostpath = ConstantPropertiesUtil.HOST_PATH;
        try {
            //1、获取到上传文件MultipartFile file
            //2、获取上传文件名称，获取上传文化输入法
            String filename = file.getOriginalFilename();
            //在文件名之前加上uuid，保证文件名称不重复（防止覆盖问题）
            String uuid = UUID.randomUUID().toString();
            filename = uuid+filename;

            //构建日期路径：2020/02/03
            String filePath = new DateTime().toString("yyyy/MM/dd");

            //拼接文件完整路径  /2020/02/03/文件名
            //filename = filePath + "/" +filename;

            String hostName = ConstantPropertiesUtil.HOST;
            //如果上传的是头像，则host里为空，如果上传封面host则有值
            if (StringUtils.isNotEmpty(host)) {
                hostName = host;
            }

            filename = filePath+"/"+hostName+"/"+filename;

            InputStream inputStream = file.getInputStream();

            //3、把上传文件存储到阿里云oss里面
            // 创建OSSClient实例。
            OSS ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

            // 上传文件流。
            ossClient.putObject(yourBucketName, filename, inputStream);

            // 关闭OSSClient。
            ossClient.shutdown();

            String path = hostpath+"/"+filename;
            Map<String,Object> map = new HashMap<String,Object>();
            map.put("urlPath",path);
            return RestResponse.success().setData(map);

        } catch (IOException e) {
            e.printStackTrace();
            return RestResponse.failure("上传头像失败");
        }

    }

    /**
     * 上传课程资料的方法
     * @param file
     * @return
     */
    @PostMapping(value = "uploadCourseResource",produces = "application/json")
    public RestResponse uploadCourseResource(@RequestParam("file") MultipartFile file,
                                             @RequestParam(value = "id",required = false) Integer id,
                                             @RequestParam(value = "fileKey",required = false) String fileKey){
        String endpoint = ConstantPropertiesUtil.END_POINT;
        String accessKeyId = ConstantPropertiesUtil.ACCESS_KEY_ID;
        String accessKeySecret = ConstantPropertiesUtil.ACCESS_KEY_SECRET;
        String yourBucketName = ConstantPropertiesUtil.BUCKET_COURSE_NAME;
        String hostpath = ConstantPropertiesUtil.HOST_PATH;
        try {

            if(id==null){
                return RestResponse.failure("上传资料失败,课程ID不存在");
            }

            EduCourse dbEduCourse = eduCourseService.getById(id);
            if(dbEduCourse==null){
                return RestResponse.failure("上传资料失败,课程不存在");
            }

            if(fileKey.equalsIgnoreCase(dbEduCourse.getFileKey())){
                return RestResponse.success("极速秒传成功");
            }


            //1、获取到上传文件MultipartFile file
            String filename = file.getOriginalFilename();
            // 2、获取文件后缀名
            String substring = filename.substring(filename.lastIndexOf(".")).toLowerCase();


            //在文件名之前加上uuid，保证文件名称不重复（防止覆盖问题）
            String uuid = UUID.randomUUID().toString();
            //构建日期名称：2020-02-03
            String fileDate = new DateTime().toString("yyyy-MM-dd");
            filename = uuid+"-"+fileDate+"-"+id+substring;

            String hostName = ConstantPropertiesUtil.HOST_COURSE;

            filename = hostName+"/"+filename;

            InputStream inputStream = file.getInputStream();

            //3、把上传文件存储到阿里云oss里面
            // 创建OSSClient实例。
            OSS ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

            // 上传文件流。
            //ossClient.putObject(yourBucketName, filename, inputStream);
            // 带进度条的上传
            ossClient.putObject(new PutObjectRequest(yourBucketName, filename, inputStream).
                    <PutObjectRequest>withProgressListener(new PutObjectProgressListener(redisService,inputStream.available(),fileKey)));

            // 关闭OSSClient。
            ossClient.shutdown();

            // 保存记录到课程表
            dbEduCourse.setDownloadLink(filename);
            dbEduCourse.setFileKey(fileKey);
            eduCourseService.updateById(dbEduCourse);

            //http://.......//2020/02/03/career/01.jpg
            String path = hostpath+"/"+filename;
            Map<String,Object> map = new HashMap<String,Object>();
            map.put("urlPath",path);
            return RestResponse.success("上传资料成功").setData(map);

        } catch (IOException e) {
            e.printStackTrace();
            return RestResponse.failure("上传资料失败");
        }

    }

    /**
     * 获取实时长传进度(批量上传)
     * @param fileKey
     * @return
     */
    @GetMapping("getUploadPercent/{fileKey}")
    public RestResponse getUploadPercent(@PathVariable String fileKey){
        System.out.println("从redis获取===="+fileKey+"=====批量方法====："+redisService.getCacheObject("upload_percent:"+fileKey));
        int percent = redisService.getCacheObject("upload_percent:"+fileKey) == null ? 0: (int) redisService.getCacheObject("upload_percent:"+fileKey);
        Map<String,Object> map = new HashMap<>();
        map.put("percent",percent);
        return RestResponse.success().setData(map);
    }

    /**
     * 功能描述：下载课程资料
     * @param request
     * @return
     */
    @GetMapping("/downFileFromOss")
    public void downFileFromOss(HttpServletRequest request, HttpServletResponse response){
        response.setCharacterEncoding("utf-8");
        response.setContentType("application/octet-stream");
        String yourBucketName = ConstantPropertiesUtil.BUCKET_COURSE_NAME;
        String endpoint = ConstantPropertiesUtil.END_POINT;
        String accessKeyId = ConstantPropertiesUtil.ACCESS_KEY_ID;
        String accessKeySecret = ConstantPropertiesUtil.ACCESS_KEY_SECRET;
        String fileName = request.getParameter("fileName");
        response.addHeader("Content-Disposition", "attachment;filename="+fileName);
        try {
            // 创建OSSClient实例。
            OSS ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);
            OSSObject oSSObject = ossClient.getObject(yourBucketName, fileName);
            byte[] Object = IOUtils.toByteArray(oSSObject.getObjectContent());
            //byte[] Object = ossClient.downFile2OSS(eduCourse.getDownloadLink());
            response.getOutputStream().write(Object);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}

