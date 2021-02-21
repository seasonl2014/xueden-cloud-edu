package cn.xueden.edu.controller;

import cn.xueden.common.core.edu.domain.EduSubject;
import cn.xueden.common.core.edu.domain.EduVipType;
import cn.xueden.common.core.edu.domain.EduVipTypeSubject;
import cn.xueden.common.core.edu.vo.EduVipTypeVO;
import cn.xueden.common.core.utils.LayerData;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.common.log.annotation.XudenOtherSystemLog;
import cn.xueden.common.security.annotation.PreAuthorize;
import cn.xueden.edu.converter.EduVipTypeConverter;
import cn.xueden.edu.service.IEduSubjectService;
import cn.xueden.edu.service.IEduVipTypeService;
/*import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;*/
import cn.xueden.edu.service.IEduVipTypeSubjectService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**功能描述：会员类型控制层
 * @Auther:梁志杰
 * @Date:2021/1/31
 * @Description:cn.xueden.edu.controller
 * @version:1.0
 */
@Api(tags = "会员类型接口")
@RestController
@RequestMapping("/edu/viptype")
public class EduVipTypeController {

    @Autowired
    private IEduVipTypeService vipTypeService;

    @Autowired
    private IEduSubjectService subjectService;

    @Autowired
    private IEduVipTypeSubjectService eduVipTypeSubjectService;

    /**
     * 分页获取会员类型列表
     * @param page
     * @param limit
     * @param eduVipTypeVO
     * @return
     */
    @ApiOperation(value = "会员类型列表",notes = "会员类型列表，根据会员类型名称模糊查询")
    @GetMapping("/list")
    @XudenOtherSystemLog("获取会员分类列表数据")
    @PreAuthorize(hasPermi = "edu:viptype:list")
    public LayerData<EduVipTypeVO> findVipTypeList(@RequestParam(value = "pageNum",defaultValue = "1")Integer page,
                                                   @RequestParam(value = "pageSize",defaultValue = "15")Integer limit,
                                                   EduVipTypeVO eduVipTypeVO){
        LayerData<EduVipTypeVO> vipTypeLayerData = new LayerData<>();
        Page<EduVipTypeVO> userPage = vipTypeService.findVipTypeList(page,limit,eduVipTypeVO);
        vipTypeLayerData.setCount(userPage.getTotal());
        vipTypeLayerData.setData(userPage.getRecords());
        return vipTypeLayerData;

    }

    /**
     * 添加会员类型
     * @param eduVipTypeVO
     * @return
     */
    @ApiOperation(value = "添加会员类型")
    @XudenOtherSystemLog("添加会员类型数据")
    @PreAuthorize(hasPermi = "edu:viptype:add")
    @PostMapping("/add")
    public RestResponse add(@RequestBody @Validated EduVipType eduVipTypeVO){
        vipTypeService.save(eduVipTypeVO);
        return RestResponse.success();
    }

    /**
     * 编辑会员类型
     * @param id
     * @return
     */
    @ApiOperation(value = "编辑会员类型")
    @XudenOtherSystemLog("编辑会员类型数据")
    @PreAuthorize(hasPermi = "edu:viptype:edit")
    @GetMapping("/edit/{id}")
    public RestResponse edit(@PathVariable Long id){
        EduVipType eduVipTypeVO = vipTypeService.getById(id);
        return RestResponse.success().setData(eduVipTypeVO);
    }

    /**
     * 更新会员类型
     * @param id
     * @param eduVipTypeVO
     * @return
     */
    @ApiOperation(value = "更新会员类型")
    @XudenOtherSystemLog("更新会员类型数据")
    @PreAuthorize(hasPermi = "edu:viptype:update")
    @PutMapping("/update/{id}")
    public RestResponse update(@PathVariable Long id,
                               @RequestBody @Validated EduVipType eduVipTypeVO){
        eduVipTypeVO.setId(id);
        vipTypeService.updateById(eduVipTypeVO);
        return RestResponse.success();

    }

    /**
     * 删除会员类型
     * @param id
     * @return
     */
    @ApiOperation(value = "删除会员类型")
    @XudenOtherSystemLog("删除会员类型数据")
    @PreAuthorize(hasPermi = "edu:viptype:delete")
    @DeleteMapping("/delete/{id}")
    public RestResponse delete(@PathVariable Long id){
        vipTypeService.removeById(id);
        return RestResponse.success();
    }

    /**
     * 会员类型授权
     * @param id
     * @return
     */
    @ApiOperation(value = "会员类型授权")
    @XudenOtherSystemLog("会员类型授权")
    @PreAuthorize(hasPermi = "edu:viptype:assign")
    @GetMapping("/assign/{id}")
    public RestResponse assign(@PathVariable Long id){
        EduVipType eduVipType = vipTypeService.getById(id);

        // 获取所有课程类别列表
        QueryWrapper<EduSubject> queryWrapper = new QueryWrapper<EduSubject>();
        queryWrapper.eq("del_flag",false);
        queryWrapper.ne("parent_id",0);
        List<EduSubject> eduSubjectList = subjectService.list(queryWrapper);
        EduVipTypeVO eduVipTypeVO = EduVipTypeConverter.converterToEduVipTypeVO(eduVipType);
        eduVipTypeVO.setCourseTypeList(eduSubjectList);

        // 获取该会员类型已有的权益
        QueryWrapper<EduVipTypeSubject> EduVipTypeSubjectQueryWrapper =  new QueryWrapper<>();
        EduVipTypeSubjectQueryWrapper.eq("vip_id",id);
        List<EduVipTypeSubject> eduVipTypeSubjectList = eduVipTypeSubjectService.list(EduVipTypeSubjectQueryWrapper);
        Set<Long> subjectIds = new HashSet<>();
        if(!CollectionUtils.isEmpty(eduVipTypeSubjectList)){
            for(EduVipTypeSubject vipTypeSubject:eduVipTypeSubjectList){
                subjectIds.add(vipTypeSubject.getSubjectId());
            }
        }
        eduVipTypeVO.setCourseTypeSets(subjectIds);
        return RestResponse.success().setData(eduVipTypeVO);
    }
    /**
     * 分配权益
     * @param id
     * @param eduVipTypeVO
     * @return
     */
    @ApiOperation(value = "分配会员类型权益",notes = "把权益分配给会员类型，一个或者多个")
    @PreAuthorize(hasPermi = "edu:viptype:assign")
    @XudenOtherSystemLog("分配会员类型权益")
    @PutMapping("/{id}/assignVipType")
    public RestResponse assignVipType(@PathVariable Long id ,@RequestBody EduVipTypeVO eduVipTypeVO){
        System.out.println("eduVipTypeVO:"+eduVipTypeVO);
        if(eduVipTypeVO!=null&&eduVipTypeVO.getCourseTypeSets().size()>0){
            vipTypeService.assignVipType(id,eduVipTypeVO.getCourseTypeSets());

        }else{
            return RestResponse.failure("分配权益失败");
        }

        return RestResponse.success();
    }


}
