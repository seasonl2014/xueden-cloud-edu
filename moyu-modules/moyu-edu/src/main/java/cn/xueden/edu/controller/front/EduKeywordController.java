package cn.xueden.edu.controller.front;

import cn.xueden.common.core.edu.domain.EduKeyword;
import cn.xueden.common.core.edu.vo.PageVO;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.edu.service.IEduKeywordService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**功能描述：关键词控制层
 * @Auther:梁志杰
 * @Date:2021/2/17
 * @Description:cn.xueden.edu.controller.front
 * @version:1.0
 */
@Api(tags = "前台课程详情接口")
@RestController
@RequestMapping("/edu/front/keyword")
public class EduKeywordController {

    @Autowired
    private IEduKeywordService eduKeywordService;

    @ApiOperation(value = "前台获取热门关键词", notes = "前台获取热门关键词")
    @PostMapping("/getKeyWord")
    public RestResponse getKeyWord() {
        QueryWrapper<EduKeyword> queryWrapper = new QueryWrapper<>();
        Page<EduKeyword> keywordPage = eduKeywordService.page(new Page<>(1,5),queryWrapper);
        return RestResponse.success().setData(keywordPage.getRecords()).setCode(200);

    }

    @ApiOperation(value = "前台获取热门关键词列表", notes = "前台获取热门关键词列表")
    @PostMapping("/getKeyWordList")
    public RestResponse getKeyWordList() {
        QueryWrapper<EduKeyword> queryWrapper = new QueryWrapper<>();
        Page<EduKeyword> keywordPage = eduKeywordService.page(new Page<>(1,8),queryWrapper);
        return RestResponse.success().setData(keywordPage.getRecords()).setCode(200);

    }
}
