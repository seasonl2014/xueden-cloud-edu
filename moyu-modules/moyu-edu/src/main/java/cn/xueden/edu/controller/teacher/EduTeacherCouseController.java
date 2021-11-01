package cn.xueden.edu.controller.teacher;

import cn.xueden.alivod.utils.AliyunVODSDKUtils;
import cn.xueden.alivod.utils.ConstantPropertiesUtil;
import cn.xueden.common.core.edu.domain.*;
import cn.xueden.common.core.edu.vo.*;
import cn.xueden.common.core.utils.LayerData;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.common.log.annotation.XudenOtherSystemLog;
import cn.xueden.common.redis.service.RedisService;

import cn.xueden.common.security.service.TokenService;

import cn.xueden.edu.service.*;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.vod.model.v20170321.GetVideoPlayAuthRequest;
import com.aliyuncs.vod.model.v20170321.GetVideoPlayAuthResponse;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**功能描述：教师平台 我的课程控制器
 * @Auther:梁志杰
 * @Date:2021/5/23
 * @Description:cn.xueden.edu.controller.teacher
 * @version:1.0
 */
@Api(tags = "讲师我的课程接口")
@RestController
@RequestMapping("/edu/teacher/course")
public class EduTeacherCouseController {

    @Autowired
    private IEduCourseService educourseService;

    @Autowired
    private TokenService tokenService;

    @Autowired
    private IEduMemberService memberService;

    @Autowired
    private IEduEnvironmenParamService eduEnvironmenParamService;

    @Autowired
    private IEduChapterService chapterService;

    @Autowired
    private IEduVideoService eduVideoService;

    @Autowired
    private RedisService redisService;

    /**
     * 分页获取讲师我的课程课程列表
     * @param page
     * @param limit
     * @param educourseVO
     * @return
     */
    @ApiOperation(value = "课程列表",notes = "课程列表，根据课程名称模糊查询")
    @GetMapping
    @XudenOtherSystemLog("分页获取讲师我的课程课程列表数据")
    public LayerData<EduCourse> list(@RequestParam(value = "pageIndex",defaultValue = "1")Integer page,
                                     @RequestParam(value = "pageSize",defaultValue = "10")Integer limit,
                                     EduCourse educourseVO, HttpServletRequest request){
        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return null;
        }
        LayerData<EduCourse> courseLayerData = new LayerData<>();
        //根据token,获取登录会员信息
        EduMemberVO eduMemberVO = tokenService.getLoginMember();
        if(eduMemberVO==null){
            return null;
        }
        // 获取会员信息
        EduMember dbEduMember = memberService.getById(eduMemberVO.getId());

        QueryWrapper<EduCourse> courseQueryWrapper = new QueryWrapper();
        courseQueryWrapper.orderByDesc("id");
        if(educourseVO!=null&&educourseVO.getTitle()!=null&&educourseVO.getTitle().trim().length()>0){
            courseQueryWrapper.like("title",educourseVO.getTitle());
        }

        if(educourseVO!=null&&educourseVO.getCourseType()!=null){
            courseQueryWrapper.eq("course_type",educourseVO.getCourseType());
        }

        if(educourseVO!=null&&educourseVO.getDifficulty()!=null){
            courseQueryWrapper.eq("difficulty",educourseVO.getDifficulty());
        }

        if(educourseVO!=null&&educourseVO.getStatus()!=null&&educourseVO.getStatus().trim().length()>0){
            courseQueryWrapper.eq("status",educourseVO.getStatus());
        }

        if(dbEduMember.getTeacherId()==null){
            return null;
        }

        courseQueryWrapper.eq("teacher_id",dbEduMember.getTeacherId());
        Page<EduCourse> userPage = educourseService.page(new Page<>(page,limit),courseQueryWrapper);
        courseLayerData.setCount(userPage.getTotal());
        courseLayerData.setData(userPage.getRecords());
        return courseLayerData;
    }

    /**
     * 讲师添加我的课程
     * @param educourseVO
     * @return
     */
    @XudenOtherSystemLog("讲师添加我的课程")
    @ApiOperation(value = "讲师添加我的课程")
    @PostMapping
    public RestResponse add(@RequestBody @Validated EduCourse educourseVO,
                            HttpServletRequest request){
        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return null;
        }
        //根据token,获取登录会员信息
        EduMemberVO eduMemberVO = tokenService.getLoginMember();
        if(eduMemberVO==null){
            return null;
        }
        educourseVO.setCover("http://alioss.xueden.cn/2021/01/30/career/aed2c204-14b6-4d4e-815a-f1e630db0b9e12.jpg");//封面
        educourseVO.setTeacherId(eduMemberVO.getTeacherId());
        educourseVO.setCreateId(eduMemberVO.getTeacherId());
        educourseVO.setUpdateId(eduMemberVO.getTeacherId());
        if(educourseVO.getId()!=null){
            educourseVO.setStatus("Draft");
            educourseService.updateById(educourseVO);
        }else{
            educourseService.save(educourseVO);
        }

        return RestResponse.success();
    }

    /**
     * 编辑 课程
     * @param id
     * @return
     */
    @ApiOperation(value = "编辑课程")
    @GetMapping("/{id}")
    public RestResponse edit(@PathVariable Long id){
        EduCourseVO eduCourseVO = educourseService.getVoById(id);
        QueryWrapper<EduEnvironmenParam> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("course_id",id);
        List<EduEnvironmenParam> eduEnvironmenParamList = eduEnvironmenParamService.list(queryWrapper);
        eduCourseVO.setEnvironmenParams(eduEnvironmenParamList);
        return RestResponse.success().setData(eduCourseVO);
    }

    /**
     * 保存或更新课程环境
     * @param eduEnvironmenParamList
     * @return
     */
    @XudenOtherSystemLog("保存或更新课程环境")
    @ApiOperation(value = "保存或更新课程环境")
    @PostMapping("/saveOrUpdateEnvironmen")
    public RestResponse saveOrUpdateEnvironmen(@RequestBody @Validated List<EduEnvironmenParam> eduEnvironmenParamList,
                            HttpServletRequest request){
        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return null;
        }
        //根据token,获取登录会员信息
        EduMemberVO eduMemberVO = tokenService.getLoginMember();
        if(eduMemberVO==null){
            return null;
        }
        if(eduEnvironmenParamList.size()>0){

            for (EduEnvironmenParam eduEnvironmenParam: eduEnvironmenParamList){
                if(eduEnvironmenParam.getId()!=null&& eduEnvironmenParam.getId()>0){

                    eduEnvironmenParamService.updateById(eduEnvironmenParam);
                }else{
                    eduEnvironmenParam.setCreateId(eduMemberVO.getTeacherId());
                    eduEnvironmenParam.setUpdateId(eduMemberVO.getTeacherId());
                    eduEnvironmenParamService.save(eduEnvironmenParam);
                }
            }

        }else{
            return RestResponse.failure("保存失败");
        }


        return RestResponse.success();
    }

    /**
     * 功能描述：删除环境参数
     * @param id
     * @return
     */
    @XudenOtherSystemLog("删除环境参数")
    @ApiOperation(value = "删除环境参数")
    @DeleteMapping("/{id}")
    public RestResponse delete(@PathVariable Long id){
        eduEnvironmenParamService.removeById(id);
        return RestResponse.success();
    }

    /**
     * 章节树形结构(分页)
     *
     * @return
     */
    @ApiOperation(value = "章节树形结构")
    @GetMapping("/chapterTree")
    public RestResponse chapterTree(@RequestParam(value = "page", required = false,defaultValue = "1") Integer pageNum,
                                    @RequestParam(value = "pageSize", required = false,defaultValue = "5") Integer pageSize,
                                    EduChapterVO eduChapterVO) {
        if(eduChapterVO==null){
            return RestResponse.failure("获取章节失败");
        }else{
            if(eduChapterVO.getCourseId()==null){
                return RestResponse.failure("获取章节失败");
            }
        }
        PageVO<EduChapterTreeNodeVO> pageVO = chapterService.chapterTree(pageNum, pageSize,eduChapterVO);
        return RestResponse.success().setData(pageVO);
    }

    /**
     * 根据视频id获取播放凭证
     * @param vid
     * @return
     */
    @GetMapping("getPlayAuth/{vid}")
    @XudenOtherSystemLog("根据视频id获取阿里云视频点播播放凭证")
    public RestResponse getPlayAutoId(@PathVariable String vid){
        return getPlayAutoId2(vid);

    }

    /**
     *  根据视频id获取播放凭证
     * @param vid
     * @return
     */
    @PostMapping("getPlayAuth2/{vid}")
    public RestResponse getPlayAutoId2(@PathVariable String vid){
        try {
            //初始化客户端、请求对象和相应对象
            DefaultAcsClient client = AliyunVODSDKUtils.initVodClient(ConstantPropertiesUtil.ACCESS_KEY_ID, ConstantPropertiesUtil.ACCESS_KEY_SECRET);

            GetVideoPlayAuthRequest request = new GetVideoPlayAuthRequest();
            GetVideoPlayAuthResponse response = new GetVideoPlayAuthResponse();

            //设置请求参数
            request.setVideoId(vid);
            //获取请求响应
            response = client.getAcsResponse(request);

            //输出请求结果
            //播放凭证
            String playAuth = response.getPlayAuth();
            Map<String,Object> map = new HashMap<>();
            map.put("playAuth",playAuth);
            return RestResponse.success().setData(map);
        } catch (Exception e) {
            e.printStackTrace();
            return RestResponse.failure("获取播放凭证失败");
        }

    }

    /**
     * 编辑课程大章
     * @param id
     * @return
     */
    @ApiOperation(value = "编辑课程大章", notes = "编辑课程大章信息")
    @GetMapping("/chapter/{id}")
    public RestResponse getChapterById(@PathVariable Long id) {
        EduChapter eduChapterVO = chapterService.getById(id);
        return RestResponse.success().setData(eduChapterVO);
    }

    /**
     * 获取实时长传进度(批量上传)
     * @param fileKey
     * @return
     */
    @GetMapping("getBatchUploadPercent/{fileKey}")
    public RestResponse getBatchUploadPercent(@PathVariable String fileKey){
        System.out.println("从redis获取===="+fileKey+"=====批量方法====："+redisService.getCacheObject("upload_percent:"+fileKey));
        int percent = redisService.getCacheObject("upload_percent:"+fileKey) == null ? 0: (int) redisService.getCacheObject("upload_percent:"+fileKey);
        Map<String,Object> map = new HashMap<>();
        map.put("percent",percent);
        return RestResponse.success().setData(map);
    }

    /**
     * 讲师添加和编辑课程大章
     * @param eduChapterVO
     * @return
     */
    @XudenOtherSystemLog("讲师添加和编辑课程大章")
    @ApiOperation(value = "讲师添加和编辑课程大章")
    @PostMapping("/addEduChapter")
    public RestResponse addEduChapter( EduChapter eduChapterVO,
                            HttpServletRequest request){
        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return null;
        }
        //根据token,获取登录会员信息
        EduMemberVO eduMemberVO = tokenService.getLoginMember();
        if(eduMemberVO==null){
            return null;
        }

        eduChapterVO.setCreateId(eduMemberVO.getTeacherId());
        eduChapterVO.setUpdateId(eduMemberVO.getTeacherId());
        if(eduChapterVO.getId()>0){
            chapterService.updateById(eduChapterVO);
        }else {
            chapterService.save(eduChapterVO);
        }

        return RestResponse.success();
    }

    /**
     * 更新课程小节
     *
     * @return
     */
    @ApiOperation(value = "更新课时", notes = "更新课时信息")
    @XudenOtherSystemLog("课时更新")
    @PutMapping("/updateVideo/{id}")
    public RestResponse updateVideo(@PathVariable Long id, @RequestBody EduVideo eduVideoVO) {
        eduVideoVO.setId(id);
        eduVideoService.updateById(eduVideoVO);
        return RestResponse.success();
    }

    /**
     * 删除课程大章
     * @param id
     * @return
     */
    @ApiOperation(value = "讲师删除课程大章", notes = "讲师删除课程大章信息")
    @XudenOtherSystemLog("讲师删除课程大章")
    @DeleteMapping("/delsEduChapter/{id}")
    public RestResponse delsEduChapter(@PathVariable Long id) {
        chapterService.removeById(id);
        return RestResponse.success();
    }

    /**
     * 讲师删除课时
     * @param id
     * @return
     */
    @ApiOperation(value = "讲师删除课时", notes = "讲师删除课时")
    @XudenOtherSystemLog("讲师删除课时")
    @DeleteMapping("/delsEduVideo/{id}")
    public RestResponse delsEduVideo(@PathVariable Long id) {
        eduVideoService.removeById(id);
        return RestResponse.success();
    }

    /**
     * 讲师获取课程课时
     * @param id
     * @return
     */
    @ApiOperation(value = "讲师获取课程课时", notes = "讲师获取课程课时")
    @XudenOtherSystemLog("讲师获取课程课时")
    @GetMapping("/video/{id}")
    public RestResponse video(@PathVariable Long id) {
        EduVideo eduVideoVO = eduVideoService.getById(id);
        return RestResponse.success().setData(eduVideoVO);
    }

    /**
     * 获取实时长传进度
     * @param videoId
     * @return
     */
    @GetMapping("getUploadPercent/{videoId}")
    public RestResponse getUploadPercent(@PathVariable String videoId){
        System.out.println("从redis获取=========方法====："+redisService.getCacheObject("upload_percent:"+videoId));
        int percent = redisService.getCacheObject("upload_percent:"+videoId) == null ? 0: (int) redisService.getCacheObject("upload_percent:"+videoId);
        Map<String,Object> map = new HashMap<>();
        map.put("percent",percent);
        return RestResponse.success().setData(map);
    }


}
