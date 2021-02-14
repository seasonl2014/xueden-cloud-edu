package cn.xueden.edu.service.impl;

import cn.xueden.common.core.edu.domain.EduMember;
import cn.xueden.common.core.edu.domain.EduMemberBuyCourse;
import cn.xueden.common.core.edu.domain.EduVideo;
import cn.xueden.common.core.edu.domain.EduVideoMember;
import cn.xueden.common.core.edu.vo.EduMemberVO;
import cn.xueden.common.core.edu.vo.EduVideoVO;
import cn.xueden.common.core.utils.AddressUtil;
import cn.xueden.common.core.utils.JWTUtils;
import cn.xueden.common.security.service.TokenService;
import cn.xueden.edu.converter.EduVideoConverter;
import cn.xueden.edu.dao.EduMemberBuyCourseDao;
import cn.xueden.edu.dao.EduMemberDao;
import cn.xueden.edu.dao.EduVideoDao;
import cn.xueden.edu.dao.EduVideoMemberDao;
import cn.xueden.edu.service.IEduVideoService;
/*import com.baomidou.mybatisplus.service.impl.ServiceImpl;*/
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * @Auther:梁志杰
 * @Date:2021/1/24
 * @Description:cn.xueden.edu.service.impl
 * @version:1.0
 */
@Service
public class EduVideoServiceImpl extends ServiceImpl<EduVideoDao, EduVideo> implements IEduVideoService {

    @Autowired
    private EduVideoDao eduVideoDao;

    @Autowired
    private EduMemberDao eduMemberDao;

    @Autowired
    private EduMemberBuyCourseDao eduMemberBuyCourseDao;

    @Autowired
    private EduVideoMemberDao eduVideoMemberDao;

    @Autowired
    private TokenService tokenService;

    /**
     * 根据文件标志获取视频信息
     * @param fileKey
     * @return
     */
    @Override
    public EduVideo getVideoByfileKey(String fileKey) {
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("file_key",fileKey);
        return eduVideoDao.selectOne(queryWrapper);
    }

    /**
     * 根据ID获取视频信息
     * @param id
     * @param token
     * @param ipAddress
     * @return
     */
    @Override
    public EduVideoVO getVideoInfo(Long id, String token, String ipAddress) {
        // 是否需要显示广告
        int displayAds = 0; // 0表示显示广告，1表示不显示广告
        // 根据IP地址获取地理位置
        String cityAddress = AddressUtil.getCityInfo(ipAddress);
        //根据token,获取登录会员信息
        EduMemberVO loginMember = tokenService.getLoginMember();
        if(loginMember==null){
            return null;
        }

        // 根据手机号获取用户信息
        EduMember member = new EduMember();
        member.setMobile(loginMember.getMobile());
        QueryWrapper memberQueryWrapper = new QueryWrapper();
        memberQueryWrapper.eq("mobile",loginMember.getMobile());
        EduMember dbMember =  eduMemberDao.selectOne(memberQueryWrapper);
        if(dbMember==null){
            return null;
        }

        EduVideo eduVideo = eduVideoDao.selectById(id);
        //判断用户是否已经购买该课程

        QueryWrapper memberBuyCourseQueryWrapper = new QueryWrapper();
        memberBuyCourseQueryWrapper.eq("member_id",dbMember.getId());
        memberBuyCourseQueryWrapper.eq("course_id",eduVideo.getCourseId());
        memberBuyCourseQueryWrapper.eq("is_payment",1);
        EduMemberBuyCourse dbEduMemberBuyCourse = eduMemberBuyCourseDao.selectOne(memberBuyCourseQueryWrapper);
        if(dbEduMemberBuyCourse!=null){
            eduVideo.setPreviewDuration(0);
            displayAds = 1;
        }else{
            if(eduVideo.getIsFree()==0){
                eduVideo.setPreviewDuration(0);
            }else{
                return null;
            }
        }


        //更新播放次数
        eduVideo.setPlayCount(eduVideo.getPlayCount()+1);
        eduVideoDao.updateById(eduVideo);

        EduVideoMember eduVideoMember = new EduVideoMember();
        eduVideoMember.setMemberId(dbMember.getId());
        eduVideoMember.setPlayCount(1l);
        eduVideoMember.setVideoId(eduVideo.getId());
        eduVideoMember.setDuration(0f);
        eduVideoMember.setIp(cityAddress);
        eduVideoMember.setCreateDate(new Date());
        eduVideoMember.setUpdateDate(new Date());
        if(cityAddress!=null&&!cityAddress.equals("内网IP")){
            String addressInfo[] = cityAddress.split("\\|");
            eduVideoMember.setCountry(addressInfo[0]);//国家或地区
            eduVideoMember.setArea(addressInfo[1]=="0"?"未知":addressInfo[1]); //区域
            eduVideoMember.setProvince(addressInfo[2].replace("省",""));// 省份
            eduVideoMember.setCity(addressInfo[3]=="0"?"未知":addressInfo[3]); //城市
            eduVideoMember.setIsp(addressInfo[4]);//网络服务提供商
        }
        eduVideoMember.setCreateId(eduVideoMember.getMemberId());
        eduVideoMember.setUpdateId(eduVideoMember.getMemberId());
        eduVideoMemberDao.insert(eduVideoMember);
        EduVideoVO eduVideoVO = EduVideoConverter.converterToEduChapterVO(eduVideo);
        eduVideoVO.setDisplayAds(displayAds);
        return eduVideoVO;
    }
}
