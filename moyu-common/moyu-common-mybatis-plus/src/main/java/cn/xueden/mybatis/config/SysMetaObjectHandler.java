package cn.xueden.mybatis.config;

import cn.xueden.common.security.service.TokenService;
import cn.xueden.system.api.model.LoginUser;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import org.apache.ibatis.reflection.MetaObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;


import java.util.Date;

/**功能描述:mybatisplus自定义填充公共字段 ,即没有传的字段自动填充
 * @Auther:梁志杰
 * @Date:2020/9/25
 * @Description:cn.xueden.mybatis.config
 * @version:1.0
 */
@Component
public class SysMetaObjectHandler implements  MetaObjectHandler {

    private Logger logger = LoggerFactory.getLogger(getClass());

    private TokenService tokenService ;


    @Override
    public void insertFill(MetaObject metaObject) {
        Object createDate = getFieldValByName("createDate",metaObject);
        Object createId = getFieldValByName("createId",metaObject);
        Object updateDate = getFieldValByName("updateDate",metaObject);
        Object updateId = getFieldValByName("updateId",metaObject);
        tokenService = (TokenService)SpringUtil.getBean("tokenService");

        if (null == createDate) {
            setFieldValByName("createDate", new Date(),metaObject);
        }
        if (null == createId) {
            if(tokenService != null) {
                LoginUser loginUser= tokenService.getLoginUser();
                if(null!=loginUser){
                    setFieldValByName("createId", loginUser.getUserid(), metaObject);
                }

            }
        }
        if (null == updateDate) {
            setFieldValByName("updateDate", new Date(),metaObject);
        }
        if (null == updateId) {

            if(tokenService != null) {
                LoginUser loginUser= tokenService.getLoginUser();
                if(null!=loginUser){
                    setFieldValByName("updateId", loginUser.getUserid(), metaObject);
                }
            }
        }
    }

    //更新填充
    @Override
    public void updateFill(MetaObject metaObject) {
        setFieldValByName("updateDate",new Date(), metaObject);
        Object updateId = getFieldValByName("updateId",metaObject);
        if (null == updateId) {
            tokenService = (TokenService)SpringUtil.getBean("tokenService");
            if(tokenService != null) {
                LoginUser loginUser= tokenService.getLoginUser();
                if(null!=loginUser){
                    setFieldValByName("updateId", loginUser.getUserid(), metaObject);
                }
            }
        }
    }
}

