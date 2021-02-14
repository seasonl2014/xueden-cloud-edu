package cn.xueden.edu.controller;

import cn.xueden.common.core.domain.R;
import cn.xueden.common.core.edu.domain.EduMember;
import cn.xueden.common.core.edu.domain.EduVipType;
import cn.xueden.common.core.edu.vo.EduMemberVO;
import cn.xueden.common.core.utils.LayerData;
import cn.xueden.common.core.utils.RestResponse;
import cn.xueden.common.log.annotation.XudenOtherSystemLog;
import cn.xueden.common.security.annotation.PreAuthorize;
import cn.xueden.common.security.service.TokenService;
import cn.xueden.edu.converter.EduMemberConverter;
import cn.xueden.edu.dao.EduVipTypeDao;
import cn.xueden.edu.service.IEduMemberService;
/*import com.baomidou.mybatisplus.mapper.EntityWrapper;*/
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**功能描述：会员模块控制层
 * @Auther:梁志杰
 * @Date:2021/1/30
 * @Description:cn.xueden.edu.controller
 * @version:1.0
 */
@Api(tags = "会员接口")
@RestController
@RequestMapping("/edu/member")
public class EduMemberController {

    @Autowired
    private IEduMemberService eduMemberService;

    @Autowired
    protected TokenService tokenService;

    @Autowired
    private EduVipTypeDao eduVipTypeDao;

    /**
     * 分页获取会员列表
     * @param page
     * @param limit
     * @param eduTeacherVO
     * @return
     */
    @ApiOperation(value = "会员列表",notes = "会员列表，根据会员名称模糊查询")
    @GetMapping("/list")
    @XudenOtherSystemLog("获取会员列表数据")
    @PreAuthorize(hasPermi = "edu:member:list")
    public LayerData<EduMemberVO> list(@RequestParam(value = "page",defaultValue = "1")Integer page,
                                     @RequestParam(value = "limit",defaultValue = "15")Integer limit,
                                     EduMemberVO eduTeacherVO){
        LayerData<EduMemberVO> MemberLayerData = new LayerData<>();
        QueryWrapper<EduMember> memberEntityWrapper = new QueryWrapper();
        if(eduTeacherVO!=null&&eduTeacherVO.getNickname()!=null){
            memberEntityWrapper.like("nickname",eduTeacherVO.getNickname());
        }

        if(eduTeacherVO!=null&&eduTeacherVO.getMobile()!=null){
            memberEntityWrapper.like("mobile",eduTeacherVO.getMobile());
        }

        Page<EduMember> userPage = eduMemberService.page(new Page<>(page,limit),memberEntityWrapper);
        MemberLayerData.setCount(userPage.getTotal());
        MemberLayerData.setData(EduMemberConverter.converterToEduMemberVOList(userPage.getRecords(),eduVipTypeDao));
        return MemberLayerData;
    }

    /**
     * 删除会员类型
     * @param id
     * @return
     */
    @ApiOperation(value = "删除会员")
    @XudenOtherSystemLog("删除会员数据")
    @PreAuthorize(hasPermi = "edu:member:delete")
    @DeleteMapping("/delete/{id}")
    public RestResponse delete(@PathVariable Long id){
        eduMemberService.removeById(id);
        return RestResponse.success();
    }


    /**
     * 根据会员手机号获取会员信息,主要用于微服务之间的调用
     */
    @GetMapping("/info/{mobile}")
    public R<EduMemberVO> info(@PathVariable("mobile") String mobile){
        EduMemberVO eduMemberVO = new EduMemberVO();
        QueryWrapper<EduMember> eduMemberEntityWrapper = new QueryWrapper();
        eduMemberEntityWrapper.eq("mobile",mobile);
        EduMember eduMember = eduMemberService.getOne(eduMemberEntityWrapper);
        EduVipType dbEduVipType = eduVipTypeDao.selectById(eduMember.getVipId());
        eduMemberVO = EduMemberConverter.converterToEduMemberVO(eduMember);
        if(dbEduVipType!=null){
            eduMemberVO.setVipType(dbEduVipType.getName());
        }
        return R.ok(eduMemberVO);
    }

    /**
     * 功能描述：获取当前登录会员信息
     * @return
     */
    @PostMapping("getLoginMember")
    public RestResponse getLoginMember(){
        EduMemberVO eduMemberVO = tokenService.getLoginMember();
        return RestResponse.success().setData(eduMemberVO);
    }
}
