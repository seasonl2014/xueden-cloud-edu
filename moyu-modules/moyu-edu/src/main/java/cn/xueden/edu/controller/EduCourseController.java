package cn.xueden.edu.controller;


import cn.xueden.common.core.edu.domain.EduCourse;
import cn.xueden.common.core.utils.LayerData;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.common.log.annotation.XudenOtherSystemLog;
import cn.xueden.common.security.annotation.PreAuthorize;
import cn.xueden.common.security.service.TokenService;
import cn.xueden.edu.service.IEduCourseService;
import cn.xueden.system.api.model.LoginUser;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

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

    /**
     * 分页获取课程列表
     * @param page
     * @param limit
     * @param educourseVO
     * @return
     */
    @ApiOperation(value = "课程列表",notes = "课程列表，根据课程名称模糊查询")
    @GetMapping("/list")
    @XudenOtherSystemLog("获取用户列表数据")
    @PreAuthorize(hasPermi = "edu:course:list")
    public LayerData<EduCourse> list(@RequestParam(value = "page",defaultValue = "1")Integer page,
                                     @RequestParam(value = "limit",defaultValue = "10")Integer limit,
                                     EduCourse educourseVO){
        LayerData<EduCourse> courseLayerData = new LayerData<>();
        EntityWrapper<EduCourse> userEntityWrapper = new EntityWrapper();
        userEntityWrapper.orderBy("create_date",false);
        if(educourseVO!=null&&educourseVO.getTitle()!=null){
            userEntityWrapper.like("title",educourseVO.getTitle());
        }

        if(educourseVO!=null&&educourseVO.getCourseType()!=null){
            userEntityWrapper.eq("course_type",educourseVO.getCourseType());
        }

        Page<EduCourse> userPage = educourseService.selectPage(new Page<>(page,limit),userEntityWrapper);
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
        educourseService.insert(educourseVO);
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
        educourseService.deleteById(id);
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
        EduCourse eduCourseVO = educourseService.selectById(id);
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
                               @RequestBody @Validated EduCourse eduCourseVO){
        LoginUser loginUser= tokenService.getLoginUser();
        eduCourseVO.setId(id);
        educourseService.updateById(eduCourseVO);
        return RestResponse.success();

    }


}
