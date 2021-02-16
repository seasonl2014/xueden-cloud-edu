package cn.xueden.edu.service.impl;

import cn.xueden.common.core.edu.domain.*;

import cn.xueden.common.core.edu.vo.EduCourseVO;
import cn.xueden.common.core.edu.vo.EduMemberVO;
import cn.xueden.common.core.utils.AddressUtil;
import cn.xueden.common.core.utils.IdUtils;
import cn.xueden.common.security.service.TokenService;
import cn.xueden.edu.converter.EduCourseConverter;
import cn.xueden.edu.dao.*;
import cn.xueden.edu.service.IEduCourseService;
/*import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;*/
import cn.xueden.search.domain.CourseESItem;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.elasticsearch.index.query.QueryBuilders;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.elasticsearch.core.query.NativeSearchQueryBuilder;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;

/**课程 服务实现类
 * @Auther:梁志杰
 * @Date:2021/1/23
 * @Description:cn.xueden.edu.service.impl
 * @version:1.0
 */
@Service
public class EduCourseServiceImpl extends ServiceImpl<EduCourseDao, EduCourse> implements IEduCourseService {



    @Autowired
    private EduCourseDao eduCourseDao;

    @Autowired
    private TokenService tokenService ;

    @Autowired
    private EduMemberDao eduMemberDao;

    @Autowired
    private EduMemberBuyCourseDao eduMemberBuyCourseDao;

    @Autowired
    private EduVipTypeSubjectDao eduVipTypeSubjectDao;

    @Autowired
    private EduCourseElasticsearchDao eduCourseElasticsearchDao;

    /**
     * 获取课程信息
     * @param id
     * @return
     */
    @Override
    public EduCourseVO getVoById(Long id) {
        EduCourse eduCourse = eduCourseDao.selectById(id);
        return EduCourseConverter.converterToCourseVO(eduCourse);
    }

    /**
     * 前台首页获取课程列表
     * @param pageNum
     * @param pageSize
     * @param eduCourseVO
     * @return
     */
    @Override
    public List<EduCourseVO> findIndexCourseList(Integer pageNum, Integer pageSize, EduCourseVO eduCourseVO) {

        List<EduCourse> eduCourses = new ArrayList<EduCourse>();
        QueryWrapper<EduCourse> eduCourseEntityWrapper = new QueryWrapper();
        if (eduCourseVO.getCourseType() != null) {
            eduCourseEntityWrapper.eq("course_type",eduCourseVO.getCourseType());
        }
        // 获取已发布的课程
        eduCourseEntityWrapper.eq("status","Normal");
        eduCourses = eduCourseDao.selectList(eduCourseEntityWrapper);
        List<EduCourseVO> eduCourseVOList= EduCourseConverter.converterToVOList(eduCourses);
        return eduCourseVOList;
    }

    /**
     * 更新课程查看次数
     * @param eduCourseVO
     */
    @Override
    public void updateViewCount(EduCourseVO eduCourseVO) {
        eduCourseVO.setViewCount(eduCourseVO.getViewCount()+1);
        EduCourse eduCourse = new EduCourse();
        BeanUtils.copyProperties(eduCourseVO,eduCourse);
        eduCourse.setUpdateId(1l);
        eduCourseDao.updateById(eduCourse);
    }

    /**
     * 购买课程
     * @param id
     * @param token
     * @param ipAddress
     * @return
     */
    @Override
    public EduMemberBuyCourse buy(Long id, String token, String ipAddress) {

        // 根据IP地址获取地理位置
        String cityAddress = AddressUtil.getCityInfo(ipAddress);


        //根据token,获取登录会员信息
        EduMemberVO eduMemberVO = tokenService.getLoginMember();

        if(eduMemberVO==null){
            return null;
        }

        // 根据手机号获取用户信息
        QueryWrapper<EduMember> memberQueryWrapper = new QueryWrapper();
        memberQueryWrapper.eq("mobile",eduMemberVO.getMobile());
        EduMember dbMember =  eduMemberDao.selectOne(memberQueryWrapper);
        if(dbMember==null){
            return null;
        }

        // 获取课程信息
        EduCourse dbEduCourse = eduCourseDao.selectById(id);
        if(dbEduCourse==null){
            return null;
        }

        //判断用户是否已经购买过该课程
        QueryWrapper<EduMemberBuyCourse> memberBuyCourseQueryWrapper = new QueryWrapper();
        memberBuyCourseQueryWrapper.eq("course_id",dbEduCourse.getId());
        memberBuyCourseQueryWrapper.eq("member_id",dbMember.getId());
        EduMemberBuyCourse dbEduMemberBuyCourse = eduMemberBuyCourseDao.selectOne(memberBuyCourseQueryWrapper);
        if(dbEduMemberBuyCourse!=null){//已经购买过该课程，直接返回信息
            return dbEduMemberBuyCourse;
        }

        // 生成订单编号
        String orderNo= IdUtils.createOrderNumber();
        // 会员购买课程记录表
        EduMemberBuyCourse tempEduMemberBuyCourse = new EduMemberBuyCourse();
        tempEduMemberBuyCourse.setBuyType(dbMember.getVipId());
        tempEduMemberBuyCourse.setCourseId(id);
        tempEduMemberBuyCourse.setCreateDate(new Date());
        tempEduMemberBuyCourse.setMemberId(dbMember.getId()); // 会员ID
        tempEduMemberBuyCourse.setOrderNo(orderNo);
        tempEduMemberBuyCourse.setPrice(dbEduCourse.getPrice());
        tempEduMemberBuyCourse.setPayChannel("wxpay"); //微信支付
        tempEduMemberBuyCourse.setRemarks("会员购买【"+dbEduCourse.getTitle()+"】课程");
        tempEduMemberBuyCourse.setCreateId(dbMember.getId());
        tempEduMemberBuyCourse.setUpdateId(dbMember.getId());

        if(cityAddress!=null&&!cityAddress.equals("内网IP")){
            String addressInfo[] = cityAddress.split("\\|");
            tempEduMemberBuyCourse.setCountry(addressInfo[0]);//国家或地区
            tempEduMemberBuyCourse.setArea(addressInfo[1]=="0"?"未知":addressInfo[1]); //区域
            tempEduMemberBuyCourse.setProvince(addressInfo[2].replace("省",""));// 省份
            tempEduMemberBuyCourse.setCity(addressInfo[3]=="0"?"未知":addressInfo[3]); //城市
            tempEduMemberBuyCourse.setIsp(addressInfo[4]);//网络服务提供商
        }

        // 根据会员类型获取相应的免费板块(即该会员类型所免费的课程类别)
        QueryWrapper<EduVipTypeSubject> tempEduVipTypeSubject = new QueryWrapper();
        tempEduVipTypeSubject.eq("vip_id",dbMember.getVipId());
        List<EduVipTypeSubject> eduVipTypeSubjectList = eduVipTypeSubjectDao.selectList(tempEduVipTypeSubject);

        // 课程栏目ID
        Set<Long> subjectSet = new HashSet<Long>();

        if(eduVipTypeSubjectList!=null&&eduVipTypeSubjectList.size()>0){ // 有相应的免费板块
            for (EduVipTypeSubject ep:eduVipTypeSubjectList){
                subjectSet.add(ep.getSubjectId());
            }

            // 会员免费购买
            if(subjectSet.contains(dbEduCourse.getSubjectId())||subjectSet.contains(dbEduCourse.getSubjectParentId())){
                tempEduMemberBuyCourse.setIsPayment(1);// 已付款
                tempEduMemberBuyCourse.setPrice(BigDecimal.valueOf(0));
                eduMemberBuyCourseDao.insert(tempEduMemberBuyCourse);
                return tempEduMemberBuyCourse;
            }else{
                tempEduMemberBuyCourse.setIsPayment(0);// 未付款
                eduMemberBuyCourseDao.insert(tempEduMemberBuyCourse);
            }


        }else { // 无相应的免费板块

            tempEduMemberBuyCourse.setIsPayment(0);// 未付款
            eduMemberBuyCourseDao.insert(tempEduMemberBuyCourse);
        }



        return tempEduMemberBuyCourse;
    }

    /**
     * 编辑课程
     * @param courseId
     * @return
     */
    @Override
    public EduCourseVO edit(Long courseId) {
        EduCourse eduCourse = eduCourseDao.selectById(courseId);
        return EduCourseConverter.converterToCourseVO(eduCourse);
    }

    /**
     * 更新课程购买数量
     * @param courseId
     */
    @Override
    public void updateBuyCount(Long courseId) {
        // 获取课程信息
        EduCourse dbEduCourse = eduCourseDao.selectById(courseId);
        if(dbEduCourse!=null){
            dbEduCourse.setBuyCount(dbEduCourse.getBuyCount()+1);
            eduCourseDao.updateById(dbEduCourse);
        }
    }

    /**
     * 快速查询课程
     * @param key
     * @return
     */
    @Override
    public List<CourseESItem> getQuickSearch(String key) {

        // 构建查询条件
        NativeSearchQueryBuilder searchQueryBuilder = new NativeSearchQueryBuilder();
        // 添加基本查询条件
        searchQueryBuilder.withQuery(QueryBuilders.matchQuery("title", key));
        // 初始化分页参数
        int page = 0;
        int size = 5;
        // 设置分页参数
        searchQueryBuilder.withPageable(PageRequest.of(page, size));
        Page<CourseESItem> searchs = eduCourseElasticsearchDao.search(searchQueryBuilder.build());
        List<CourseESItem> esItems = searchs.getContent();

        return esItems;
    }
}
