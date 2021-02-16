package cn.xueden.edu.controller;


import cn.xueden.common.core.edu.domain.EduCourse;
import cn.xueden.common.core.edu.domain.EduEnvironmenParam;
import cn.xueden.common.core.edu.domain.EduVideo;
import cn.xueden.common.core.edu.vo.EduCourseVO;
import cn.xueden.common.core.utils.LayerData;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.common.log.annotation.XudenOtherSystemLog;
import cn.xueden.common.security.annotation.PreAuthorize;
import cn.xueden.common.security.service.TokenService;
import cn.xueden.edu.converter.EduCourseConverter;
import cn.xueden.edu.service.IEduCourseService;
import cn.xueden.edu.service.IEduEnvironmenParamService;
import cn.xueden.edu.service.IEduSearchService;
import cn.xueden.edu.service.IEduVideoService;
import cn.xueden.system.api.model.LoginUser;
/*import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;*/
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**课程 前端控制器
 * @Auther:梁志杰
 * @Date:2021/1/22
 * @Description:cn.xueden.edu.controller
 * @version:1.0
 */
@Api(tags = "课程管理接口")
@RestController
@RequestMapping("/edu/course")
public class EduCourseController {

    @Autowired
    private IEduCourseService educourseService;

    @Autowired
    private TokenService tokenService ;

    @Autowired
    private IEduVideoService eduVideoService;

    @Autowired
    private IEduEnvironmenParamService eduEnvironmenParamService;

    @Autowired
    private IEduSearchService eduSearchService;

    /**
     * 分页获取课程列表
     * @param page
     * @param limit
     * @param educourseVO
     * @return
     */
    @ApiOperation(value = "课程列表",notes = "课程列表，根据课程名称模糊查询")
    @GetMapping("/list")
    @XudenOtherSystemLog("获取课程列表数据")
    @PreAuthorize(hasPermi = "edu:course:list")
    public LayerData<EduCourse> list(@RequestParam(value = "page",defaultValue = "1")Integer page,
                                     @RequestParam(value = "limit",defaultValue = "10")Integer limit,
                                     EduCourse educourseVO,Long subjectId){
        System.out.println("获取到的课程列表"+subjectId);
        LayerData<EduCourse> courseLayerData = new LayerData<>();
        QueryWrapper<EduCourse> courseQueryWrapper = new QueryWrapper();
        courseQueryWrapper.orderBy(false, false, "id", "create_date");
        if(educourseVO!=null&&educourseVO.getTitle()!=null){
            courseQueryWrapper.like("title",educourseVO.getTitle());
        }

        if(educourseVO!=null&&educourseVO.getCourseType()!=null){
            courseQueryWrapper.eq("course_type",educourseVO.getCourseType());
        }

        if(educourseVO!=null&&educourseVO.getDifficulty()!=null){
            courseQueryWrapper.eq("difficulty",educourseVO.getDifficulty());
        }

        if(subjectId!=null){
            courseQueryWrapper.eq("subject_id",subjectId).or().eq("subject_parent_id",subjectId);
        }

        Page<EduCourse> userPage = educourseService.page(new Page<>(page,limit),courseQueryWrapper);
        courseLayerData.setCount(userPage.getTotal());
        courseLayerData.setData(userPage.getRecords());
        return courseLayerData;
    }



    /**
     * 添加课程
     * @param educourseVO
     * @return
     */
    @PreAuthorize(hasPermi = "edu:course:add")
    @XudenOtherSystemLog("添加课程")
    @ApiOperation(value = "添加课程")
    @PostMapping("/add")
    public RestResponse add(@RequestBody @Validated EduCourse educourseVO){
        educourseService.save(educourseVO);
        return RestResponse.success();
    }

    /**
     * 功能描述：删除课程
     * @param id
     * @return
     */
    @XudenOtherSystemLog("删除课程")
    @ApiOperation(value = "删除课程")
    @PreAuthorize(hasPermi = "edu:course:delete")
    @DeleteMapping("/delete/{id}")
    public RestResponse delete(@PathVariable Long id){
        educourseService.removeById(id);
        return RestResponse.success();
    }

    /**
     * 编辑 课程
     * @param id
     * @return
     */
    @ApiOperation(value = "编辑课程")
    @PreAuthorize(hasPermi = "edu:course:edit")
    @GetMapping("/edit/{id}")
    public RestResponse edit(@PathVariable Long id){
        EduCourseVO eduCourseVO = educourseService.getVoById(id);
        QueryWrapper<EduEnvironmenParam> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("course_id",id);
        List<EduEnvironmenParam> eduEnvironmenParamList = eduEnvironmenParamService.list(queryWrapper);
        eduCourseVO.setEnvironmenParams(eduEnvironmenParamList);
        return RestResponse.success().setData(eduCourseVO);
    }

    /**
     * 更新 课程
     * @param id
     * @param eduCourseVO
     * @return
     */
    @XudenOtherSystemLog("更新课程")
    @ApiOperation(value = "更新课程")
    @PreAuthorize(hasPermi = "edu:course:update")
    @PutMapping("/update/{id}")
    public RestResponse update(@PathVariable Long id,
                               @RequestBody @Validated EduCourseVO eduCourseVO ){
        LoginUser loginUser= tokenService.getLoginUser();
        if(loginUser==null){
            return RestResponse.failure("更新失败");
        }else{
            EduCourse dbEduCourse = educourseService.getById(id);
            if(loginUser.getUserid()!=dbEduCourse.getCreateId()){
                return RestResponse.failure("更新失败,不能更新他人的课程");
            }

        }
        eduCourseVO.setId(id);

        if(eduCourseVO.getEnvironmenParams()!=null&&eduCourseVO.getEnvironmenParams().size()>0){
            eduEnvironmenParamService.saveOrUpdateBatch(eduCourseVO.getEnvironmenParams());
        }

        educourseService.updateById(EduCourseConverter.converterToCourse(eduCourseVO));

        // 更新索引
        eduSearchService.refreshCourse(0,id);
        return RestResponse.success();

    }

    /**
     * 更新 课程状态
     * @param eduCourse
     * @return
     */
    @XudenOtherSystemLog("更新课程状态")
    @ApiOperation(value = "更新课程状态")
    @PreAuthorize(hasPermi = "edu:course:update")
    @PutMapping("/updateStatus/{id}")
    public RestResponse updateStatus(@PathVariable Long id,
                                     @RequestBody @Validated EduCourse eduCourse){
        LoginUser loginUser= tokenService.getLoginUser();
        if(loginUser==null){
            return RestResponse.failure("更新失败");
        }else{
            EduCourse dbEduCourse = educourseService.getById(id);
            if(loginUser.getUserid()!=dbEduCourse.getCreateId()){
                return RestResponse.failure("更新失败,不能更新他人的课程");
            }

        }
        eduCourse.setId(id);

        if(eduCourse.getStatus().equalsIgnoreCase("Normal")){//发布课程
           // 统计课时
            QueryWrapper<EduVideo> videoQueryWrapper = new QueryWrapper();
            videoQueryWrapper.eq("course_id",id);
            int countVideo = eduVideoService.count(videoQueryWrapper);
            eduCourse.setLessonNum(countVideo);
        }

        educourseService.updateById(eduCourse);



        return RestResponse.success();

    }

    /**
     * 功能描述：删除课程
     * @param id
     * @return
     */
    @XudenOtherSystemLog("后台下载课程资料")
    @ApiOperation(value = "后台下载课程资料")
    @PreAuthorize(hasPermi = "edu:course:download")
    @GetMapping("/download/{id}")
    public RestResponse download(@PathVariable Long id){
        EduCourse eduCourse = null;
        if(id==null){
            return RestResponse.failure("下载失败");
        }else{
             eduCourse = educourseService.getById(id);
        }
        return RestResponse.success("下载成功").setData(eduCourse);
    }

    /**
     * 功能描述：删除课程
     * @return
     */
    @XudenOtherSystemLog("同步所有课程索引")
    @ApiOperation(value = "同步所有课程索引")
    @PreAuthorize(hasPermi = "edu:course:sync")
    @GetMapping("/syncall")
    public RestResponse syncAllCourseIndex(){
        eduSearchService.importAllCourses();
        return RestResponse.success("同步成功");
    }







}
