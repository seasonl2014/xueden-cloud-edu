package cn.xueden.edu.controller;

import cn.xueden.common.core.edu.domain.EduTeacher;
import cn.xueden.common.core.edu.vo.EduTeacherVO;
import cn.xueden.common.core.utils.LayerData;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.common.log.annotation.XudenOtherSystemLog;
import cn.xueden.common.security.annotation.PreAuthorize;
import cn.xueden.edu.service.IEduTeacherService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**讲师 前端控制器
 * @Auther:梁志杰
 * @Date:2021/1/22
 * @Description:cn.xueden.edu.controller
 * @version:1.0
 */
@Api(tags = "讲师管理接口")
@RestController
@RequestMapping("/edu/teacher")
public class EduTeacherController {

    @Autowired
    private IEduTeacherService eduTeacherService;

    /**
     * 分页获取讲师列表
     * @param page
     * @param limit
     * @param eduTeacherVO
     * @return
     */
    @ApiOperation(value = "讲师列表",notes = "讲师列表，根据讲师名称模糊查询")
    @GetMapping("/list")
    @XudenOtherSystemLog("获取用户列表数据")
    @PreAuthorize(hasPermi = "edu:teacher:list")
    public LayerData<EduTeacher> list(@RequestParam(value = "page",defaultValue = "1")Integer page,
                                                    @RequestParam(value = "limit",defaultValue = "15")Integer limit,
                                                    EduTeacherVO eduTeacherVO){
        LayerData<EduTeacher> teacherLayerData = new LayerData<>();
        EntityWrapper<EduTeacher> userEntityWrapper = new EntityWrapper();
        if(eduTeacherVO!=null&&eduTeacherVO.getName()!=null){
            userEntityWrapper.like("name",eduTeacherVO.getName());
        }

        if(eduTeacherVO!=null&&eduTeacherVO.getLevel()!=null){
            userEntityWrapper.eq("level",eduTeacherVO.getLevel());
        }

        Page<EduTeacher> userPage = eduTeacherService.selectPage(new Page<>(page,limit),userEntityWrapper);
        teacherLayerData.setCount(userPage.getTotal());
        teacherLayerData.setData(userPage.getRecords());
        return teacherLayerData;
    }



    /**
     * 添加讲师
     * @param eduTeacherVO
     * @return
     */
    @PreAuthorize(hasPermi = "edu:teacher:add")
    @XudenOtherSystemLog("添加讲师")
    @ApiOperation(value = "添加讲师")
    @PostMapping("/add")
    public RestResponse add(@RequestBody @Validated EduTeacher eduTeacherVO){
        eduTeacherService.insert(eduTeacherVO);
        return RestResponse.success();
    }

    /**
     * 功能描述：删除讲师
     * @param id
     * @return
     */
    @XudenOtherSystemLog("删除讲师")
    @ApiOperation(value = "删除讲师")
    @PreAuthorize(hasPermi = "edu:teacher:delete")
    @DeleteMapping("/delete/{id}")
    public RestResponse delete(@PathVariable Long id){
        eduTeacherService.deleteById(id);
        return RestResponse.success();
    }

    /**
     * 编辑 讲师
     * @param id
     * @return
     */
    @ApiOperation(value = "编辑讲师")
    @PreAuthorize(hasPermi = "edu:teacher:edit")
    @GetMapping("/edit/{id}")
    public RestResponse edit(@PathVariable Long id){
        EduTeacher eduTeacherVO = eduTeacherService.selectById(id);
        return RestResponse.success().setData(eduTeacherVO);
    }

    /**
     * 更新 讲师
     * @param id
     * @param eduTeacherVO
     * @return
     */
    @XudenOtherSystemLog("更新讲师")
    @ApiOperation(value = "更新讲师")
    @PreAuthorize(hasPermi = "edu:teacher:update")
    @PutMapping("/update/{id}")
    public RestResponse update(@PathVariable Long id,
                               @RequestBody @Validated EduTeacher eduTeacherVO){
        eduTeacherVO.setId(id);
        eduTeacherService.updateById(eduTeacherVO);
        return RestResponse.success();

    }


}
