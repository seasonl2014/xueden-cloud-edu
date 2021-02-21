package cn.xueden.edu.controller.front;


import cn.xueden.common.core.edu.domain.EduCourse;
import cn.xueden.common.core.edu.domain.EduKeyword;
import cn.xueden.common.core.edu.vo.PageVO;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.edu.service.IEduCourseService;
import cn.xueden.edu.service.IEduKeywordService;
import cn.xueden.search.domain.CourseESItem;

import com.alibaba.fastjson.JSON;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @Autowired
    private IEduKeywordService keywordService;

    @ApiOperation(value = "前台快速搜索", notes = "前台快速搜索")
    @PostMapping("/getQuickSearch/{key}")
    public RestResponse getQuickSearch(@PathVariable String key,
                                       @RequestBody String pages) {
        Integer page = Integer.parseInt(JSON.parseObject(pages).get("page").toString());
        Integer size = Integer.parseInt(JSON.parseObject(pages).get("size").toString());
        if(page==null){
            page =1;
        }
        if(size==null){
            size =2;
        }

        Page<CourseESItem> searchs=courseService.getQuickSearch(key,page,size);
        List<CourseESItem>  esItems = searchs.getContent();
        Long total = searchs.getTotalElements();
        Map<String,Object> result = new HashMap<>();
        result.put("esItems",esItems);
        result.put("total",total);

        //获取关键词
        QueryWrapper<EduKeyword> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("name",key);
        EduKeyword eduKeyword = keywordService.getOne(queryWrapper);
        if(null != eduKeyword){//更新搜索次数
            eduKeyword.setNum(eduKeyword.getNum()+1);
        }else{
            eduKeyword = new EduKeyword();
            eduKeyword.setNum(1);
            eduKeyword.setName(key);
        }
        keywordService.saveOrUpdate(eduKeyword);

      return RestResponse.success().setData(result).setCode(200);

    }

    @ApiOperation(value = "前台站长推荐", notes = "前台站长推荐")
    @PostMapping("/getRecommended")
    public RestResponse getRecommended() {
        PageVO<EduCourse> coursePage = courseService.getRecommended(1,10);
        return RestResponse.success().setData(coursePage.getRows()).setCode(200);

    }

}
