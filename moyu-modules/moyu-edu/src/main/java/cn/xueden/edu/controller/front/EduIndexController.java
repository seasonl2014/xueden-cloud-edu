package cn.xueden.edu.controller.front;

import cn.xueden.common.core.edu.domain.EduBanner;
import cn.xueden.common.core.edu.vo.EduCourseVO;
import cn.xueden.common.core.edu.vo.EduSubjectVO;
import cn.xueden.common.core.edu.vo.MyCourseVO;
import cn.xueden.common.core.edu.vo.PageVO;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.edu.service.IEduBannerService;
import cn.xueden.edu.service.IEduCourseService;
import cn.xueden.edu.service.IEduMemberService;
import cn.xueden.edu.service.IEduSubjectService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**功能描述：前端首页控制层
 * @Auther:梁志杰
 * @Date:2021/1/30
 * @Description:cn.xueden.edu.controller.front
 * @version:1.0
 */

@Api(tags = "前台首页接口")
@RestController
@RequestMapping("/edu/front/index")
public class EduIndexController {

    @Autowired
    private IEduCourseService courseService;

    @Autowired
    private IEduMemberService memberService;

    @Autowired
    private IEduSubjectService subjectService;

    @Autowired
    private IEduBannerService bannerService;


    /**
     * 获取首页各类别课程
     * @return
     */
    @ApiOperation(value = "课程列表", notes = "课程列表")
    @PostMapping("/findIndexCourseList")
    @CrossOrigin
    public RestResponse findIndexCourseList(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
                                            @RequestParam(value = "pageSize",defaultValue = "8") Integer pageSize,
                                            @RequestBody EduCourseVO courseVO) {
        List<EduCourseVO> courseVOS = courseService.findIndexCourseList(pageNum, pageSize, courseVO);
        return RestResponse.success().setData(courseVOS);
    }

    /**
     * 获取首页课程栏目
     * @return
     */
    @ApiOperation(value = "首页课程栏目", notes = "首页课程栏目")
    @PostMapping("/getIndexColumnCourses")
    public RestResponse getIndexColumnCourses(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
                                              @RequestParam(value = "pageSize",defaultValue = "6") Integer pageSize) {
        List<EduSubjectVO> eduSubjectVOS = subjectService.getIndexColumnCourses(pageNum, pageSize);
        return RestResponse.success().setData(eduSubjectVOS);
    }

    /**
     * 统计注册会员
     * @return
     */
    @ApiOperation(value = "统计注册会员", notes = "统计注册会员")
    @PostMapping("/getMemberTotal")
    public RestResponse getMemberTotal() {
        int memberTotal = memberService.getMemberTotal();
        return RestResponse.success().setData(memberTotal);
    }

    /**
     * 统计注册会员
     * @return
     */
    @ApiOperation(value = "首页获取幻灯片", notes = "首页获取幻灯片")
    @PostMapping("/getBanner")
    public RestResponse getBanner(@RequestBody MyCourseVO pageVO) {
        QueryWrapper<EduBanner> eduBannerQueryWrapper = new QueryWrapper<>();
        eduBannerQueryWrapper.eq("del_flag",false);
        eduBannerQueryWrapper.orderByDesc("level");

        Page<EduBanner> eduBannerPage = bannerService.page(new Page<>(pageVO.getPageNo(),pageVO.getPageSize()),eduBannerQueryWrapper);
        Map<String,Object> result = new HashMap<>();
        result.put("list",eduBannerPage.getRecords());
        return RestResponse.success().setData(result);
    }

}
