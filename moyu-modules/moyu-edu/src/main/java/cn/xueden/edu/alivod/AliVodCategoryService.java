package cn.xueden.edu.alivod;

import cn.xueden.alivod.utils.ConstantPropertiesUtil;
import cn.xueden.common.core.edu.dto.CategoryDto;
import cn.xueden.common.core.edu.vo.EduSubjectVO;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.vod.model.v20170321.*;
import org.springframework.stereotype.Component;

import static cn.xueden.alivod.utils.AliyunVODSDKUtils.initVodClient;

/**功能描述：阿里云视频点播分类业务实现
 * @Auther:梁志杰
 * @Date:2021/1/20
 * @Description:cn.xueden.edu.alivod
 * @version:1.0
 */
@Component
public class AliVodCategoryService {

    /**
     * 添加阿里云视频点播分类
     */
   public CategoryDto addAliVodCategory(EduSubjectVO eduSubjectVO){
       CategoryDto categoryDto = new CategoryDto();
        try {
            DefaultAcsClient client = initVodClient(ConstantPropertiesUtil.ACCESS_KEY_ID, ConstantPropertiesUtil.ACCESS_KEY_SECRET);
            AddCategoryResponse response = new AddCategoryResponse();
            AddCategoryRequest request = new AddCategoryRequest();
            // 分类名称
            request.setCateName(eduSubjectVO.getName());
            if(eduSubjectVO.getCateId()!=null){
                request.setParentId(eduSubjectVO.getCateId());
            }

            response = client.getAcsResponse(request);
            // 创建成功的分类信息
            categoryDto.setParentId(response.getCategory().getParentId());
            categoryDto.setCateId(response.getCategory().getCateId());
            categoryDto.setCateName(response.getCategory().getCateName());
            categoryDto.setLevel(response.getCategory().getLevel());
            System.out.print("ParentId = " + response.getCategory().getParentId() + "\n");
            System.out.print("CateId = " + response.getCategory().getCateId() + "\n");
            System.out.print("CateName = " + response.getCategory().getCateName() + "\n");
            System.out.print("Level = " + response.getCategory().getLevel() + "\n");
        } catch (Exception e) {
            System.out.print("ErrorMessage = " + e.getLocalizedMessage());
        }
       return categoryDto;
    }

    /**
     * 删除阿里云点播视频分类
     * @param id
     * @return
     */
    public boolean deleteSubjectById(Long id) {
        try {
            DefaultAcsClient client = initVodClient(ConstantPropertiesUtil.ACCESS_KEY_ID, ConstantPropertiesUtil.ACCESS_KEY_SECRET);

            DeleteCategoryResponse response = new DeleteCategoryResponse();

            DeleteCategoryRequest request = new DeleteCategoryRequest();
            // 请设置待删除分类ID
            request.setCateId(id);
            response =client.getAcsResponse(request);
            System.out.println("response"+response.getRequestId());
            return true;
        } catch (Exception e) {
            System.out.print("ErrorMessage = " + e.getLocalizedMessage());
            return false;
        }
    }

    /**
     * 修改阿里云点播视频分类
     * @param eduSubjectVO
     * @return
     * @throws Exception
     */
    public boolean  updateSubjectById(EduSubjectVO eduSubjectVO) {
        try {
            DefaultAcsClient client = initVodClient(ConstantPropertiesUtil.ACCESS_KEY_ID, ConstantPropertiesUtil.ACCESS_KEY_SECRET);
            UpdateCategoryResponse response = new UpdateCategoryResponse();
            UpdateCategoryRequest request = new UpdateCategoryRequest();

            if(null==eduSubjectVO.getCateId()||null==eduSubjectVO.getName()){
             return false;
            }

            // 请设置真实分类ID
            request.setCateId(eduSubjectVO.getCateId());
            // 分类名称
            request.setCateName(eduSubjectVO.getName());
            response =client.getAcsResponse(request);
            System.out.println("response"+response.getRequestId());
            return true;
        } catch (Exception e) {
            System.out.print("ErrorMessage = " + e.getLocalizedMessage());
            return false;
        }

    }

}
