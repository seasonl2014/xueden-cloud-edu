package cn.xueden.edu.controller.teacher;

import cn.xueden.common.core.edu.domain.EduCashOutDetails;
import cn.xueden.common.core.edu.domain.EduIncomeDetails;
import cn.xueden.common.core.edu.vo.EduCashOutDetailsVO;
import cn.xueden.common.core.edu.vo.EduIncomeDetailsVO;
import cn.xueden.common.core.edu.vo.EduMemberVO;
import cn.xueden.common.core.utils.LayerData;
import cn.xueden.common.log.annotation.XudenOtherSystemLog;
import cn.xueden.common.security.service.TokenService;
import cn.xueden.edu.converter.EduIncomeDetailsConverter;
import cn.xueden.edu.service.IEduCashOutDetailsService;
import cn.xueden.edu.service.IEduCourseService;
import cn.xueden.edu.service.IEduIncomeDetailsService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

/**功能描述：讲师提现明细控制层
 * @Auther:梁志杰
 * @Date:2021/5/28
 * @Description:cn.xueden.edu.controller.teacher
 * @version:1.0
 */
@Api(tags = "讲师我的收益明细接口")
@RestController
@RequestMapping("/edu/teacher/cashout")
public class EduTeacherCashOutDetailsController {

    @Autowired
    private IEduCashOutDetailsService eduCashOutDetailsService;

    @Autowired
    private TokenService tokenService;

    /**
     * 分页获取讲师提现列表
     * @param page
     * @param limit
     * @param eduCashOutDetailsVO
     * @return
     */
    @ApiOperation(value = "分页获取讲师提现列表",notes = "分页获取讲师提现列表")
    @GetMapping("/list")
    @XudenOtherSystemLog("分页获取讲师提现列表")
    public LayerData<EduCashOutDetails> list(@RequestParam(value = "page",defaultValue = "1")Integer page,
                                              @RequestParam(value = "limit",defaultValue = "15")Integer limit,
                                              EduCashOutDetailsVO eduCashOutDetailsVO, HttpServletRequest request){

        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return null;
        }

        //根据token,获取登录会员信息
        EduMemberVO eduMemberVO = tokenService.getLoginMember();
        if(eduMemberVO==null){
            return null;
        }

        LayerData<EduCashOutDetails> detailsVOLayerData = new LayerData<>();
        QueryWrapper<EduCashOutDetails> eduCashOutDetailsQueryWrapper = new QueryWrapper();
        if(eduCashOutDetailsVO!=null&&eduCashOutDetailsVO.getBankCard()!=null){
            eduCashOutDetailsQueryWrapper.like("bank_card",eduCashOutDetailsVO.getBankCard());
        }

        eduCashOutDetailsQueryWrapper.eq("teacher_id",eduMemberVO.getTeacherId());

        Page<EduCashOutDetails> userPage = eduCashOutDetailsService.page(new Page<>(page,limit),eduCashOutDetailsQueryWrapper);
        detailsVOLayerData.setCount(userPage.getTotal());
        detailsVOLayerData.setData(userPage.getRecords());
        return detailsVOLayerData;
    }

}
