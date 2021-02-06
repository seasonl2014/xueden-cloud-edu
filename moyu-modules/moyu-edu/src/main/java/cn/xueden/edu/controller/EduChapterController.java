package cn.xueden.edu.controller;

import cn.xueden.common.core.edu.domain.EduChapter;
import cn.xueden.common.core.edu.vo.EduChapterTreeNodeVO;
import cn.xueden.common.core.edu.vo.EduChapterVO;
import cn.xueden.common.core.edu.vo.PageVO;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.common.log.annotation.XudenOtherSystemLog;
import cn.xueden.common.security.annotation.PreAuthorize;
import cn.xueden.edu.service.IEduChapterService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**功能描述：课程大章管理模块控制层
 * @Auther:梁志杰
 * @Date:2021/1/24
 * @Description:cn.xueden.edu.controller
 * @version:1.0
 */
@Api(tags = "课程大章大章接口")
@RestController
@RequestMapping("/edu/chapter")
public class EduChapterController {

    @Autowired
    private IEduChapterService chapterService;

    /**
     * 章节树形结构(分页)
     *
     * @return
     */
    @ApiOperation(value = "章节树形结构")
    @GetMapping("/chapterTree")
    public RestResponse chapterTree(@RequestParam(value = "page", required = false,defaultValue = "1") Integer pageNum,
                                    @RequestParam(value = "pageSize", required = false,defaultValue = "5") Integer pageSize,
                                    EduChapterVO eduChapterVO) {
        if(eduChapterVO==null){
            return RestResponse.failure("获取章节失败");
        }else{
            if(eduChapterVO.getCourseId()==null){
                return RestResponse.failure("获取章节失败");
            }
        }
        PageVO<EduChapterTreeNodeVO> pageVO = chapterService.chapterTree(pageNum, pageSize,eduChapterVO);
        return RestResponse.success().setData(pageVO);
    }

    /**
     * 添加课程大章
     * @return
     */
    @ApiOperation(value = "添加课程大章")
    @XudenOtherSystemLog("课程大章资料添加")
    @PreAuthorize(hasPermi = "edu:chapter:add")
    @PostMapping("/add")
    public RestResponse add(@RequestBody @Validated EduChapter eduChapterVO) {
        chapterService.save(eduChapterVO);
        return RestResponse.success();
    }

    /**
     * 编辑课程大章
     * @param id
     * @return
     */
    @ApiOperation(value = "编辑课程大章", notes = "编辑课程大章信息")
    @PreAuthorize(hasPermi = "edu:chapter:edit")
    @GetMapping("/edit/{id}")
    public RestResponse edit(@PathVariable Long id) {
        EduChapter eduChapterVO = chapterService.getById(id);
        return RestResponse.success().setData(eduChapterVO);
    }

    /**
     * 更新课程大章
     *
     * @return
     */
    @ApiOperation(value = "更新课程大章", notes = "更新课程大章信息")
    @PreAuthorize(hasPermi = "edu:chapter:update")
    @XudenOtherSystemLog("课程大章资料更新")
    @PutMapping("/update/{id}")
    public RestResponse update(@PathVariable Long id, @RequestBody EduChapter eduChapterVO) {
        eduChapterVO.setId(id);
        chapterService.updateById(eduChapterVO);
        return RestResponse.success();
    }

    /**
     * 删除课程大章
     * @param id
     * @return
     */
    @ApiOperation(value = "删除课程大章", notes = "删除课程大章信息")
    @PreAuthorize(hasPermi = "edu:chapter:delete")
    @XudenOtherSystemLog("课程大章删除")
    @DeleteMapping("/delete/{id}")
    public RestResponse delete(@PathVariable Long id) {
        chapterService.removeById(id);
        return RestResponse.success();
    }



}
