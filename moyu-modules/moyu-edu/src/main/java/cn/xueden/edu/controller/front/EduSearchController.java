package cn.xueden.edu.controller.front;


import cn.xueden.common.core.edu.domain.EduCourse;
import cn.xueden.common.core.edu.domain.EduKeyword;
import cn.xueden.common.core.edu.vo.EduMemberVO;
import cn.xueden.common.core.edu.vo.PageVO;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.common.redis.service.RedisService;
import cn.xueden.common.security.service.TokenService;
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

import javax.servlet.http.HttpServletRequest;
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

    @Autowired
    private TokenService tokenService;

    @ApiOperation(value = "前台快速搜索", notes = "前台快速搜索")
    @PostMapping("/getQuickSearch/{key}")
    public RestResponse getQuickSearch(@PathVariable String key,
                                       @RequestBody String pages,
                                       HttpServletRequest request) {
        Integer page = Integer.parseInt(JSON.parseObject(pages).get("page").toString());
        Integer size = Integer.parseInt(JSON.parseObject(pages).get("size").toString());
        String token = request.getHeader("Authorization");
        if(page==null){
            page =1;
        }
        if(size==null){
            size =2;
        }
        //根据token,获取登录会员信息
        EduMemberVO eduMemberToken = tokenService.getLoginMember();

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
        if(eduMemberToken==null){
            eduKeyword.setUpdateId(0l);
            eduKeyword.setCreateId(0l);
        }else {
            eduKeyword.setUpdateId(eduMemberToken.getId());
            eduKeyword.setCreateId(eduMemberToken.getId());
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
