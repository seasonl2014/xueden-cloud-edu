package cn.xueden.edu.controller.front;

import cn.xueden.common.core.edu.domain.EduCourse;
import cn.xueden.common.core.edu.domain.EduEnvironmenParam;
import cn.xueden.common.core.edu.domain.EduTeacher;
import cn.xueden.common.core.edu.vo.EduChapterVO;
import cn.xueden.common.core.edu.vo.EduCourseVO;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.edu.service.IEduCourseService;
import cn.xueden.search.domain.CourseESItem;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Auther:梁志杰
 * @Date:2021/2/15
 * @Description:cn.xueden.edu.controller.front
 * @version:1.0
 */
@Api(tags = "前台课程搜索接口")
@RestController
@RequestMapping("/edu/front/search")
public class EduSearchController {

    @Autowired
    private IEduCourseService courseService;

    @ApiOperation(value = "前台快速搜索", notes = "前台快速搜索")
    @PostMapping("/getQuickSearch")
    public RestResponse getQuickSearch(@RequestParam(defaultValue = "") String key) {

      List<CourseESItem>  esItems = courseService.getQuickSearch(key);

      return RestResponse.success().setData(esItems);

    }

}
