package cn.xueden.edu.controller;

import cn.xueden.common.core.edu.domain.EduVideo;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.common.log.annotation.XudenOtherSystemLog;
import cn.xueden.common.security.annotation.PreAuthorize;
import cn.xueden.edu.service.IEduVideoService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**功能描述：课程小节控制层
 * @Auther:梁志杰
 * @Date:2021/1/26
 * @Description:cn.xueden.edu.controller
 * @version:1.0
 */
@Api(tags = "课程大纲小节接口")
@RestController
@RequestMapping("/edu/video")
public class EduVideoController {

    @Autowired
    private IEduVideoService eduVideoService;

    /**
     * 添加课程小节
     * @return
     */
    @ApiOperation(value = "添加课程小节")
    @XudenOtherSystemLog("课程小节资料添加")
    @PreAuthorize(hasPermi = "edu:video:add")
    @PostMapping("/add")
    public RestResponse add(@RequestBody @Validated EduVideo eduVideoVO) {
        eduVideoService.insert(eduVideoVO);
        return RestResponse.success();
    }

    /**
     * 编辑课程课时
     * @param id
     * @return
     */
    @ApiOperation(value = "编辑课程课时", notes = "编辑课程课时信息")
    @XudenOtherSystemLog("编辑课程课时信息")
    @PreAuthorize(hasPermi = "edu:video:edit")
    @GetMapping("/edit/{id}")
    public RestResponse edit(@PathVariable Long id) {
        EduVideo eduVideoVO = eduVideoService.selectById(id);
        return RestResponse.success().setData(eduVideoVO);
    }

    /**
     * 更新课程小节
     *
     * @return
     */
    @ApiOperation(value = "更新课时", notes = "更新课时信息")
    @XudenOtherSystemLog("课时更新")
    @PreAuthorize(hasPermi = "edu:video:update")
    @PutMapping("/update/{id}")
    public RestResponse update(@PathVariable Long id, @RequestBody EduVideo eduVideoVO) {
        eduVideoVO.setId(id);
        eduVideoService.updateById(eduVideoVO);
        return RestResponse.success();
    }

    /**
     * 删除课时
     * @param id
     * @return
     */
    @ApiOperation(value = "删除课时", notes = "删除课时信息")
    @XudenOtherSystemLog("课时删除")
    @PreAuthorize(hasPermi = "edu:video:delete")
    @DeleteMapping("/delete/{id}")
    public RestResponse delete(@PathVariable Long id) {
        eduVideoService.deleteById(id);
        return RestResponse.success();
    }

}
