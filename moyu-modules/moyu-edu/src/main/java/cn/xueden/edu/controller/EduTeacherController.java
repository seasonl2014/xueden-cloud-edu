package cn.xueden.edu.controller;

import cn.xueden.common.core.edu.domain.EduTeacher;
import cn.xueden.common.core.edu.vo.EduTeacherVO;
import cn.xueden.common.core.utils.LayerData;
import cn.xueden.common.log.annotation.XudenOtherSystemLog;
import cn.xueden.common.security.annotation.PreAuthorize;
import cn.xueden.edu.service.IEduTeacherService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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
}
