package cn.xueden.edu.controller.teacher;

import cn.xueden.common.core.edu.domain.EduIncomeDetails;
import cn.xueden.common.core.edu.vo.EduIncomeDetailsVO;
import cn.xueden.common.core.edu.vo.EduMemberVO;
import cn.xueden.common.core.utils.LayerData;
import cn.xueden.common.log.annotation.XudenOtherSystemLog;
import cn.xueden.common.security.service.TokenService;
import cn.xueden.edu.converter.EduIncomeDetailsConverter;
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

/**功能描述：讲师收益明细控制层
 * @Auther:梁志杰
 * @Date:2021/5/26
 * @Description:cn.xueden.edu.controller.teacher
 * @version:1.0
 */
@Api(tags = "讲师我的收益明细接口")
@RestController
@RequestMapping("/edu/teacher/income")
public class EduTeacherIncomeDetailsController {

    @Autowired
    private IEduCourseService educourseService;

    @Autowired
    private IEduIncomeDetailsService eduIncomeDetailsService;

    @Autowired
    private TokenService tokenService;

    /**
     * 分页获取讲师收益列表
     * @param page
     * @param limit
     * @param eduIncomeDetailsVO
     * @return
     */
    @ApiOperation(value = "分页获取讲师收益列表",notes = "分页获取讲师收益列表")
    @GetMapping("/list")
    @XudenOtherSystemLog("分页获取讲师收益列表")
    public LayerData<EduIncomeDetailsVO> list(@RequestParam(value = "pageIndex",defaultValue = "1")Integer page,
                                              @RequestParam(value = "pageSize",defaultValue = "10")Integer limit,
                                              EduIncomeDetailsVO eduIncomeDetailsVO, HttpServletRequest request){

        String token = request.getHeader("Authorization");
        if(token==null||token.equals("null")){
            return null;
        }

        //根据token,获取登录会员信息
        EduMemberVO eduMemberVO = tokenService.getLoginMember();
        if(eduMemberVO==null){
            return null;
        }

        LayerData<EduIncomeDetailsVO> detailsVOLayerData = new LayerData<>();
        QueryWrapper<EduIncomeDetails> eduIncomeDetailsQueryWrapper = new QueryWrapper();
        if(eduIncomeDetailsVO!=null&&eduIncomeDetailsVO.getOrderNo()!=null){
            eduIncomeDetailsQueryWrapper.like("order_no",eduIncomeDetailsVO.getOrderNo());
        }

        eduIncomeDetailsQueryWrapper.eq("teacher_id",eduMemberVO.getTeacherId());

        Page<EduIncomeDetails> userPage = eduIncomeDetailsService.page(new Page<>(page,limit),eduIncomeDetailsQueryWrapper);
        detailsVOLayerData.setCount(userPage.getTotal());
        detailsVOLayerData.setData(EduIncomeDetailsConverter.converterToVOList(userPage.getRecords(),educourseService));
        return detailsVOLayerData;
    }

}
