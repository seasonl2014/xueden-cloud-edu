package cn.xueden.edu.service.impl;

import cn.xueden.common.core.edu.domain.EduCourse;
import cn.xueden.common.core.edu.domain.EduSubject;
import cn.xueden.common.core.edu.dto.CategoryDto;
import cn.xueden.common.core.edu.vo.EduSubjectTreeNodeVO;
import cn.xueden.common.core.edu.vo.EduSubjectVO;
import cn.xueden.common.core.edu.vo.PageVO;
import cn.xueden.common.core.utils.EduSubjectTreeBuilder;
import cn.xueden.common.core.utils.ListPageUtils;
import cn.xueden.edu.alivod.AliVodCategoryService;
import cn.xueden.edu.converter.EduSubjectConverter;
import cn.xueden.edu.dao.EduCourseDao;
import cn.xueden.edu.dao.EduSubjectDao;
import cn.xueden.edu.service.IEduSubjectService;
/*import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;*/
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**功能描述：课程分类业务实现类
 * @Auther:梁志杰
 * @Date:2021/1/20
 * @Description:cn.xueden.edu.service.impl
 * @version:1.0
 */
@Service
public class EduSubjectServiceImpl extends ServiceImpl<EduSubjectDao, EduSubject> implements IEduSubjectService {
    @Autowired
    private EduSubjectDao eduSubjectDao;

    @Autowired
    private AliVodCategoryService vidCategoryClient;

    @Autowired
    private EduCourseDao eduCourseDao;



    /**
     * 所有商品类别
     * @return
     */
    @Override
    public List<EduSubjectVO> findAll() {
        QueryWrapper<EduSubject> wrapper = new QueryWrapper<>();
        wrapper.eq("del_flag",false);
        List<EduSubject> productCategories = eduSubjectDao.selectList(wrapper);
        return EduSubjectConverter.converterToVOList(productCategories);
    }

    /**
     * 分类树形结构
     * @return
     */
    @Override
    public PageVO<EduSubjectTreeNodeVO> categoryTree(Integer pageNum, Integer pageSize) {
        List<EduSubjectVO> productCategoryVOList = findAll();
        List<EduSubjectTreeNodeVO> nodeVOS=EduSubjectConverter.converterToTreeNodeVO(productCategoryVOList);
        List<EduSubjectTreeNodeVO> tree = EduSubjectTreeBuilder.build(nodeVOS);
        List<EduSubjectTreeNodeVO> page;
        if(pageSize!=null&&pageNum!=null){
            page= ListPageUtils.page(tree, pageSize, pageNum);
            return new PageVO<>(tree.size(),page);
        }else {
            return new PageVO<>(tree.size(), tree);
        }
    }

    /**
     * 获取父级分类（2级树）
     * @return
     */
    @Override
    public List<EduSubjectTreeNodeVO> getParentEduSubjectTree() {
        List<EduSubjectVO> productCategoryVOList = findAll();
        List<EduSubjectTreeNodeVO> nodeVOS=EduSubjectConverter.converterToTreeNodeVO(productCategoryVOList);
        return  EduSubjectTreeBuilder.buildParent(nodeVOS);
    }

    /**
     * 添加课程类别
     * @param eduSubjectVO
     */
    @Override
    public void add(EduSubjectVO eduSubjectVO) {
        EduSubject eduSubject = new EduSubject();
        BeanUtils.copyProperties(eduSubjectVO,eduSubject);
        eduSubject.setCreateDate(new Date());
        eduSubject.setUpdateDate(new Date());

        // 获取阿里云点播对应课程分类ID

        // 如果父节点不为空
        if(eduSubjectVO.getParentId()!=null){
            EduSubject dbEduSubject = eduSubjectDao.selectById(eduSubjectVO.getParentId());
            if(dbEduSubject!=null){
                eduSubjectVO.setCateId(dbEduSubject.getCateId());
            }
        }

        CategoryDto categoryDto = vidCategoryClient.addAliVodCategory(eduSubjectVO);
        if(categoryDto!=null){
            eduSubject.setCateId(categoryDto.getCateId());
            eduSubjectDao.insert(eduSubject);
        }


    }


    /**
     * 删除课程类别
     * @param id
     */
    @Override
    public boolean delete(Long id) {
        EduSubject dbEduSubject = eduSubjectDao.selectById(id);
        if(dbEduSubject!=null){
            // 判断要删除的栏目下是否有子栏目,有子栏目不能删，没有可以删除
            if(dbEduSubject.getParentId()!=null&&dbEduSubject.getParentId()!=0){
                QueryWrapper<EduSubject> subjectEntityWrapper = new QueryWrapper();
                subjectEntityWrapper.eq("parent_id",dbEduSubject.getParentId());
                int count =  eduSubjectDao.selectCount(subjectEntityWrapper);
                if(count!=0){
                    return false;
                }
            }

            // 判断该栏目下是否有课程，有的话不能删除，没有则可以删除


            // 同时删除阿里云视频点播上的课程栏目
            if(dbEduSubject.getCateId()!=null){
                boolean flag = vidCategoryClient.deleteSubjectById(dbEduSubject.getCateId());
                if(flag){
                    eduSubjectDao.deleteById(id);
                }else {
                    return false;
                }
            }else {
                eduSubjectDao.deleteById(id);
                return true;
            }
        }else {
            return false;
        }
        return true;
    }

    /**
     * 编辑商品类别
     * @param id
     * @return
     */
    @Override
    public EduSubjectVO edit(Long id) {
        EduSubject eduSubject = eduSubjectDao.selectById(id);
        return  EduSubjectConverter.converterToEduSubjectVO(eduSubject);
    }

    /**
     * 更新商品类别
     * @param id
     * @param eduSubjectVO
     */
    @Override
    public boolean update(Long id, EduSubjectVO eduSubjectVO) {
        EduSubject eduSubject = new EduSubject();
        BeanUtils.copyProperties(eduSubjectVO,eduSubject);
        eduSubject.setUpdateDate(new Date());
        eduSubject.setId(id);
        boolean flag = vidCategoryClient.updateSubjectById(eduSubjectVO);
        if(flag){
            eduSubjectDao.updateById(eduSubject);
            return true;
        }
        return false;

    }

    /**
     * 获取首页课程栏目
     * @param pageNum
     * @param pageSize
     * @return
     */
    @Override
    public List<EduSubjectVO> getIndexColumnCourses(int pageNum, int pageSize) {

        // 定义课程分类类别
        List<EduSubject> eduSubjects = new ArrayList<EduSubject>();

        QueryWrapper<EduSubject> subjectEntityWrapper = new QueryWrapper();
        subjectEntityWrapper.eq("parent_id",0);
        eduSubjects = eduSubjectDao.selectList(subjectEntityWrapper);
        List<EduSubjectVO> eduSubjectVOList = EduSubjectConverter.converterToVOList(eduSubjects);
        for(EduSubjectVO eduSubjectVO:eduSubjectVOList){
            // 分别获取两个子栏目
            QueryWrapper<EduSubject> childrenEntityWrapper = new QueryWrapper();
            childrenEntityWrapper.eq("parent_id",eduSubjectVO.getId());
            Page<EduSubject> EduSubjectPage = eduSubjectDao.selectPage(new Page<>(1,2),childrenEntityWrapper);
            eduSubjectVO.setChildrens(EduSubjectPage.getRecords());
            // 分别获取8个课程
            QueryWrapper<EduCourse> courseEntityWrapper = new QueryWrapper();
            courseEntityWrapper.eq("subject_parent_id",eduSubjectVO.getId());
            Page<EduCourse> EduCoursePage= eduCourseDao.selectPage(new Page<>(1,8),courseEntityWrapper);
            eduSubjectVO.setEduCourseList(EduCoursePage.getRecords());
        }

        return eduSubjectVOList;
    }
}

