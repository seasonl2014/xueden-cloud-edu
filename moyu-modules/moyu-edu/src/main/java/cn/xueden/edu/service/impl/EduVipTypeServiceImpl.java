package cn.xueden.edu.service.impl;

import cn.xueden.common.core.edu.domain.*;
import cn.xueden.common.core.edu.vo.EduMemberVO;
import cn.xueden.common.core.edu.vo.EduVipTypeSubjectVO;
import cn.xueden.common.core.edu.vo.EduVipTypeVO;
import cn.xueden.common.core.exception.CustomException;
import cn.xueden.common.core.utils.AddressUtil;
import cn.xueden.common.core.utils.IdUtils;
import cn.xueden.common.core.utils.JWTUtils;
import cn.xueden.common.security.service.TokenService;
import cn.xueden.edu.converter.EduVipTypeConverter;
import cn.xueden.edu.dao.*;
import cn.xueden.edu.service.IEduVipTypeService;
/*import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.SqlHelper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;*/
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.baomidou.mybatisplus.extension.toolkit.SqlHelper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

/**
 * @Auther:梁志杰
 * @Date:2021/1/31
 * @Description:cn.xueden.edu.service.impl
 * @version:1.0
 */
@Service
public class EduVipTypeServiceImpl extends ServiceImpl<EduVipTypeDao, EduVipType> implements IEduVipTypeService {

    @Autowired
    private EduVipTypeDao eduVipTypeDao;

    @Autowired
    private EduVipTypeSubjectDao eduVipTypeSubjectDao;

    @Autowired
    private EduSubjectDao eduSubjectDao;

    @Autowired
    private EduMemberDao eduMemberDao;

    @Autowired
    private EduMemberBuyVipDao eduMemberBuyVipDao;

    @Autowired
    private TokenService tokenService;

    /**
     * 分页获取会员分类列表
     * @param page
     * @param limit
     * @param eduVipTypeVO
     * @return
     */
    @Override
    @Cacheable(value = "eduVipTypeCache",key = "#eduVipTypeVO.name",unless = "#result == null or #result.total == 0")
    public Page<EduVipTypeVO> findVipTypeList(Integer page,Integer limit, EduVipTypeVO eduVipTypeVO) {
        QueryWrapper<EduVipType> entityWrapper = new QueryWrapper();
        entityWrapper.orderByDesc("create_date");
        if(StringUtils.isNotBlank(eduVipTypeVO.getName())){
            entityWrapper.like("name",eduVipTypeVO.getName());
        }

        Page<EduVipType> dbVipTypePage=eduVipTypeDao.selectPage(new Page<>(page,limit),entityWrapper);

        //转VO
        List<EduVipTypeVO> eduVipTypeVOS = new ArrayList<>();
        for (EduVipType eduVipType:dbVipTypePage.getRecords()){
            EduVipTypeVO d = new EduVipTypeVO();
            BeanUtils.copyProperties(eduVipType,d);
            QueryWrapper<EduMember> memberEntityWrapper = new QueryWrapper();
            memberEntityWrapper.eq("vip_id",eduVipType.getId());
            d.setMemberTotal(eduMemberDao.selectCount(memberEntityWrapper));
            eduVipTypeVOS.add(d);
        }
        Page<EduVipTypeVO> eduVipTypePage = new Page<>();
        eduVipTypePage.setRecords(eduVipTypeVOS);
        eduVipTypePage.setTotal(dbVipTypePage.getTotal());
        return eduVipTypePage;
    }

    /**
     * 获取所有会员类型
     * @return
     */
    @Override
    @Cacheable(value = "allEduVipTypeCache",unless = "#result == null or #result.size() == 0")
    public List<EduVipTypeVO> getAllVip() {
        QueryWrapper<EduVipType> eduVipTypeEntityWrapper = new QueryWrapper();
        eduVipTypeEntityWrapper.eq("del_flag",false);
        List<EduVipType> eduVipTypes= eduVipTypeDao.selectList(eduVipTypeEntityWrapper);
        return EduVipTypeConverter.converterToVOList(eduVipTypes);
    }

    /**
     * 根据会员类型ID获取该会员类型下的权益
     * @param vipId
     * @return
     */
    @Override
    public List<EduVipTypeSubjectVO> getVipSubject(Long vipId) {

        QueryWrapper<EduVipTypeSubject> eduVipTypeEntityWrapper = new QueryWrapper();
        eduVipTypeEntityWrapper.eq("vip_id",vipId);

        List<EduVipTypeSubject> eduVipTypeSubjectList = eduVipTypeSubjectDao.selectList(eduVipTypeEntityWrapper);
        List<EduVipTypeSubjectVO> list = EduVipTypeConverter.converterTypeSubjectVOToVOList(eduVipTypeSubjectList);
        for(EduVipTypeSubjectVO eduVipTypeSubjectVO:list){
            EduSubject eduSubject = eduSubjectDao.selectById(eduVipTypeSubjectVO.getSubjectId());
            if(eduSubject!=null){
                eduVipTypeSubjectVO.setSubjectName(eduSubject.getName());

            }

        }
        return list;
    }

    /**
     * 用户加入VIP会员
     * @param id
     * @param token
     * @param ipAddress
     * @return
     */
    @Override
    public EduMemberBuyVip addVip(Long id, String token, String ipAddress) {
        // 根据IP地址获取地理位置
        String cityAddress = AddressUtil.getCityInfo(ipAddress);

        //根据token,获取登录会员信息
        EduMemberVO eduMemberVO = tokenService.getLoginMember();
        if(eduMemberVO==null){
            return null;
        }
        String mobile = eduMemberVO.getMobile();
        if(mobile==null){
            return null;
        }

        // 根据手机号获取用户信息
        QueryWrapper<EduMember> memberWrapper = new QueryWrapper<>();
        memberWrapper.eq("mobile",mobile);
        EduMember dbMember =  eduMemberDao.selectOne(memberWrapper);
        if(dbMember==null){
            return null;
        }

        // 获取会员类型信息
        EduVipType dbEduVipType = eduVipTypeDao.selectById(id);
        if(dbEduVipType==null){
            return null;
        }


        //判断用户是否已经购买过该会员类型
        QueryWrapper<EduMemberBuyVip> eduMemberBuyVipEntityWrapper = new QueryWrapper();
        eduMemberBuyVipEntityWrapper.eq("vip_id",id);
        eduMemberBuyVipEntityWrapper.eq("member_id",dbMember.getId());

        EduMemberBuyVip dbEduMemberBuyVip = eduMemberBuyVipDao.selectOne(eduMemberBuyVipEntityWrapper);
        if(dbEduMemberBuyVip!=null){//已经购买过该VIP，直接返回信息
            return dbEduMemberBuyVip;
        }

        // 获取用户原来的会员类型，如果是升级会员，那么补差价即可
        EduVipType memberEduVipType= eduVipTypeDao.selectById(dbMember.getVipId());
        double price = dbEduVipType.getVipMoney()-memberEduVipType.getVipMoney();

        // 生成订单编号
        String orderNo= IdUtils.createOrderNumber();
        EduMemberBuyVip tempEduMemberBuyVip = new EduMemberBuyVip();
        tempEduMemberBuyVip.setIsPayment(0);
        tempEduMemberBuyVip.setMemberId(dbMember.getId());
        tempEduMemberBuyVip.setCreateDate(new Date());
        tempEduMemberBuyVip.setOrderNo(orderNo);
        tempEduMemberBuyVip.setVipId(id);
        tempEduMemberBuyVip.setCreateId(dbMember.getId());
        tempEduMemberBuyVip.setUpdateId(dbMember.getId());
        if(price>0){
            tempEduMemberBuyVip.setPrice(BigDecimal.valueOf(price));
        }else{
            tempEduMemberBuyVip.setPrice(BigDecimal.valueOf(dbEduVipType.getVipMoney()));
        }

        tempEduMemberBuyVip.setPayChannel("wxpay");
        tempEduMemberBuyVip.setRemarks("用户加入VIP【"+dbEduVipType.getName()+"】");

        if(cityAddress!=null&&!cityAddress.equals("内网IP")){
            String addressInfo[] = cityAddress.split("\\|");
            tempEduMemberBuyVip.setCountry(addressInfo[0]);//国家或地区
            tempEduMemberBuyVip.setArea(addressInfo[1]=="0"?"未知":addressInfo[1]); //区域
            tempEduMemberBuyVip.setProvince(addressInfo[2].replace("省",""));// 省份
            tempEduMemberBuyVip.setCity(addressInfo[3]=="0"?"未知":addressInfo[3]); //城市
            tempEduMemberBuyVip.setIsp(addressInfo[4]);//网络服务提供商
        }

        eduMemberBuyVipDao.insert(tempEduMemberBuyVip);
        return tempEduMemberBuyVip;
    }


    /**
     * 分配权益
     * @param id
     * @param rids
     */
    @Override
    public void assignVipType(Long id, Set<Long> rids) {
        //先清空该会员类型原有的权益
        EduVipType dbEduVipType = eduVipTypeDao.selectById(id);
        if(dbEduVipType==null){
            throw new CustomException("会员类型不存在",500);
        }
        //删除之前分配的权益
        QueryWrapper<EduVipTypeSubject> eduVipTypeSubjectQueryWrapper = new QueryWrapper();
        eduVipTypeSubjectQueryWrapper.eq("vip_id",dbEduVipType.getId());
        eduVipTypeSubjectDao.delete(eduVipTypeSubjectQueryWrapper);

        //增加现在分配的权益
        if(rids.size()>0){
            for(Long rid:rids){
                EduSubject eduSubject = eduSubjectDao.selectById(rid);
                if(eduSubject==null){
                    throw new CustomException("课程类别Id="+rid+",该课程类别不存在",500);
                }

                EduVipTypeSubject eduVipTypeSubject = new EduVipTypeSubject();
                eduVipTypeSubject.setVipId(id);
                eduVipTypeSubject.setSubjectId(rid);
                eduVipTypeSubjectDao.insert(eduVipTypeSubject);

            }
        }

    }
}
