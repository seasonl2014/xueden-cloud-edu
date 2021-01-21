package cn.xueden.edu.controller;

import cn.xueden.common.core.edu.vo.EduSubjectTreeNodeVO;
import cn.xueden.common.core.edu.vo.EduSubjectVO;
import cn.xueden.common.core.edu.vo.PageVO;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.common.log.annotation.XudenOtherSystemLog;
import cn.xueden.common.log.annotation.XudenSysLog;
import cn.xueden.common.security.annotation.PreAuthorize;
import cn.xueden.edu.service.IEduSubjectService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**功能描述： 课程分类控制层
 * @Auther:梁志杰
 * @Date:2021/1/19
 * @Description:cn.xueden.edu.controller
 * @version:1.0
 */
@Api(tags = "课程类别接口")
@RestController
@RequestMapping("/edu/subject")
public class EduSubjectController {

    @Autowired
    private IEduSubjectService eduSubjectService;

    /**
     * 分类树形结构(分页)
     *
     * @return
     */
    @ApiOperation(value = "分类树形结构")
    @GetMapping("/categoryTree")
    public RestResponse categoryTree(@RequestParam(value = "pageNum", required = false) Integer pageNum,
                                     @RequestParam(value = "pageSize", required = false) Integer pageSize) {
        PageVO<EduSubjectTreeNodeVO> pageVO = eduSubjectService.categoryTree(pageNum, pageSize);
        return RestResponse.success().setData(pageVO);
    }

    /**
     * 获取父级分类树：2级树
     *
     * @return
     */
    @ApiOperation(value = "父级分类树")
    @GetMapping("/getParentEduSubjectTreeNode")
    public RestResponse getParentEduSubjectTreeNode() {
        List<EduSubjectTreeNodeVO> parentTree = eduSubjectService.getParentEduSubjectTree();
        return RestResponse.success().setData(parentTree);
    }


    /**
     * 添加课程分类
     *
     * @return
     */
    @XudenOtherSystemLog("课程分类添加")
    @PreAuthorize(hasPermi = "edu:subject:add")
    @ApiOperation(value = "添加分类")
    @PostMapping("/add")
    public RestResponse add(@RequestBody @Validated EduSubjectVO eduSubjectVO) {
        eduSubjectService.add(eduSubjectVO);
        return RestResponse.success();
    }

    /**
     * 删除课程分类
     *
     * @param id
     * @return
     */
    @XudenOtherSystemLog("课程分类删除")
    @ApiOperation(value = "删除分类")
    @PreAuthorize(hasPermi = "edu:subject:delete")
    @DeleteMapping("/delete/{id}")
    public RestResponse delete(@PathVariable Long id) {
      boolean state =  eduSubjectService.delete(id);
      if(state){
          return RestResponse.success();
      }else {
          return RestResponse.failure("删除失败！");
      }

    }

    /**
     * 编辑课程分类
     *
     * @param id
     * @return
     */
    @XudenOtherSystemLog("编辑课程分类")
    @ApiOperation(value = "编辑分类")
    @PreAuthorize(hasPermi = "edu:subject:edit")
    @GetMapping("/edit/{id}")
    public RestResponse edit(@PathVariable Long id) {
        EduSubjectVO eduSubjectVO = eduSubjectService.edit(id);
        return RestResponse.success().setData(eduSubjectVO);
    }

    /**
     * 更新课程分类
     *
     * @return
     */
    @ApiOperation(value = "更新分类")
    @XudenOtherSystemLog("课程分类更新")
    @PreAuthorize(hasPermi = "edu:subject:update")
    @PutMapping("/update/{id}")
    public RestResponse update(@PathVariable Long id, @RequestBody @Validated EduSubjectVO eduSubjectVO) {
        eduSubjectService.update(id, eduSubjectVO);
        return RestResponse.success();
    }

}
