package cn.xueden.edu.controller.front;

import cn.xueden.common.core.edu.domain.EduCourse;
import cn.xueden.common.core.edu.domain.EduSubject;
import cn.xueden.common.core.edu.vo.EduSubjectTreeNodeVO;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.edu.converter.EduCourseConverter;
import cn.xueden.edu.service.IEduCourseService;
import cn.xueden.edu.service.IEduSubjectService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**功能描述：前台课程列表控制层
 * @Auther:梁志杰
 * @Date:2021/2/12
 * @Description:cn.xueden.edu.controller.front
 * @version:1.0
 */
@Api(tags = "前台课程列表接口")
@RestController
@RequestMapping("/edu/front/list")
public class EduListController {

    @Autowired
    private IEduCourseService courseService;

    @Autowired
    private IEduSubjectService eduSubjectService;

    /**
     * 获取课程列表
     * @param subjectId
     * @return
     */
    @ApiOperation(value = "前台获取课程详情", notes = "前台获取课程信息")
    @PostMapping("/get/{subjectId}/{difficulty}/{courseType}/{sort}/{page}")
    public RestResponse get(@PathVariable Long subjectId,
                            @PathVariable String difficulty,
                            @PathVariable String courseType,
                            @PathVariable String sort,
                            @PathVariable Integer page) {

        if(page==null){
            page =1;
        }
        int pageSize=24;

        // 课程
        QueryWrapper<EduCourse> eduCourseQueryWrapper = new QueryWrapper<>();
        if(subjectId!=0){
            eduCourseQueryWrapper.eq("subject_id",subjectId).or().eq("subject_parent_id",subjectId);
        }

        if(difficulty!=null&&!difficulty.equals("all")){
            eduCourseQueryWrapper.eq("difficulty",difficulty);
        }

        if(courseType!=null&&!courseType.equals("all")){
            eduCourseQueryWrapper.eq("course_type",courseType);
        }

        if(sort!=null&&!sort.equals("all")){
            if(sort.equals("0")){// 按最新排序
                eduCourseQueryWrapper.orderByDesc("create_date");
            }else{// 按销售排序
                eduCourseQueryWrapper.orderByDesc("view_count");
            }
        }

        eduCourseQueryWrapper.eq("status","Normal");
        eduCourseQueryWrapper.eq("del_flag",false);
        //List<EduCourse> eduCourseList = courseService.list(eduCourseQueryWrapper);


        Page<EduCourse> eduCourseList = courseService.page(new Page<>(page,pageSize),eduCourseQueryWrapper);


        Map<String,Object> result = new HashMap<>();
        result.put("eduCourseList",EduCourseConverter.converterToVOList(eduCourseList.getRecords()));
        result.put("total",eduCourseList.getTotal());
        // 获取一级分类
        QueryWrapper<EduSubject> subjectQueryWrapper = new QueryWrapper<>();
        subjectQueryWrapper.eq("del_flag",false);
        subjectQueryWrapper.eq("parent_id",0);
        List<EduSubject> subjectList = eduSubjectService.list(subjectQueryWrapper);
        result.put("subject",subjectList);

        List<Long> idList = subjectList.stream().map(subject-> subject.getId()).collect(Collectors.toList());

        //判断是否是父节点，如果是则获取该节点下的子节点
        if(idList.contains(subjectId)){
            // 获取该子节点的父节点
            EduSubject eduSubject = eduSubjectService.getById(subjectId);

            QueryWrapper<EduSubject> sonSubjectQueryWrapper = new QueryWrapper<>();
            sonSubjectQueryWrapper.eq("del_flag",false);
            sonSubjectQueryWrapper.eq("parent_id",subjectId);
            List<EduSubject> sonSubjectList = eduSubjectService.list(sonSubjectQueryWrapper);
            result.put("sonSubject",sonSubjectList);
            result.put("parentId",subjectId);
            if(eduSubject!=null){
                result.put("eduSubject",eduSubject);
            }else{
                result.put("eduSubject",null);
            }
        }else{// 获取所有子节点

            QueryWrapper<EduSubject> sonSubjectQueryWrapper = new QueryWrapper<>();
            sonSubjectQueryWrapper.eq("del_flag",false);

            // 获取该子节点的父节点
            EduSubject eduSubject = eduSubjectService.getById(subjectId);

            if(eduSubject!=null){
                result.put("parentId",eduSubject.getParentId());
                result.put("eduSubject",eduSubject);
                sonSubjectQueryWrapper.eq("parent_id",eduSubject.getParentId());
            }else{
                result.put("eduSubject",null);
                result.put("parentId",0);
                sonSubjectQueryWrapper.ne("parent_id",0);
            }



            List<EduSubject> sonSubjectList = eduSubjectService.list(sonSubjectQueryWrapper);
            result.put("sonSubject",sonSubjectList);



        }

        return RestResponse.success().setData(result);
    }

}
