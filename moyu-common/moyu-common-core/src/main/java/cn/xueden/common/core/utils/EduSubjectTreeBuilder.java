package cn.xueden.common.core.utils;

import cn.xueden.common.core.edu.vo.EduSubjectTreeNodeVO;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * @Auther:梁志杰
 * @Date:2021/1/20
 * @Description:cn.xueden.common.core.utils
 * @version:1.0
 */
public class EduSubjectTreeBuilder {
    private static int count=1;

    /**
     * 构建多级
     * @param nodes
     * @return
     */
    public static List<EduSubjectTreeNodeVO> build(List<EduSubjectTreeNodeVO> nodes){
        //根节点
        List<EduSubjectTreeNodeVO> rootMenu = new ArrayList<>();
        for (EduSubjectTreeNodeVO nav : nodes) {
            if(nav.getParentId()==0){
                nav.setLev(1);
                rootMenu.add(nav);
            }
        }
        /* 根据Menu类的order排序 */
        Collections.sort(rootMenu,EduSubjectTreeNodeVO.order());
        /*为根菜单设置子菜单，getChild是递归调用的*/
        for (EduSubjectTreeNodeVO nav : rootMenu) {
            /* 获取根节点下的所有子节点 使用getChild方法*/
            List<EduSubjectTreeNodeVO> childList = getChild(nav, nodes);
            nav.setChildren(childList);//给根节点设置子节点
        }
        return rootMenu;
    }

    /**
     * 获取子菜单
     * @param pNode
     * @param nodes
     * @return
     */
    private static List<EduSubjectTreeNodeVO> getChild(EduSubjectTreeNodeVO pNode, List<EduSubjectTreeNodeVO> nodes) {
        //子菜单
        List<EduSubjectTreeNodeVO> childList = new ArrayList<>();
        for (EduSubjectTreeNodeVO nav : nodes) {
            // 遍历所有节点，将所有菜单的父id与传过来的根节点的id比较
            //相等说明：为该根节点的子节点。
            if(nav.getParentId().equals(pNode.getId())){
                nav.setLev(pNode.getLev()+1);
                childList.add(nav);
            }
        }
        //递归
        for (EduSubjectTreeNodeVO nav : childList) {
            nav.setChildren(getChild(nav, nodes));
        }
        Collections.sort(childList,EduSubjectTreeNodeVO.order());//排序
        //如果节点下没有子节点，返回一个空List（递归退出）
        if(childList.size() == 0){
            return null;
        }
        return childList;
    }


    //    获取二级父级分类

    public static List<EduSubjectTreeNodeVO> buildParent(List<EduSubjectTreeNodeVO> nodes) {
        //根节点
        List<EduSubjectTreeNodeVO> rootMenu = new ArrayList<>();
        for (EduSubjectTreeNodeVO nav : nodes) {
            if(nav.getParentId()==0){
                nav.setLev(1);
                rootMenu.add(nav);
            }
        }
        /* 根据Menu类的order排序 */
        Collections.sort(rootMenu,EduSubjectTreeNodeVO.order());
        /*为根菜单设置子菜单，getChild是递归调用的*/
        for (EduSubjectTreeNodeVO nav : rootMenu) {
            /* 获取根节点下的所有子节点 使用getChild方法*/
            List<EduSubjectTreeNodeVO> childList = getParentChild(nav, nodes);
            nav.setChildren(childList);//给根节点设置子节点
        }
        return rootMenu;
    }

    private static List<EduSubjectTreeNodeVO> getParentChild(EduSubjectTreeNodeVO pNode, List<EduSubjectTreeNodeVO> nodes) {
        //子菜单
        List<EduSubjectTreeNodeVO> childList = new ArrayList<>();
        for (EduSubjectTreeNodeVO nav : nodes) {
            // 遍历所有节点，将所有菜单的父id与传过来的根节点的id比较
            //相等说明：为该根节点的子节点。
            if(nav.getParentId().equals(pNode.getId())){
                nav.setLev(2);
                childList.add(nav);
            }
        }
        return childList;
    }






}
