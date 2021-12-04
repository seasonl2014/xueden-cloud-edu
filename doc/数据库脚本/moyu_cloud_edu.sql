/*
Navicat MySQL Data Transfer

Source Server         : 虚拟机10
Source Server Version : 50731
Source Host           : 192.168.56.10:3306
Source Database       : moyu_cloud_edu

Target Server Type    : MYSQL
Target Server Version : 50731
File Encoding         : 65001

Date: 2021-12-01 14:58:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for edu_adv
-- ----------------------------
DROP TABLE IF EXISTS `edu_adv`;
CREATE TABLE `edu_adv` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `adv_order_no` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '所属订单',
  `adv_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '广告地址，图片地址，或视频地址',
  `adv_link_address` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '广告跳转链接地址',
  `adv_type` smallint(2) NOT NULL DEFAULT '0' COMMENT '广告类型，0表示图片广告，1表示视频广告',
  `adv_start_time` datetime NOT NULL COMMENT '广告开始时间',
  `adv_end_time` datetime NOT NULL COMMENT '广告结束时间',
  `adv_price` decimal(10,0) NOT NULL DEFAULT '0' COMMENT '广告价格',
  `member_id` bigint(20) NOT NULL COMMENT '广告投放者ID',
  `subject_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '课程栏目，即广告投放到哪个栏目下，0表示全站,只针对视频广告',
  `create_date` datetime DEFAULT NULL,
  `create_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT '0' COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `remarks` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='广告表';

-- ----------------------------
-- Records of edu_adv
-- ----------------------------

-- ----------------------------
-- Table structure for edu_banner
-- ----------------------------
DROP TABLE IF EXISTS `edu_banner`;
CREATE TABLE `edu_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) DEFAULT NULL COMMENT '链接地址',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `img` varchar(255) DEFAULT NULL COMMENT '封面',
  `level` tinyint(2) DEFAULT '0' COMMENT '等级排序',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT '0' COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='首页Banner表';

-- ----------------------------
-- Records of edu_banner
-- ----------------------------
INSERT INTO `edu_banner` VALUES ('1', 'http://localhost:9524/details/49', 'springboot+vue整合权限管理系统', 'http://imgoss.goodym.cn/goodymimgupload/202007/1593817361902.png', '0', '2020-05-22 07:55:56', null, null, null, '0', null);
INSERT INTO `edu_banner` VALUES ('2', 'http://localhost:9524/details/47', '图书借阅管理系统', 'http://imgoss.goodym.cn/goodymimgupload/202007/1593822076416.jpg', '0', '2020-05-22 07:56:26', null, null, null, '0', null);

-- ----------------------------
-- Table structure for edu_cashout_details
-- ----------------------------
DROP TABLE IF EXISTS `edu_cashout_details`;
CREATE TABLE `edu_cashout_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `teacher_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '讲师ID',
  `bank_card` varchar(255) NOT NULL COMMENT '提款账号',
  `name` varchar(255) CHARACTER SET utf8mb4 NOT NULL COMMENT '开户人',
  `cash_out` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '提现金额',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '提现状态，0表示待审核，1表示付款完成',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '提现申请时间',
  `update_date` datetime DEFAULT NULL COMMENT '审核付款时间',
  `del_flag` tinyint(1) DEFAULT '0' COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `remarks` text CHARACTER SET utf8mb4 COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='讲师提现记录表';

-- ----------------------------
-- Records of edu_cashout_details
-- ----------------------------
INSERT INTO `edu_cashout_details` VALUES ('2', '2', '456321654987', '张三', '10.00', '0', '2', '2', '2021-05-28 19:03:25', '2021-05-28 19:03:25', '0', null);

-- ----------------------------
-- Table structure for edu_chapter
-- ----------------------------
DROP TABLE IF EXISTS `edu_chapter`;
CREATE TABLE `edu_chapter` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '章节ID',
  `course_id` bigint(10) NOT NULL COMMENT '课程ID',
  `title` varchar(50) NOT NULL COMMENT '章节名称',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '显示排序',
  `duration` bigint(10) DEFAULT '0' COMMENT '章节时长',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `create_by` bigint(20) DEFAULT NULL,
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT '0' COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注说明',
  PRIMARY KEY (`id`),
  KEY `idx_course_id` (`course_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8mb4 COMMENT='课程';

-- ----------------------------
-- Records of edu_chapter
-- ----------------------------
INSERT INTO `edu_chapter` VALUES ('1', '4', '第1章 课程介绍', '1', '0', '2021-01-26 20:08:46', '1', '2021-01-26 20:22:09', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('2', '4', '第2章 IDEA入门', '1', '0', '2021-01-26 20:09:32', '1', '2021-01-26 20:09:32', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('3', '4', '第3章 IDE构建项目', '1', '0', '2021-01-26 20:09:41', '1', '2021-01-26 20:09:41', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('4', '4', '第4章 IDEA其他常用操作', '1', '0', '2021-01-26 20:09:49', '1', '2021-01-26 20:09:49', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('5', '34', '第1章 java初体验', '1', '0', '2021-01-27 22:22:24', '1', '2021-01-27 22:22:24', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('6', '34', '第2章 变量和常量', '1', '0', '2021-01-27 22:22:34', '1', '2021-01-27 22:22:34', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('7', '34', '第3章 常用运算符', '1', '0', '2021-01-27 22:23:04', '1', '2021-01-27 22:23:04', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('8', '34', '第4章 流程控制语句', '1', '0', '2021-01-27 22:23:14', '1', '2021-01-27 22:23:14', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('9', '34', '第5章 方法', '1', '0', '2021-01-27 22:23:22', '1', '2021-01-27 22:23:22', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('10', '35', '第1章 类和对象', '1', '0', '2021-01-28 12:30:02', '1', '2021-01-28 12:30:02', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('11', '35', '第2章 封装', '1', '0', '2021-01-28 12:30:10', '1', '2021-01-28 12:30:10', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('12', '35', '第3章 继承', '1', '0', '2021-01-28 12:30:17', '1', '2021-01-28 12:30:17', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('13', '35', '第4章 多态', '1', '0', '2021-01-28 12:30:24', '1', '2021-01-28 12:30:24', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('14', '35', '第5章 数组', '1', '0', '2021-01-28 12:30:30', '1', '2021-01-28 12:30:31', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('15', '36', '第1章 异常与异常处理', '1', '0', '2021-01-28 13:20:51', '1', '2021-01-28 13:20:51', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('16', '36', '第2章 认识 Java 中的字符串', '1', '0', '2021-01-28 13:22:11', '1', '2021-01-28 13:22:11', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('17', '36', '第3章 Java 中的常用类', '1', '0', '2021-01-28 13:22:19', '1', '2021-01-28 13:22:19', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('18', '36', '第4章 Java 中的集合框架（上）', '1', '0', '2021-01-28 13:22:26', '1', '2021-01-28 13:22:26', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('19', '36', '第5章 Java 中的集合框架（中）', '1', '0', '2021-01-28 13:22:35', '1', '2021-01-28 13:22:35', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('20', '36', '第6章 Java 中的集合框架（下）', '1', '0', '2021-01-28 13:22:43', '1', '2021-01-28 13:22:43', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('21', '37', '第1章 初涉MySQL', '1', '0', '2021-01-28 18:54:00', '1', '2021-01-28 18:54:00', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('22', '37', '第2章 数据类型与操作数据表', '1', '0', '2021-01-28 18:54:08', '1', '2021-01-28 18:54:08', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('23', '37', '第3章 约束以及修改数据表', '1', '0', '2021-01-28 18:54:15', '1', '2021-01-28 18:54:15', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('24', '37', '第4章 操作数据表中的记录', '1', '0', '2021-01-28 18:54:22', '1', '2021-01-28 18:54:22', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('25', '37', '第5章 子查询与连接', '1', '0', '2021-01-28 18:54:30', '1', '2021-01-28 18:54:30', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('26', '38', '第1章 JUnit4课程概述', '1', '0', '2021-01-29 15:41:30', '1', '2021-01-29 15:41:30', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('27', '38', '第2章 JUnit4快速入门', '1', '0', '2021-01-29 15:41:39', '1', '2021-01-29 15:41:39', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('28', '38', '第3章 JUnit4使用详解', '1', '0', '2021-01-29 15:41:47', '1', '2021-01-29 15:41:47', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('29', '38', '第4章 JUnit4的深入使用', '1', '0', '2021-01-29 15:41:55', '1', '2021-01-29 15:41:55', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('30', '39', '第1章 jdbc简介', '1', '0', '2021-01-29 18:15:00', '1', '2021-01-29 18:15:00', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('31', '39', '第2章 jdbc连接步骤', '1', '0', '2021-01-29 18:15:07', '1', '2021-01-29 18:15:07', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('32', '39', '第3章 事务和连接池', '1', '0', '2021-01-29 18:15:14', '1', '2021-01-29 18:15:14', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('33', '39', '第4章 使用DBUtils工具实现增删改查', '1', '0', '2021-01-29 18:15:22', '1', '2021-01-29 18:15:22', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('34', '40', '第1章 Html介绍', '1', '0', '2021-01-29 19:47:04', '1', '2021-01-29 19:47:04', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('35', '40', '第2章 认识标签(第一部分)', '1', '0', '2021-01-29 19:47:12', '1', '2021-01-29 19:47:12', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('36', '40', '第3章 认识标签(第二部分)', '1', '0', '2021-01-29 19:47:20', '1', '2021-01-29 19:47:20', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('37', '40', '第4章 认识标签(第三部分)', '1', '0', '2021-01-29 19:47:27', '1', '2021-01-29 19:47:27', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('38', '40', '第5章 与浏览者交互，表单标签', '1', '0', '2021-01-29 19:47:35', '1', '2021-01-29 19:47:35', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('39', '41', '第1章 使用CSS，为网页添加样式', '1', '0', '2021-01-29 20:32:01', '1', '2021-01-29 20:32:01', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('40', '41', '第2章 CSS样式基本知识', '1', '0', '2021-01-29 20:32:08', '1', '2021-01-29 20:32:08', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('41', '41', '第3章 CSS选择器', '1', '0', '2021-01-29 20:32:15', '1', '2021-01-29 20:32:15', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('42', '41', '第4章 CSS的继承、层叠和特殊性', '1', '0', '2021-01-29 20:32:25', '1', '2021-01-29 20:32:25', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('43', '41', '第5章 CSS格式化排版', '1', '0', '2021-01-29 20:32:33', '1', '2021-01-29 20:32:33', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('44', '42', '第1章 CSS盒模型', '1', '0', '2021-01-29 21:04:47', '1', '2021-01-29 21:04:47', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('45', '42', '第2章 CSS布局模型', '1', '0', '2021-01-29 21:04:54', '1', '2021-01-29 21:04:54', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('46', '42', '第3章 CSS代码缩写，占用更少的带宽', '1', '0', '2021-01-29 21:05:01', '1', '2021-01-29 21:05:01', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('47', '42', '第4章 单位和值', '1', '0', '2021-01-29 21:05:09', '1', '2021-01-29 21:05:09', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('48', '42', '第5章 css样式设置小技巧', '1', '0', '2021-01-29 21:05:16', '1', '2021-01-29 21:05:16', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('49', '43', '第1章 请做好准备', '1', '0', '2021-01-30 08:22:10', '1', '2021-01-30 08:22:10', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('50', '43', '第2章 常用互动方法', '1', '0', '2021-01-30 08:22:16', '1', '2021-01-30 08:22:16', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('51', '43', '第3章 DOM操作', '1', '0', '2021-01-30 08:22:23', '1', '2021-01-30 08:22:23', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('52', '44', '第1章 初识jQuery', '1', '0', '2021-01-30 08:57:35', '1', '2021-01-30 08:57:35', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('53', '44', '第2章 jQuery选择器', '1', '0', '2021-01-30 08:57:41', '1', '2021-01-30 08:57:41', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('54', '44', '第3章 jQuery的属性与样式', '1', '0', '2021-01-30 08:57:48', '1', '2021-01-30 08:57:48', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('55', '45', '第1章 基础说明', '1', '0', '2021-01-30 10:31:57', '1', '2021-01-30 10:31:57', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('56', '45', '第2章 页面元素', '1', '0', '2021-01-30 10:32:04', '1', '2021-01-30 10:32:04', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('57', '45', '第3章 内置模块', '1', '0', '2021-01-30 10:32:12', '1', '2021-01-30 10:32:12', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('58', '46', '第1章 JSP基础语法', '1', '0', '2021-01-30 10:35:54', '1', '2021-01-30 10:35:54', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('59', '46', '第2章 JSP内置对象（上）', '1', '0', '2021-01-30 10:36:01', '1', '2021-01-30 10:36:01', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('60', '46', '第3章 JSP内置对象（下）', '1', '0', '2021-01-30 10:36:08', '1', '2021-01-30 10:36:08', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('61', '46', '第4章 JavaBeans', '1', '0', '2021-01-30 10:36:15', '1', '2021-01-30 10:36:15', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('62', '46', '第5章 JSP状态管理', '1', '0', '2021-01-30 10:36:22', '1', '2021-01-30 10:36:22', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('63', '46', '第6章 JSP指令与动作元素', '1', '0', '2021-01-30 10:36:29', '1', '2021-01-30 10:36:29', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('64', '47', '第1章 课程介绍', '1', '0', '2021-01-30 10:47:37', '1', '2021-01-30 10:47:37', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('65', '47', '第2章 后端基础框架搭建', '1', '0', '2021-01-30 10:47:44', '1', '2021-01-30 10:47:44', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('66', '47', '第3章 系统登录功能实现', '1', '0', '2021-01-30 10:47:51', '1', '2021-01-30 10:47:51', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('67', '47', '第4章 后端用户管理模块功能实现', '1', '0', '2021-01-30 10:47:59', '1', '2021-01-30 10:47:59', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('68', '47', '第5章 后端图书管理模块功能实现', '1', '0', '2021-01-30 10:48:05', '1', '2021-01-30 10:48:05', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('69', '47', '第6章 后端借阅管理模块功能实现', '1', '0', '2021-01-30 10:48:12', '1', '2021-01-30 10:48:12', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('70', '47', '第7章 后端日志管理模块功能实现', '1', '0', '2021-01-30 10:48:19', '1', '2021-01-30 10:48:19', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('71', '47', '第8章 前端系统基础框架搭建', '1', '0', '2021-01-30 10:48:26', '1', '2021-01-30 10:48:26', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('72', '47', '第9章 前端用户管理模块功能实现', '1', '0', '2021-01-30 10:48:36', '1', '2021-01-30 10:48:36', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('73', '47', '第10章 前端借阅管理模块功能实现', '1', '0', '2021-01-30 10:48:44', '1', '2021-01-30 10:48:44', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('74', '47', '第11章 前端日志管理模块功能实现', '1', '0', '2021-01-30 10:48:52', '1', '2021-01-30 10:48:52', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('75', '48', '第1章 课程介绍', '1', '0', '2021-01-30 12:26:54', '1', '2021-01-30 12:26:54', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('76', '48', '第2章 基础框架搭建', '1', '0', '2021-01-30 12:27:02', '1', '2021-01-30 12:27:02', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('77', '48', '第3章 系统登录功能实现', '1', '0', '2021-01-30 12:27:08', '1', '2021-01-30 12:27:08', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('78', '48', '第4章 课程管理模块功能实现', '1', '0', '2021-01-30 12:27:15', '1', '2021-01-30 12:27:15', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('79', '48', '第5章 学生管理模块功能实现', '1', '0', '2021-01-30 12:27:22', '1', '2021-01-30 12:27:22', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('80', '48', '第6章 前台功能实现', '1', '0', '2021-01-30 12:27:30', '1', '2021-01-30 12:27:30', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('81', '48', '第7章 选课管理模块功能实现', '1', '0', '2021-01-30 12:27:37', '1', '2021-01-30 12:27:37', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('82', '48', '第8章 后台首页功能实现', '1', '0', '2021-01-30 12:27:45', '1', '2021-01-30 12:27:45', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('83', '49', '第1章 课程介绍', '1', '0', '2021-01-30 12:35:46', '1', '2021-01-30 12:35:46', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('84', '49', '第2章 后端项目基础框架搭建', '1', '0', '2021-01-30 12:35:52', '1', '2021-01-30 12:35:52', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('85', '49', '第3章 前端项目基础框架搭建', '1', '0', '2021-01-30 12:35:59', '1', '2021-01-30 12:35:59', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('86', '49', '第4章 架构完善', '1', '0', '2021-01-30 12:36:05', '1', '2021-01-30 12:36:05', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('87', '49', '第5章 完善登录流程', '1', '0', '2021-01-30 12:36:12', '1', '2021-01-30 12:36:12', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('88', '49', '第6章 后端菜单管理模块功能实现', '1', '0', '2021-01-30 12:36:19', '1', '2021-01-30 12:36:19', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('89', '49', '第7章 前端菜单管理模块功能实现', '1', '0', '2021-01-30 12:36:28', '1', '2021-01-30 12:36:28', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('90', '49', '第8章 后端角色管理模块功能实现', '1', '0', '2021-01-30 12:36:36', '1', '2021-01-30 12:36:36', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('91', '49', '第9章 前端角色管理模块功能实现', '1', '0', '2021-01-30 12:36:43', '1', '2021-01-30 12:36:43', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('92', '49', '第10章 后端用户管理模块功能实现', '1', '0', '2021-01-30 12:36:50', '1', '2021-01-30 12:36:50', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('93', '49', '第11章 前端用户管理模块功能实现', '1', '0', '2021-01-30 12:36:57', '1', '2021-01-30 12:36:57', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('94', '49', '第12章 后端日志管理模块功能实现', '1', '0', '2021-01-30 12:37:05', '1', '2021-01-30 12:37:05', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('95', '49', '第13章 前端日志管理模块功能实现', '1', '0', '2021-01-30 12:37:12', '1', '2021-01-30 12:37:12', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('96', '49', '第14章 系统后台首页模块功能实现', '1', '0', '2021-01-30 12:37:19', '1', '2021-01-30 12:37:19', '1', '1', null);
INSERT INTO `edu_chapter` VALUES ('97', '49', '第14章 使用docker部项目', '1', '0', '2021-01-30 12:37:33', '1', '2021-02-06 18:47:25', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('98', '50', '第1章 课程介绍', '1', '0', '2021-01-30 12:50:20', '1', '2021-01-30 12:50:20', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('99', '50', '第2章 准备工作', '1', '0', '2021-01-30 12:50:26', '1', '2021-01-30 12:50:26', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('100', '50', '第3章 后端项目基础框架搭建', '1', '0', '2021-01-30 12:50:33', '1', '2021-01-30 12:50:33', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('101', '50', '第4章 前端项目基础框架搭建', '1', '0', '2021-01-30 12:50:40', '1', '2021-01-30 12:50:40', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('102', '50', '第5章 架构完善', '1', '0', '2021-01-30 12:50:47', '1', '2021-01-30 12:50:47', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('103', '50', '第6章 系统登录功能实现', '1', '0', '2021-01-30 12:50:54', '1', '2021-01-30 12:50:54', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('104', '50', '第7章 菜单管理模块功能实现', '1', '0', '2021-01-30 12:51:02', '1', '2021-01-30 12:51:02', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('105', '50', '第8章 角色管理模块功能实现', '1', '0', '2021-01-30 12:51:09', '1', '2021-01-30 12:51:09', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('106', '50', '第9章 字典管理模块功能实现', '1', '0', '2021-01-30 12:51:16', '1', '2021-01-30 12:51:16', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('107', '50', '第10章 部门管理模块功能实现', '1', '0', '2021-01-30 12:51:23', '1', '2021-01-30 12:51:23', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('108', '50', '第11章 岗位管理模块功能实现', '1', '0', '2021-01-30 12:51:31', '1', '2021-01-30 12:51:31', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('109', '50', '第12章 用户管理模块功能实现', '1', '0', '2021-01-30 12:51:39', '1', '2021-01-30 12:51:39', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('110', '50', '第13章 邮箱管理模块功能实现', '1', '0', '2021-01-30 12:51:46', '1', '2021-01-30 12:51:46', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('111', '50', '第14章 日志管理模块功能实现', '1', '0', '2021-01-30 12:52:04', '1', '2021-01-30 12:52:04', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('112', '50', '第15章 后台首页模块功能实现', '1', '0', '2021-01-30 12:52:11', '1', '2021-01-30 12:52:11', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('113', '51', '第1章 JSTL简介及环境搭建', '1', '0', '2021-01-30 13:06:06', '1', '2021-01-30 13:06:06', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('114', '51', '第2章 EL表达式配合使用JSTL', '1', '0', '2021-01-30 13:06:13', '1', '2021-01-30 13:06:13', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('115', '51', '第3章 JSTL核心标签的使用', '1', '0', '2021-01-30 13:06:19', '1', '2021-01-30 13:06:19', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('116', '51', '第4章 JSTL函数的使用', '1', '0', '2021-01-30 13:06:25', '1', '2021-01-30 13:06:25', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('117', '52', '第1章 Servlet基础', '1', '0', '2021-01-30 13:12:18', '1', '2021-01-30 13:12:18', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('118', '52', '第2章 应用MVC架构实现项目', '1', '0', '2021-01-30 13:12:24', '1', '2021-01-30 13:12:24', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('119', '53', '第1章 概述', '1', '0', '2021-02-05 14:25:52', '1', '2021-02-05 14:25:52', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('120', '53', '第2章 Spring IOC容器', '1', '0', '2021-02-05 14:26:00', '1', '2021-02-05 14:26:00', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('121', '53', '第3章 Spring Bean装配（上）', '1', '0', '2021-02-05 14:26:08', '1', '2021-02-05 14:26:08', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('122', '53', '第4章 Spring Bean装配（下）', '1', '0', '2021-02-05 14:26:19', '1', '2021-02-05 14:26:19', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('123', '53', '第5章 Spring AOP基本概念', '1', '0', '2021-02-05 14:26:28', '1', '2021-02-05 14:26:28', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('124', '53', '第6章 Spring对AspectJ的支持', '1', '0', '2021-02-05 14:26:36', '1', '2021-02-05 14:26:36', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('125', '54', '第1章 SpringMVC简介', '1', '0', '2021-02-05 19:13:58', '1', '2021-02-05 19:13:58', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('126', '54', '第2章 Spring MVC常用注解', '1', '0', '2021-02-05 19:14:08', '1', '2021-02-05 19:14:08', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('127', '54', '第3章 Spring MVC信息转化', '1', '0', '2021-02-05 19:14:18', '1', '2021-02-05 19:14:18', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('128', '55', '第1章 mybatis入门', '1', '0', '2021-02-06 09:01:38', '1', '2021-02-06 09:01:38', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('129', '55', '第2章 mybatis xml方式的基本用法', '1', '0', '2021-02-06 09:01:45', '1', '2021-02-06 09:01:45', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('130', '55', '第3章 mybatis注解方式的基本用法', '1', '0', '2021-02-06 09:01:53', '1', '2021-02-06 09:01:53', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('131', '55', '第4章 mybatis动态sql', '1', '0', '2021-02-06 09:02:00', '1', '2021-02-06 09:02:00', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('132', '55', '第5章 mybatis高级查询', '1', '0', '2021-02-06 09:02:08', '1', '2021-02-06 09:02:08', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('133', '55', '第6章 mybatis缓存配置', '1', '0', '2021-02-06 09:02:15', '1', '2021-02-06 09:02:15', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('134', '56', '第1章 maven快速入门', '1', '0', '2021-02-06 09:55:27', '1', '2021-02-06 09:55:27', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('135', '56', '第2章 Maven核心知识', '1', '0', '2021-02-06 09:55:35', '1', '2021-02-06 09:55:35', '1', '0', null);
INSERT INTO `edu_chapter` VALUES ('136', '59', '第1章 课程介绍', '1', '0', '2021-05-25 15:32:27', '2', '2021-05-26 08:02:15', '2', '0', null);
INSERT INTO `edu_chapter` VALUES ('137', '59', '第2章 前端框架搭建', '2', '0', '2021-05-25 15:34:23', '2', '2021-05-26 08:02:27', '2', '0', null);
INSERT INTO `edu_chapter` VALUES ('138', '59', '第3章 后端项目搭建', '3', '0', '2021-05-26 08:22:56', '2', '2021-05-26 08:22:56', '2', '0', null);

-- ----------------------------
-- Table structure for edu_course
-- ----------------------------
DROP TABLE IF EXISTS `edu_course`;
CREATE TABLE `edu_course` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '课程ID',
  `teacher_id` bigint(19) NOT NULL COMMENT '课程讲师ID',
  `subject_id` bigint(19) NOT NULL COMMENT '课程专业ID',
  `title` varchar(255) NOT NULL COMMENT '课程标题',
  `short_title` varchar(255) NOT NULL,
  `price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '课程销售价格，设置为0则可免费观看',
  `lesson_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '总课时',
  `cover` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '课程封面图片路径',
  `vip_count` bigint(10) NOT NULL DEFAULT '0' COMMENT 'VIP学员数量',
  `buy_count` bigint(10) unsigned NOT NULL DEFAULT '0' COMMENT '销售数量',
  `view_count` bigint(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览数量',
  `version` bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT '乐观锁',
  `status` varchar(10) NOT NULL DEFAULT 'Draft' COMMENT '视频状态 Draft未发布  Normal已发布',
  `difficulty` tinyint(2) DEFAULT '0' COMMENT '课程难易程度，0表示入门，1表示初级，2表示中级3，表示高级',
  `subject_parent_id` bigint(19) DEFAULT NULL,
  `course_type` tinyint(2) DEFAULT '0' COMMENT '课程类型 ，0表示新手入门，1表示免费好课，2表示技能提高3，表示实战',
  `course_desc` varchar(255) DEFAULT NULL COMMENT '课程描述',
  `download_link` varchar(255) DEFAULT NULL COMMENT '课程资源下载地址',
  `file_key` varchar(255) DEFAULT NULL,
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `create_by` bigint(20) DEFAULT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` text COMMENT '课程备注',
  `del_flag` tinyint(1) DEFAULT '0' COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  PRIMARY KEY (`id`),
  KEY `idx_title` (`title`) USING BTREE,
  KEY `idx_subject_id` (`subject_id`) USING BTREE,
  KEY `idx_teacher_id` (`teacher_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COMMENT='课程';

-- ----------------------------
-- Records of edu_course
-- ----------------------------
INSERT INTO `edu_course` VALUES ('4', '2', '22', 'Intellij IDEA开发工具使用基础入门教程', 'Intellij IDEA基础入门教程', '1.00', '14', 'http://xuedenedu.oss-cn-qingdao.aliyuncs.com/2020/09/06/career/ae128d26-c156-4195-8ea0-4c33a9c5987633.jpg', '0', '1', '65', '0', 'Normal', '0', '5', '0', 'Intellij IDEA开发工具使用基础入门教程', 'course/c4d34b63-09aa-40ee-9ef6-313e3d1de618-2021-02-07-4.zip', '5e3900cdb90d1e0c66bb95de094885c1', '2020-09-02 08:21:35', '1', '1', '2021-05-22 09:33:44', '<p>Intellij IDEA基础入门教程</p><figure class=\"image image_resized\" style=\"width:64.33%;\"><img src=\"http://alioss.xueden.cn/2021/03/30/career/9d47c472-e8bf-412a-a605-c99e085c400518.jpg\"></figure><p>&nbsp;</p><figure class=\"image image_resized\" style=\"width:62.5%;\"><img src=\"http://alioss.xueden.cn/2021/04/02/career/131bc3ae-19ed-4ea7-b39a-ab80c05efe0510.jpg\"></figure>', '0');
INSERT INTO `edu_course` VALUES ('34', '2', '8', 'java基础教程 第一季', 'java基础教程 第一季', '1.00', '43', 'http://alioss.xueden.cn/2021/01/24/career/238f4384-0b15-4fdf-a485-9ecf0f3e596a35.jpg', '0', '0', '6', '1', 'Normal', '0', '5', '0', 'java基础教程 第一季', null, null, '2021-01-23 19:29:18', '1', '1', '2021-05-22 09:56:42', '<p>java基础教程 第一季</p>', '0');
INSERT INTO `edu_course` VALUES ('35', '2', '8', 'Java基础教程 第二季', 'Java基础教程 第二季', '9.00', '25', 'http://alioss.xueden.cn/2021/01/28/career/7582ef8b-958c-4e10-90ea-1ee102299ba01.jpg', '0', '0', '0', '1', 'Normal', '0', '5', '0', 'Java基础教程 第二季', null, null, '2021-01-28 11:23:36', '1', '1', '2021-02-12 10:25:34', '<p>java基础 第二季</p>', '0');
INSERT INTO `edu_course` VALUES ('36', '2', '8', 'java基础教程 第三季', 'java基础教程 第三季', '9.00', '31', 'http://alioss.xueden.cn/2021/01/28/career/1a3d9656-a8fd-4dbc-8f0e-4a4a1d9b66de2.jpg', '0', '0', '0', '1', 'Normal', '0', '5', '0', 'java基础教程 第三季', null, null, '2021-01-28 13:15:17', '1', '1', '2021-02-12 10:26:52', '<p>java基础教程 第三季</p>', '0');
INSERT INTO `edu_course` VALUES ('37', '2', '21', 'Mysql入门教程 第一季', 'Mysql入门教程 第一季', '0.00', '46', 'http://alioss.xueden.cn/2021/01/28/career/459340dc-e489-4f4e-945b-6a53a4e658b51.jpg', '0', '0', '80', '1', 'Normal', '1', '7', '1', 'Mysql入门教程 第一季', null, null, '2021-01-28 18:51:01', '1', '1', '2021-02-12 10:27:56', '<p>Mysql入门教程 第一季</p>', '0');
INSERT INTO `edu_course` VALUES ('38', '2', '8', 'JUnit基础教程', 'JUnit基础教程', '0.00', '10', 'http://alioss.xueden.cn/2021/01/29/career/e8093e30-28a8-4a9b-bb02-c2954cb5e9062.jpg', '0', '0', '4', '1', 'Normal', '1', '5', '1', 'JUnit基础教程', null, null, '2021-01-29 15:40:00', '1', '1', '2021-02-17 19:18:22', '<p>JUnit基础教程</p>', '0');
INSERT INTO `edu_course` VALUES ('39', '2', '8', 'jdbc入门教程', 'jdbc入门教程', '0.00', '18', 'http://alioss.xueden.cn/2021/01/29/career/1755232e-dec5-43ed-96ca-1e17976f66953.jpg', '0', '0', '0', '1', 'Normal', '1', '5', '1', 'jdbc入门教程', null, null, '2021-01-29 18:13:58', '1', '1', '2021-02-12 10:30:45', '<p>jdbc入门教程</p>', '0');
INSERT INTO `edu_course` VALUES ('40', '2', '23', 'html5基础教程', 'html5基础教程', '0.00', '25', 'http://alioss.xueden.cn/2021/01/29/career/1722127d-f19b-447e-9207-f008c4eda90b4.jpg', '0', '0', '1', '1', 'Normal', '1', '6', '1', 'html5基础教程', null, null, '2021-01-29 19:46:17', '1', '1', '2021-02-12 10:31:46', '<p>html5基础教程</p>', '0');
INSERT INTO `edu_course` VALUES ('41', '2', '24', 'css3基础教程', 'css3基础教程', '0.00', '27', 'http://alioss.xueden.cn/2021/01/29/career/10225b9b-c948-4e7a-95ce-bf5e530064405.jpg', '0', '0', '5', '1', 'Normal', '1', '6', '1', 'css3基础教程', null, null, '2021-01-29 20:31:29', '1', '1', '2021-02-12 10:32:54', '<p>css3基础教程</p>', '0');
INSERT INTO `edu_course` VALUES ('42', '2', '24', 'css3基础教程 第二季', 'css3基础教程 第二季', '0.00', '29', 'http://alioss.xueden.cn/2021/01/29/career/3105e715-1e3e-4d6b-8d89-6488edd2a1546.jpg', '0', '0', '0', '1', 'Normal', '1', '6', '1', 'css3基础教程 第二季', null, null, '2021-01-29 21:03:16', '1', '1', '2021-02-12 10:34:20', '<p>css3基础教程 第二季</p>', '0');
INSERT INTO `edu_course` VALUES ('43', '2', '25', 'javascript基础教程', 'javascript基础教程', '0.00', '19', 'http://alioss.xueden.cn/2021/01/30/career/0cb7c738-c8e8-4e95-84cf-d56ad377aebc7.jpg', '0', '0', '0', '1', 'Normal', '1', '6', '1', 'javascript基础教程', null, null, '2021-01-30 08:21:31', '1', '1', '2021-02-12 10:35:28', '<p>javascript基础教程</p>', '0');
INSERT INTO `edu_course` VALUES ('44', '2', '26', 'jquery基础教程', 'jquery基础教程', '9.00', '26', 'http://alioss.xueden.cn/2021/01/30/career/5f05139a-ffcb-4980-8c69-77fca1477f5c8.jpg', '0', '0', '0', '1', 'Normal', '0', '6', '0', 'jquery基础教程', null, null, '2021-01-30 08:57:06', '1', '1', '2021-02-12 10:37:34', '<p>jquery基础教程</p>', '0');
INSERT INTO `edu_course` VALUES ('45', '2', '27', 'layui基础教程', 'layui基础教程', '9.00', '37', 'http://alioss.xueden.cn/2021/01/30/career/b959b827-20c7-4006-a8aa-aa554b7b91999.jpg', '0', '0', '1', '1', 'Normal', '1', '6', '0', 'layui基础教程', null, null, '2021-01-30 10:31:19', '1', '1', '2021-02-17 20:08:19', '<p>layui基础教程</p>', '0');
INSERT INTO `edu_course` VALUES ('46', '2', '8', 'jsp基础教程', 'jsp基础教程', '0.00', '41', 'http://alioss.xueden.cn/2021/01/30/career/3d87f042-c612-4e18-90e5-a80733ee9b5510.jpg', '0', '0', '0', '1', 'Normal', '1', '5', '1', 'jsp基础教程', null, null, '2021-01-30 10:35:27', '1', '1', '2021-02-12 10:39:41', '<p>jsp基础教程</p>', '0');
INSERT INTO `edu_course` VALUES ('47', '2', '28', 'Vue+ElementUI+SSM图书借阅管理系统', 'Vue+ElementUI+SSM图书借阅管理系统', '99.00', '89', 'http://alioss.xueden.cn/2021/01/30/career/87923402-9a3c-4f18-84e6-78de3a4b522e11.jpg', '0', '0', '122', '1', 'Normal', '2', '5', '3', 'Vue+ElementUI+SSM图书借阅管理系统', 'course/6c4017df-9887-457c-af0c-43085bf74f20-2021-02-07-47.zip', '2508e63af7f255ad2451f2b4a5d03b5e', '2021-01-30 10:45:32', '1', '1', '2021-02-19 10:02:56', '<p>Vue+ElementUI+SSM图书借阅管理系统</p>', '0');
INSERT INTO `edu_course` VALUES ('48', '2', '28', 'spring+springMVC+mybatis+jsp整合在线选课系统', '基于ssm+jsp整合在线选课系统', '99.00', '56', 'http://alioss.xueden.cn/2021/01/30/career/aed2c204-14b6-4d4e-815a-f1e630db0b9e12.jpg', '0', '1', '15', '1', 'Normal', '2', '5', '3', 'spring+springMVC+mybatis+jsp整合在线选课系统', null, null, '2021-01-30 12:26:29', '1', '1', '2021-02-14 09:31:40', '<p>spring+springMVC+mybatis+jsp整合在线选课系统</p>', '0');
INSERT INTO `edu_course` VALUES ('49', '2', '11', '基于springboot+mybatisplus+shiro+layui整合的前后端分离权限管理系统', '基于springboot+layui整合的前后端分离权限管理系统', '199.00', '89', 'http://alioss.xueden.cn/2021/01/30/career/3fad21ef-a55d-46e4-bd41-d9c57aca253613.jpg', '0', '1', '33', '1', 'Normal', '2', '5', '3', '基于springboot+mybatisplus+shiro+layui整合的前后端分离权限管理系统', 'course/92b7b7ed-e328-4021-92b0-d05c7e18cbe3-2021-02-07-49.zip', '2508e63af7f255ad2451f2b4a5d03b5e', '2021-01-30 12:35:20', '1', '1', '2021-02-19 10:03:07', '<p>基于springboot+mybatisplus+shiro+layui整合的前后端分离权限管理系统</p>', '0');
INSERT INTO `edu_course` VALUES ('50', '2', '11', '基于SpringBoot+Jpa+JWT+Spring Security+Vue+ElementUI前后端分离后台管理系统', '基于SpringBoot2.x+Vue2.x前后端分离后台管理系统', '1.00', '136', 'http://alioss.xueden.cn/2021/01/30/career/f391fc45-0968-49f3-a3b1-341e3b7cc3f714.jpg', '0', '2', '102', '1', 'Normal', '2', '5', '3', '基于SpringBoot+Jpa+JWT+Spring Security+Vue+ElementUI前后端分离后台管理系统', null, null, '2021-01-30 12:49:55', '1', '1', '2021-05-22 20:20:27', '<p>基于SpringBoot+Jpa+JWT+Spring Security+Vue+ElementUI前后端分离后台管理系统</p>', '0');
INSERT INTO `edu_course` VALUES ('51', '2', '8', 'jsp常用标签', 'jsp常用标签', '9.00', '21', 'http://alioss.xueden.cn/2021/01/30/career/cac094db-ce23-4abd-bd12-b0078a5dd21715.jpg', '0', '0', '0', '1', 'Normal', '1', '5', '0', 'jsp常用标签', null, null, '2021-01-30 13:05:37', '1', '1', '2021-02-12 10:50:02', '<p>jsp常用标签</p>', '0');
INSERT INTO `edu_course` VALUES ('52', '2', '8', 'servlet基础教程', 'servlet基础教程', '9.00', '26', 'http://alioss.xueden.cn/2021/01/30/career/bdd6b324-8488-4e5b-8a7d-28dbabf7c1b216.jpg', '0', '0', '0', '1', 'Normal', '1', '5', '0', 'servlet基础教程', null, null, '2021-01-30 13:11:57', '1', '1', '2021-02-12 10:51:21', '<p>servlet基础教程</p>', '0');
INSERT INTO `edu_course` VALUES ('53', '2', '28', 'spring基础教程', 'spring基础教程', '19.00', '34', 'http://alioss.xueden.cn/2021/01/30/career/9aefc9b8-8b33-43b1-b526-d86a73fb6aab17.jpg', '0', '0', '3', '1', 'Normal', '1', '5', '2', 'spring基础教程', null, null, '2021-01-30 13:17:47', '1', '1', '2021-02-17 20:18:12', '<p>spring基础教程</p>', '0');
INSERT INTO `edu_course` VALUES ('54', '2', '28', 'springMVC基础教程', 'springMVC基础教程', '19.00', '22', 'http://alioss.xueden.cn/2021/01/30/career/e8d7866b-9027-4711-a2f4-4ab282f1795118.jpg', '0', '0', '1', '1', 'Normal', '1', '5', '2', 'springMVC基础教程', null, null, '2021-01-30 13:23:42', '1', '1', '2021-02-12 10:54:15', '<p>springMVC基础教程</p>', '0');
INSERT INTO `edu_course` VALUES ('55', '2', '28', 'mybatis基础教程', 'mybatis基础教程', '19.00', '49', 'http://alioss.xueden.cn/2021/01/30/career/ea1a3868-c22d-450f-b2c7-413e132349eb19.jpg', '0', '0', '1', '1', 'Normal', '1', '5', '2', 'mybatis基础教程', null, null, '2021-01-30 14:59:31', '1', '1', '2021-02-14 21:26:25', '<p>mybatis基础教程</p>', '0');
INSERT INTO `edu_course` VALUES ('56', '2', '28', 'maven基础教程', 'maven基础教程', '19.00', '9', 'http://alioss.xueden.cn/2021/01/30/career/aed2c204-14b6-4d4e-815a-f1e630db0b9e12.jpg', '0', '0', '0', '1', 'Draft', '1', '5', '2', 'maven基础教程', null, null, '2021-01-30 15:02:47', '2', '2', '2021-05-23 20:42:38', '<p>maven基础教程</p>', '0');
INSERT INTO `edu_course` VALUES ('58', '2', '11', '这是一个非常好的课程', '这是一个非常好的课程', '1.00', '1', 'http://alioss.xueden.cn/2021/01/30/career/aed2c204-14b6-4d4e-815a-f1e630db0b9e12.jpg', '0', '0', '0', '1', 'Draft', '2', '5', '2', '这是一个非常好的课程', null, null, '2021-05-23 20:32:17', '2', '2', '2021-05-23 20:32:17', '', '0');
INSERT INTO `edu_course` VALUES ('59', '2', '11', '基于ssm整合的图书管理系统', '基于ssm整合的图书管理系统', '1.00', '1', 'http://alioss.xueden.cn/2021/01/30/career/aed2c204-14b6-4d4e-815a-f1e630db0b9e12.jpg', '0', '0', '0', '1', 'Draft', '2', '5', '2', '基于ssm整合的图书管理系统', null, null, '2021-05-23 20:37:38', '2', '2', '2021-05-24 08:45:39', '<p>还不错的项目</p><p><img src=\"http://alioss.xueden.cn/2021/05/24/career/0c4805b7-3c95-4516-80d5-76372d16587618.jpg\" style=\"max-width:100%;\" width=\"783\" height=\"439.89\"><br></p>', '0');

-- ----------------------------
-- Table structure for edu_daily_report
-- ----------------------------
DROP TABLE IF EXISTS `edu_daily_report`;
CREATE TABLE `edu_daily_report` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL COMMENT '创建日期',
  `date` varchar(100) NOT NULL DEFAULT '' COMMENT '日期',
  `income_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '收入金额',
  `order_num` int(10) NOT NULL DEFAULT '0' COMMENT '订单数量',
  `day_no` varchar(100) NOT NULL DEFAULT '' COMMENT '天号',
  `teacher_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '讲师ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COMMENT='每日统计讲师收益和订单表';

-- ----------------------------
-- Records of edu_daily_report
-- ----------------------------
INSERT INTO `edu_daily_report` VALUES ('1', '2021-05-01 20:23:34', '2021-05-01', '1500.00', '3', '1日', '2');
INSERT INTO `edu_daily_report` VALUES ('2', '2021-05-02 20:24:23', '2021-05-02', '1600.00', '7', '2日', '2');
INSERT INTO `edu_daily_report` VALUES ('3', '2021-05-03 20:25:02', '2021-05-03', '1400.00', '5', '3日', '2');
INSERT INTO `edu_daily_report` VALUES ('4', '2021-05-04 20:25:39', '2021-05-04', '1700.00', '9', '4日', '2');
INSERT INTO `edu_daily_report` VALUES ('5', '2021-05-05 20:26:05', '2021-05-05', '2000.00', '10', '5日', '2');
INSERT INTO `edu_daily_report` VALUES ('6', '2021-05-06 20:26:37', '2021-05-06', '1900.00', '8', '6日', '2');
INSERT INTO `edu_daily_report` VALUES ('7', '2021-05-07 20:27:00', '2021-05-07', '2100.00', '11', '7日', '2');
INSERT INTO `edu_daily_report` VALUES ('8', '2021-05-08 20:27:28', '2021-05-08', '2200.00', '12', '8日', '2');
INSERT INTO `edu_daily_report` VALUES ('9', '2021-04-01 20:23:34', '2021-04-01', '1000.00', '5', '1日', '2');
INSERT INTO `edu_daily_report` VALUES ('10', '2021-04-02 20:24:23', '2021-04-02', '1800.00', '6', '2日', '2');
INSERT INTO `edu_daily_report` VALUES ('11', '2021-04-03 20:25:02', '2021-04-03', '1900.00', '9', '3日', '2');
INSERT INTO `edu_daily_report` VALUES ('12', '2021-04-04 20:25:39', '2021-04-04', '1100.00', '12', '4日', '2');
INSERT INTO `edu_daily_report` VALUES ('13', '2021-04-05 20:26:05', '2021-04-05', '1000.00', '5', '5日', '2');
INSERT INTO `edu_daily_report` VALUES ('14', '2021-04-06 20:26:37', '2021-04-06', '2900.00', '3', '6日', '2');
INSERT INTO `edu_daily_report` VALUES ('15', '2021-04-07 20:27:00', '2021-04-07', '1100.00', '7', '7日', '2');
INSERT INTO `edu_daily_report` VALUES ('16', '2021-04-08 20:27:28', '2021-04-08', '3200.00', '8', '8日', '2');

-- ----------------------------
-- Table structure for edu_deal_money
-- ----------------------------
DROP TABLE IF EXISTS `edu_deal_money`;
CREATE TABLE `edu_deal_money` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(255) NOT NULL COMMENT '订单编号',
  `member_id` bigint(20) NOT NULL COMMENT '会员ID',
  `price` decimal(10,2) NOT NULL COMMENT '成交金额',
  `buy_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0表示普通用户购买，1表示VIP用户购买',
  `pay_channel` varchar(100) DEFAULT NULL COMMENT '支付渠道wxpay表示微信，alipay表示支付宝',
  `country` varchar(255) DEFAULT NULL COMMENT '国家或地区',
  `area` varchar(255) DEFAULT NULL COMMENT '区域',
  `province` varchar(255) DEFAULT NULL COMMENT '所属省份',
  `city` varchar(255) DEFAULT NULL COMMENT '城市',
  `isp` varchar(255) DEFAULT NULL COMMENT '网络服务提供商',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `create_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `del_flag` tinyint(2) DEFAULT '0' COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COMMENT='成交金额汇总表';

-- ----------------------------
-- Records of edu_deal_money
-- ----------------------------
INSERT INTO `edu_deal_money` VALUES ('1', '2021020900001000860020112039', '26', '199.00', '1', 'wxpay', null, null, null, null, null, '2021-02-09 20:12:09', '26', '2021-02-09 20:12:09', '26', '0', '会员购买【基于springboot+mybatisplus+shiro+layui整合的前后端分离权限管理系统】课程');
INSERT INTO `edu_deal_money` VALUES ('3', '2021020900001000660020144547', '26', '99.00', '1', 'wxpay', null, null, null, null, null, '2021-02-09 20:15:02', '26', '2021-02-09 20:15:02', '26', '0', '会员购买【spring+springMVC+mybatis+jsp整合在线选课系统】课程');
INSERT INTO `edu_deal_money` VALUES ('4', '2021021000001000410022133560', '26', '99.00', '2', 'wxpay', '中国', '华南', '广西壮族自治区', '北海市', '电信', '2021-02-10 22:14:24', '26', '2021-02-10 22:14:24', '26', '0', '用户加入VIP【铜牌会员】');
INSERT INTO `edu_deal_money` VALUES ('5', '2021052200001000260009331025', '26', '1.00', '1', 'wxpay', '内网IP', '0', '0', '内网IP', '内网IP', '2021-05-22 09:33:44', '26', '2021-05-22 09:33:44', '26', '0', '会员购买【Intellij IDEA开发工具使用基础入门教程】课程');
INSERT INTO `edu_deal_money` VALUES ('6', '2021052200001000440009413613', '26', '1.00', '1', 'wxpay', '内网IP', '0', '0', '内网IP', '内网IP', '2021-05-22 09:42:03', '26', '2021-05-22 09:42:03', '26', '0', '会员购买【基于SpringBoot+Jpa+JWT+Spring Security+Vue+ElementUI前后端分离后台管理系统】课程');
INSERT INTO `edu_deal_money` VALUES ('7', '2021052200001000180017062770', '26', '1.00', '1', 'alipay', '内网IP', '0', '0', '内网IP', '内网IP', '2021-05-22 17:06:48', '26', '2021-05-22 17:06:48', '26', '0', '会员购买【基于SpringBoot+Jpa+JWT+Spring Security+Vue+ElementUI前后端分离后台管理系统】课程');
INSERT INTO `edu_deal_money` VALUES ('8', '2021052200001000570020094842', '26', '1.00', '2', 'wxpay', '内网IP', '0', '0', '内网IP', '内网IP', '2021-05-22 20:11:03', '26', '2021-05-22 20:11:03', '26', '0', '用户加入VIP【铜牌会员】');
INSERT INTO `edu_deal_money` VALUES ('9', '2021052200001000090020133856', '26', '1.00', '3', 'alipay', '内网IP', '0', '0', '内网IP', '内网IP', '2021-05-22 20:14:06', '26', '2021-05-22 20:14:06', '26', '0', '用户加入VIP【银牌会员】');
INSERT INTO `edu_deal_money` VALUES ('10', '2021052200001000780020223236', '26', '1.00', '4', 'wxpay', '内网IP', '0', '0', '内网IP', '内网IP', '2021-05-22 20:23:03', '26', '2021-05-22 20:23:03', '26', '0', '用户加入VIP【金牌会员】');
INSERT INTO `edu_deal_money` VALUES ('11', '2021052200001000390020274229', '26', '1.00', '5', 'alipay', '内网IP', '0', '0', '内网IP', '内网IP', '2021-05-22 20:28:08', '26', '2021-05-22 20:28:08', '26', '0', '用户加入VIP【钻石会员】');

-- ----------------------------
-- Table structure for edu_environmen_param
-- ----------------------------
DROP TABLE IF EXISTS `edu_environmen_param`;
CREATE TABLE `edu_environmen_param` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '参数名称',
  `value` varchar(255) NOT NULL COMMENT '参数值',
  `course_id` varchar(64) NOT NULL COMMENT '课程ID',
  `create_date` datetime DEFAULT NULL,
  `create_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT '0' COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=736 DEFAULT CHARSET=utf8mb4 COMMENT='环境参数表';

-- ----------------------------
-- Records of edu_environmen_param
-- ----------------------------
INSERT INTO `edu_environmen_param` VALUES ('621', 'Tomcat', '8.0及以上的都行', '4', '2021-02-11 20:50:51', '1', '2021-04-02 21:28:18', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('622', 'JDK', '1.8', '4', '2021-02-11 21:01:21', '1', '2021-04-02 21:28:18', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('623', '开发工具', 'IntelliJ IDEA ', '4', '2021-02-12 10:01:55', '1', '2021-04-02 21:28:18', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('624', '开发工具', 'IntelliJ IDEA ', '34', '2021-02-12 10:22:26', '1', '2021-02-12 10:22:26', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('625', 'JDK', '1.8及以上', '34', '2021-02-12 10:22:26', '1', '2021-02-12 10:22:26', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('626', 'MySQL', '5.7', '34', '2021-02-12 10:22:26', '1', '2021-02-12 10:22:26', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('627', 'Tomcat', '8.0及以上', '34', '2021-02-12 10:22:26', '1', '2021-02-12 10:22:26', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('628', '开发工具', 'IntelliJ IDEA', '35', '2021-02-12 10:25:34', '1', '2021-02-12 10:25:34', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('629', 'JDK', '1.8及以上', '35', '2021-02-12 10:25:34', '1', '2021-02-12 10:25:34', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('630', 'MySQL', '5.7', '35', '2021-02-12 10:25:34', '1', '2021-02-12 10:25:34', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('631', 'Tomcat', '8.0及以上', '35', '2021-02-12 10:25:34', '1', '2021-02-12 10:25:34', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('632', '开发工具', 'IntelliJ IDEA', '36', '2021-02-12 10:26:52', '1', '2021-02-12 10:26:52', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('633', 'JDK', '1.8', '36', '2021-02-12 10:26:52', '1', '2021-02-12 10:26:52', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('634', 'MySQL', '5.7', '36', '2021-02-12 10:26:52', '1', '2021-02-12 10:26:52', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('635', 'Tomcat', '8.0及以上', '36', '2021-02-12 10:26:52', '1', '2021-02-12 10:26:52', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('636', '开发工具', 'IntelliJ IDEA', '37', '2021-02-12 10:27:56', '1', '2021-02-12 10:27:56', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('637', 'JDK', '1.8', '37', '2021-02-12 10:27:56', '1', '2021-02-12 10:27:56', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('638', 'MySQL', '5.7', '37', '2021-02-12 10:27:56', '1', '2021-02-12 10:27:56', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('639', 'Tomcat', '8.0及以上', '37', '2021-02-12 10:27:56', '1', '2021-02-12 10:27:56', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('640', '开发工具', 'IntelliJ IDEA ', '38', '2021-02-12 10:29:02', '1', '2021-02-12 10:29:02', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('641', 'JDK', '1.8', '38', '2021-02-12 10:29:02', '1', '2021-02-12 10:29:02', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('642', 'MySQL', '5.7', '38', '2021-02-12 10:29:02', '1', '2021-02-12 10:29:02', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('643', 'Tomcat', '8.0及以上', '38', '2021-02-12 10:29:02', '1', '2021-02-12 10:29:02', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('644', '开发工具', 'IntelliJ IDEA', '39', '2021-02-12 10:30:45', '1', '2021-02-12 10:30:45', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('645', 'JDK', '1.8', '39', '2021-02-12 10:30:45', '1', '2021-02-12 10:30:45', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('646', 'MySQL', '5.7', '39', '2021-02-12 10:30:45', '1', '2021-02-12 10:30:45', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('647', 'Tomcat', '8.0及以上', '39', '2021-02-12 10:30:45', '1', '2021-02-12 10:30:45', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('648', '开发工具', 'IntelliJ IDEA', '40', '2021-02-12 10:31:46', '1', '2021-02-12 10:31:46', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('649', 'JDK', '1.8', '40', '2021-02-12 10:31:46', '1', '2021-02-12 10:31:46', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('650', 'MySQL', '5.7', '40', '2021-02-12 10:31:46', '1', '2021-02-12 10:31:46', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('651', 'Tomcat', '8.0及以上', '40', '2021-02-12 10:31:46', '1', '2021-02-12 10:31:46', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('652', '开发工具', 'IntelliJ IDEA', '41', '2021-02-12 10:32:54', '1', '2021-02-12 10:32:54', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('653', 'JDK', '1.8', '41', '2021-02-12 10:32:54', '1', '2021-02-12 10:32:54', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('654', 'MySQL', '5.7', '41', '2021-02-12 10:32:54', '1', '2021-02-12 10:32:54', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('655', 'Tomcat', '8.0及以上', '41', '2021-02-12 10:32:54', '1', '2021-02-12 10:32:54', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('656', '开发工具', 'IntelliJ IDEA', '42', '2021-02-12 10:34:20', '1', '2021-02-12 10:34:20', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('657', 'JDK', '1.8', '42', '2021-02-12 10:34:20', '1', '2021-02-12 10:34:20', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('658', 'MySQL', '5.7', '42', '2021-02-12 10:34:20', '1', '2021-02-12 10:34:20', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('659', 'Tomcat', '8.0及以上', '42', '2021-02-12 10:34:20', '1', '2021-02-12 10:34:20', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('660', '开发工具', 'IntelliJ IDEA ', '43', '2021-02-12 10:35:28', '1', '2021-02-12 10:35:28', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('661', 'JDK', '1.8', '43', '2021-02-12 10:35:28', '1', '2021-02-12 10:35:28', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('662', 'MySQL', '5.7', '43', '2021-02-12 10:35:28', '1', '2021-02-12 10:35:28', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('663', 'Tomcat', '8.0及以上', '43', '2021-02-12 10:35:28', '1', '2021-02-12 10:35:28', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('664', '开发工具', 'IntelliJ IDEA', '44', '2021-02-12 10:37:34', '1', '2021-02-12 10:37:34', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('665', 'JDK', '1.8', '44', '2021-02-12 10:37:34', '1', '2021-02-12 10:37:34', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('666', 'MySQL', '5.7', '44', '2021-02-12 10:37:34', '1', '2021-02-12 10:37:34', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('667', 'Tomcat', '8.0及以上', '44', '2021-02-12 10:37:34', '1', '2021-02-12 10:37:34', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('668', '开发工具', 'IntelliJ IDEA', '45', '2021-02-12 10:38:40', '1', '2021-02-12 10:38:40', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('669', 'JDK', '1.8', '45', '2021-02-12 10:38:40', '1', '2021-02-12 10:38:40', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('670', 'MySQL', '5.7', '45', '2021-02-12 10:38:40', '1', '2021-02-12 10:38:40', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('671', 'Tomcat', '8.0及以上', '45', '2021-02-12 10:38:40', '1', '2021-02-12 10:38:40', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('672', '开发工具', 'IntelliJ IDEA', '46', '2021-02-12 10:39:41', '1', '2021-02-12 10:39:41', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('673', 'JDK', '1.8', '46', '2021-02-12 10:39:41', '1', '2021-02-12 10:39:41', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('674', 'MySQL', '5.7', '46', '2021-02-12 10:39:41', '1', '2021-02-12 10:39:41', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('675', 'Tomcat', '8.0及以上', '46', '2021-02-12 10:39:41', '1', '2021-02-12 10:39:41', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('676', '开发工具', 'IntelliJ IDEA ', '47', '2021-02-12 10:41:18', '1', '2021-02-12 10:41:18', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('677', '后端框架', 'ssm', '47', '2021-02-12 10:41:18', '1', '2021-02-12 10:41:18', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('678', '前端框架', 'Vue+ElementUI', '47', '2021-02-12 10:41:18', '1', '2021-02-12 10:41:18', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('679', 'JDK', '1.8', '47', '2021-02-12 10:41:18', '1', '2021-02-12 10:41:18', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('680', 'MySQL', '5.7', '47', '2021-02-12 10:41:18', '1', '2021-02-12 10:41:18', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('681', 'Tomcat', '8.0及以上', '47', '2021-02-12 10:41:18', '1', '2021-02-12 10:41:18', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('682', '开发工具', 'IntelliJ IDEA', '48', '2021-02-12 10:43:06', '1', '2021-02-12 10:43:06', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('683', '后端框架', 'ssm', '48', '2021-02-12 10:43:06', '1', '2021-02-12 10:43:06', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('684', 'JDK', '1.8', '48', '2021-02-12 10:43:06', '1', '2021-02-12 10:43:06', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('685', 'MySQL', '5.7', '48', '2021-02-12 10:43:06', '1', '2021-02-12 10:43:06', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('686', 'Tomcat', '8.0及以上', '48', '2021-02-12 10:43:06', '1', '2021-02-12 10:43:06', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('687', '开发工具', 'IntelliJ IDEA', '49', '2021-02-12 10:45:24', '1', '2021-02-12 10:45:24', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('688', '后端框架', 'springboot+mybatisplus+shiro', '49', '2021-02-12 10:45:24', '1', '2021-02-12 10:45:24', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('689', '前端框架', 'layui', '49', '2021-02-12 10:45:24', '1', '2021-02-12 10:45:24', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('690', 'JDK', '1.8', '49', '2021-02-12 10:45:24', '1', '2021-02-12 10:45:24', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('691', 'MySQL', '5.7', '49', '2021-02-12 10:45:24', '1', '2021-02-12 10:45:24', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('692', 'Maven', '3.3.9', '49', '2021-02-12 10:45:24', '1', '2021-02-12 10:45:24', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('693', '开发工具', 'IntelliJ IDEA', '50', '2021-02-12 10:47:21', '1', '2021-02-12 10:47:21', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('694', '后端框架', 'SpringBoot+Jpa+JWT+Spring Security', '50', '2021-02-12 10:47:21', '1', '2021-02-12 10:47:21', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('695', '前端框架', 'Vue CLI 4.1.1+Vue+ElementUI', '50', '2021-02-12 10:47:21', '1', '2021-02-12 10:47:21', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('696', 'JDK', '1.8', '50', '2021-02-12 10:47:21', '1', '2021-02-12 10:47:21', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('697', 'MySQL', '5.7', '50', '2021-02-12 10:47:21', '1', '2021-02-12 10:47:21', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('698', 'Maven', '3.3.9', '50', '2021-02-12 10:47:21', '1', '2021-02-12 10:47:21', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('699', '开发工具', 'IntelliJ IDEA', '51', '2021-02-12 10:50:02', '1', '2021-02-12 10:50:02', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('700', 'JDK', '1.8', '51', '2021-02-12 10:50:02', '1', '2021-02-12 10:50:02', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('701', 'Tomcat', '8.0及以上', '51', '2021-02-12 10:50:02', '1', '2021-02-12 10:50:02', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('702', '后端技术', 'jsp', '51', '2021-02-12 10:50:02', '1', '2021-02-12 10:50:02', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('703', '开发工具', 'IntelliJ IDEA', '52', '2021-02-12 10:51:21', '1', '2021-02-12 10:51:21', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('704', 'JDK', ' 1.8', '52', '2021-02-12 10:51:21', '1', '2021-02-12 10:51:21', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('705', 'Tomcat', '8.0及以上', '52', '2021-02-12 10:51:21', '1', '2021-02-12 10:51:21', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('706', '后端技术', 'servlet', '52', '2021-02-12 10:51:21', '1', '2021-02-12 10:51:21', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('707', '开发工具', 'IntelliJ IDEA', '53', '2021-02-12 10:52:58', '1', '2021-02-12 10:52:58', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('708', '后端框架', 'spring', '53', '2021-02-12 10:52:58', '1', '2021-02-12 10:52:58', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('709', 'JDK', '1.8', '53', '2021-02-12 10:52:58', '1', '2021-02-12 10:52:58', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('710', 'Maven', '3.3.9', '53', '2021-02-12 10:52:58', '1', '2021-02-12 10:52:58', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('711', 'Tomcat', '8.0及以上', '53', '2021-02-12 10:52:58', '1', '2021-02-12 10:52:58', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('712', '开发工具', 'IntelliJ IDEA', '54', '2021-02-12 10:54:15', '1', '2021-02-12 10:54:15', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('713', '后端框架', 'spring MVC', '54', '2021-02-12 10:54:15', '1', '2021-02-12 10:54:15', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('714', 'JDK', '1.8', '54', '2021-02-12 10:54:15', '1', '2021-02-12 10:54:15', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('715', 'Maven', '3.3.9', '54', '2021-02-12 10:54:15', '1', '2021-02-12 10:54:15', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('716', 'Tomcat', '8.0及以上', '54', '2021-02-12 10:54:15', '1', '2021-02-12 10:54:15', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('717', '开发工具', 'IntelliJ IDEA', '55', '2021-02-12 10:55:22', '1', '2021-02-12 10:55:22', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('718', 'JDK', '1.8', '55', '2021-02-12 10:55:22', '1', '2021-02-12 10:55:22', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('719', 'Maven', 'mybatis', '55', '2021-02-12 10:55:22', '1', '2021-02-12 10:55:22', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('720', 'Tomcat', '8.0及以上', '55', '2021-02-12 10:55:22', '1', '2021-02-12 10:55:22', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('721', '开发工具', 'IntelliJ IDEA', '56', '2021-02-12 10:56:43', '1', '2021-02-12 10:56:43', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('722', 'JDK', '1.8', '56', '2021-02-12 10:56:43', '1', '2021-02-12 10:56:43', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('723', 'Maven', '3.3.9', '56', '2021-02-12 10:56:43', '1', '2021-02-12 10:56:43', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('724', 'Tomcat', '8.0及以上', '56', '2021-02-12 10:56:43', '1', '2021-02-12 10:56:43', '1', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('731', '数据库', 'mysql5.7', '59', '2021-05-24 13:51:32', '2', '2021-05-24 20:05:52', '2', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('732', 'jdk', '1.8', '59', '2021-05-24 13:59:11', '2', '2021-05-24 20:05:52', '2', '0', null);
INSERT INTO `edu_environmen_param` VALUES ('733', '测试1', '测试1', '59', '2021-05-24 19:44:59', '2', '2021-05-24 19:44:59', '2', '1', null);
INSERT INTO `edu_environmen_param` VALUES ('734', '测试2', '测试2', '59', '2021-05-24 19:44:59', '2', '2021-05-24 19:44:59', '2', '1', null);
INSERT INTO `edu_environmen_param` VALUES ('735', 'maven', '3.5', '59', '2021-05-24 20:05:52', '2', '2021-05-24 20:05:52', '2', '0', null);

-- ----------------------------
-- Table structure for edu_income_details
-- ----------------------------
DROP TABLE IF EXISTS `edu_income_details`;
CREATE TABLE `edu_income_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `member_id` bigint(20) NOT NULL COMMENT '购买者ID',
  `teacher_id` bigint(20) NOT NULL COMMENT '讲师ID',
  `order_no` varchar(255) NOT NULL COMMENT '订单编号',
  `course_id` bigint(20) NOT NULL COMMENT '课程ID',
  `price` decimal(10,2) NOT NULL COMMENT '课程价格',
  `income` decimal(10,2) NOT NULL COMMENT '课程收益',
  `create_date` datetime DEFAULT NULL,
  `create_by` bigint(20) DEFAULT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `remarks` text CHARACTER SET utf8mb4,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='讲师收益记录表';

-- ----------------------------
-- Records of edu_income_details
-- ----------------------------
INSERT INTO `edu_income_details` VALUES ('1', '23', '2', '2021052200001000180017062770', '59', '200.00', '100.00', '2021-05-26 19:53:04', '2', '2', '2021-05-26 19:53:13', '0', '看看那');

-- ----------------------------
-- Table structure for edu_keyword
-- ----------------------------
DROP TABLE IF EXISTS `edu_keyword`;
CREATE TABLE `edu_keyword` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '关键词',
  `num` int(11) DEFAULT NULL COMMENT '搜索次数',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_by` bigint(20) DEFAULT '0',
  `del_flag` smallint(1) DEFAULT '0' COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=437 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of edu_keyword
-- ----------------------------
INSERT INTO `edu_keyword` VALUES ('431', 'vue', '10', '2021-02-17 17:05:15', null, '2021-02-17 19:26:46', null, '0', null);
INSERT INTO `edu_keyword` VALUES ('432', '第一季', '5', '2021-02-17 17:06:16', null, '2021-02-17 19:17:06', null, '0', null);
INSERT INTO `edu_keyword` VALUES ('433', 'java', '4', '2021-02-17 17:06:31', null, '2021-02-17 19:17:43', null, '0', null);
INSERT INTO `edu_keyword` VALUES ('434', 'ssm', '3', '2021-02-17 17:06:36', null, '2021-02-17 19:06:35', null, '0', null);
INSERT INTO `edu_keyword` VALUES ('435', '图书管理系统', '5', '2021-02-17 17:06:47', null, '2021-02-17 19:06:38', null, '0', null);
INSERT INTO `edu_keyword` VALUES ('436', '图书', '13', '2021-02-17 18:25:28', null, '2021-02-17 19:05:04', null, '0', null);

-- ----------------------------
-- Table structure for edu_member
-- ----------------------------
DROP TABLE IF EXISTS `edu_member`;
CREATE TABLE `edu_member` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '会员id',
  `openid` varchar(128) DEFAULT NULL COMMENT '微信openid',
  `mobile` varchar(20) NOT NULL COMMENT '手机号',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `nickname` varchar(50) DEFAULT NULL COMMENT '昵称',
  `email` varchar(100) DEFAULT NULL COMMENT '电子邮箱',
  `sex` tinyint(2) unsigned DEFAULT NULL COMMENT '性别 1 女，2 男',
  `avatar` varchar(255) DEFAULT NULL COMMENT '用户头像',
  `sign` varchar(100) DEFAULT NULL COMMENT '用户签名',
  `is_teacher` tinyint(1) DEFAULT '0' COMMENT '是否讲师，0否，1是',
  `teacher_id` bigint(20) DEFAULT NULL COMMENT '讲师ID',
  `vip_id` bigint(20) DEFAULT NULL COMMENT '会员类别ID',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL,
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `create_by` bigint(20) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`,`mobile`),
  UNIQUE KEY `mobile` (`mobile`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COMMENT='会员表';

-- ----------------------------
-- Records of edu_member
-- ----------------------------
INSERT INTO `edu_member` VALUES ('23', null, '13733619007', '$2a$10$ue/33ZZsVp0666IitLsITueJMcClks4xmoSnfac.tPuAsMDEFfSry', '学灯网', null, '1', 'http://java.goodym.cn/touxiang.png', null, '0', '0', '2', '2021-02-10 22:14:24', null, '2020-09-11 13:39:14', null, null, '0');
INSERT INTO `edu_member` VALUES ('25', null, '13733619008', '$2a$10$4Ia/QBz1y9KcHIRGewW46.lkFElhEXDAGP6XQT5wOBSq5qqmdQxJC', '墨鱼课堂', null, '0', 'http://www.xueden.cn/128.png', null, '0', '0', '1', '2020-09-23 07:47:11', null, '2020-09-23 07:47:11', null, null, '1');
INSERT INTO `edu_member` VALUES ('26', null, '15011975772', '$2a$10$POqJi09on0suqaSsWL8wTeA9yedeLoTV4TOdmPGirwe5Wf/nw6iaW', '墨鱼老师', '11184629@qq.com', '2', 'http://www.xueden.cn/128.png', 'java软件开发工程师', '1', '5', '5', '2021-05-29 09:31:25', '26', '2021-02-18 08:44:49', null, null, '0');

-- ----------------------------
-- Table structure for edu_member_buy_course
-- ----------------------------
DROP TABLE IF EXISTS `edu_member_buy_course`;
CREATE TABLE `edu_member_buy_course` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(255) NOT NULL COMMENT '订单编号',
  `course_id` bigint(20) NOT NULL COMMENT '课程ID',
  `member_id` bigint(20) NOT NULL COMMENT '会员ID',
  `teacher_id` bigint(20) DEFAULT '0' COMMENT '讲师ID',
  `price` decimal(10,2) NOT NULL COMMENT '购买金额',
  `is_payment` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否付款，0表示未付款，1表示已付款，2表示已退款',
  `buy_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0表示普通用户购买，1表示VIP用户购买',
  `pay_channel` varchar(100) DEFAULT NULL COMMENT '支付渠道wxpay表示微信，alipay表示支付宝',
  `country` varchar(255) DEFAULT NULL COMMENT '国家或地区',
  `area` varchar(255) DEFAULT NULL COMMENT '区域',
  `province` varchar(255) DEFAULT NULL COMMENT '所属省份',
  `city` varchar(255) DEFAULT NULL COMMENT '城市',
  `isp` varchar(255) DEFAULT NULL COMMENT '网络服务提供商',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `create_by` bigint(20) DEFAULT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `del_flag` tinyint(1) DEFAULT '0' COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of edu_member_buy_course
-- ----------------------------
INSERT INTO `edu_member_buy_course` VALUES ('9', '2021052200001000260009331025', '4', '26', '2', '1.00', '1', '1', 'wxpay', '内网IP', '0', '0', '内网IP', '内网IP', '2021-05-22 07:28:48', '26', '26', '2021-05-22 09:33:44', '会员购买【Intellij IDEA开发工具使用基础入门教程】课程', '0');
INSERT INTO `edu_member_buy_course` VALUES ('12', '2021052200001000920009382720', '34', '26', '2', '0.00', '1', '1', null, '内网IP', '0', '0', '内网IP', '内网IP', '2021-05-22 09:38:30', '26', '26', '2021-05-22 09:40:07', '会员购买【java基础教程 第一季】课程', '0');
INSERT INTO `edu_member_buy_course` VALUES ('14', '2021052200001000180017062770', '50', '26', '2', '1.00', '1', '1', 'alipay', '内网IP', '0', '0', '内网IP', '内网IP', '2021-05-22 12:58:36', '26', '26', '2021-05-22 17:06:48', '会员购买【基于SpringBoot+Jpa+JWT+Spring Security+Vue+ElementUI前后端分离后台管理系统】课程', '0');

-- ----------------------------
-- Table structure for edu_member_buy_vip
-- ----------------------------
DROP TABLE IF EXISTS `edu_member_buy_vip`;
CREATE TABLE `edu_member_buy_vip` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(255) NOT NULL COMMENT '订单编号',
  `vip_id` bigint(20) NOT NULL COMMENT '会员类型ID',
  `member_id` bigint(20) NOT NULL COMMENT '会员ID',
  `price` decimal(10,2) NOT NULL COMMENT '购买金额',
  `is_payment` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否付款，0表示未付款，1表示已付款，2表示已退款',
  `pay_channel` varchar(100) DEFAULT NULL COMMENT '支付渠道wxpay表示微信，alipay表示支付宝',
  `country` varchar(255) DEFAULT NULL COMMENT '国家或地区',
  `area` varchar(255) DEFAULT NULL COMMENT '区域',
  `province` varchar(255) DEFAULT NULL COMMENT '所属省份',
  `city` varchar(255) DEFAULT NULL COMMENT '城市',
  `isp` varchar(255) DEFAULT NULL COMMENT '网络服务提供商',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `create_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `del_flag` tinyint(2) DEFAULT '0' COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COMMENT='会员加入VIP记录表';

-- ----------------------------
-- Records of edu_member_buy_vip
-- ----------------------------
INSERT INTO `edu_member_buy_vip` VALUES ('8', '2021052200001000570020094842', '2', '26', '1.00', '1', 'wxpay', '内网IP', '0', '0', '内网IP', '内网IP', '2021-05-22 18:45:49', '26', '2021-05-22 20:11:03', '26', '0', '用户加入VIP【铜牌会员】');
INSERT INTO `edu_member_buy_vip` VALUES ('9', '2021052200001000090020133856', '3', '26', '1.00', '1', 'alipay', '内网IP', '0', '0', '内网IP', '内网IP', '2021-05-22 20:13:39', '26', '2021-05-22 20:14:06', '26', '0', '用户加入VIP【银牌会员】');
INSERT INTO `edu_member_buy_vip` VALUES ('10', '2021052200001000780020223236', '4', '26', '1.00', '1', 'wxpay', '内网IP', '0', '0', '内网IP', '内网IP', '2021-05-22 20:22:32', '26', '2021-05-22 20:23:03', '26', '0', '用户加入VIP【金牌会员】');
INSERT INTO `edu_member_buy_vip` VALUES ('11', '2021052200001000390020274229', '5', '26', '1.00', '1', 'alipay', '内网IP', '0', '0', '内网IP', '内网IP', '2021-05-22 20:24:14', '26', '2021-05-22 20:28:08', '26', '0', '用户加入VIP【钻石会员】');

-- ----------------------------
-- Table structure for edu_subject
-- ----------------------------
DROP TABLE IF EXISTS `edu_subject`;
CREATE TABLE `edu_subject` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '课程类别ID',
  `name` varchar(10) NOT NULL COMMENT '类别名称',
  `parent_id` bigint(19) NOT NULL DEFAULT '0' COMMENT '父ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序字段',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `create_by` bigint(20) DEFAULT NULL,
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL,
  `cate_id` bigint(20) NOT NULL COMMENT '对应阿里云视频分类id',
  `remarks` varchar(255) DEFAULT NULL,
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '是否删除标志',
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COMMENT='课程科目';

-- ----------------------------
-- Records of edu_subject
-- ----------------------------
INSERT INTO `edu_subject` VALUES ('1', '前沿', '0', '1', '2021-01-21 00:00:00', null, '2021-01-21 19:39:17', '1', '1000233282', null, '0');
INSERT INTO `edu_subject` VALUES ('2', '移动', '0', '1', '2021-01-21 00:00:00', null, '2021-01-21 19:39:02', '1', '1000233283', null, '0');
INSERT INTO `edu_subject` VALUES ('3', '云计算', '0', '1', '2021-01-21 00:00:00', null, '2021-01-21 19:38:46', '1', '1000233299', null, '0');
INSERT INTO `edu_subject` VALUES ('5', '后端', '0', '1', '2021-01-21 00:00:00', null, '2021-01-21 19:38:11', '1', '1000233300', null, '0');
INSERT INTO `edu_subject` VALUES ('6', '前端', '0', '2', '2021-01-21 00:00:00', null, '2021-02-04 18:00:09', '1', '1000233302', null, '0');
INSERT INTO `edu_subject` VALUES ('7', '运维', '0', '1', '2021-01-21 00:00:00', null, '2021-01-21 19:37:45', '1', '1000233322', null, '0');
INSERT INTO `edu_subject` VALUES ('8', 'Java', '5', '2', '2021-01-21 21:14:21', null, '2021-01-21 19:38:21', '1', '1000233619', null, '0');
INSERT INTO `edu_subject` VALUES ('9', 'Python', '5', '1', '2021-01-21 21:15:41', null, '2021-01-21 19:38:35', '1', '1000233620', null, '0');
INSERT INTO `edu_subject` VALUES ('11', 'springboot', '5', '3', '2021-01-21 21:35:38', null, '2021-01-21 19:38:29', '1', '1000233621', null, '0');
INSERT INTO `edu_subject` VALUES ('12', '区块链', '1', '1', '2021-01-21 08:48:25', null, '2021-01-21 19:39:20', '1', '1000233593', null, '0');
INSERT INTO `edu_subject` VALUES ('13', '人工智能', '1', '1', '2021-01-21 08:48:58', null, '2021-01-21 19:39:24', '1', '1000233594', null, '0');
INSERT INTO `edu_subject` VALUES ('14', 'android', '2', '1', '2021-01-21 08:49:31', null, '2021-01-21 19:39:06', '1', '1000233595', null, '0');
INSERT INTO `edu_subject` VALUES ('15', 'ios', '2', '2', '2021-01-21 08:49:57', null, '2021-01-21 19:39:09', '1', '1000233596', null, '0');
INSERT INTO `edu_subject` VALUES ('16', '大数据', '3', '1', '2021-01-21 08:50:25', null, '2021-01-21 19:38:50', '1', '1000233597', null, '0');
INSERT INTO `edu_subject` VALUES ('17', '容器', '3', '2', '2021-01-21 08:50:37', null, '2021-01-21 19:38:54', '1', '1000233617', null, '0');
INSERT INTO `edu_subject` VALUES ('18', '小程序', '6', '1', '2021-01-21 08:51:06', null, '2021-01-21 19:37:58', '1', '1000233623', null, '0');
INSERT INTO `edu_subject` VALUES ('19', 'vue', '6', '2', '2021-01-21 08:51:31', null, '2021-01-21 19:38:01', '1', '1000233625', null, '0');
INSERT INTO `edu_subject` VALUES ('20', '测试', '7', '1', '2021-01-21 08:51:51', null, '2021-01-21 19:37:27', '1', '1000233627', null, '0');
INSERT INTO `edu_subject` VALUES ('21', '数据库', '7', '2', '2021-01-21 08:52:02', null, '2021-01-21 19:37:20', '1', '1000233629', null, '0');
INSERT INTO `edu_subject` VALUES ('22', '开发工具', '5', '1', '2021-01-26 19:03:33', '1', '2021-01-26 19:03:33', '1', '1000235136', null, '0');
INSERT INTO `edu_subject` VALUES ('23', 'html5', '6', '1', '2021-01-29 19:41:58', '1', '2021-01-29 19:41:58', '1', '1000236281', null, '0');
INSERT INTO `edu_subject` VALUES ('24', 'css3', '6', '1', '2021-01-29 20:30:33', '1', '2021-01-29 20:30:33', '1', '1000236295', null, '0');
INSERT INTO `edu_subject` VALUES ('25', 'javascript', '6', '1', '2021-01-30 08:18:55', '1', '2021-01-30 08:18:55', '1', '1000236339', null, '0');
INSERT INTO `edu_subject` VALUES ('26', 'jquery', '6', '1', '2021-01-30 08:55:56', '1', '2021-01-30 08:55:56', '1', '1000236342', null, '0');
INSERT INTO `edu_subject` VALUES ('27', 'layui', '6', '1', '2021-01-30 10:30:41', '1', '2021-01-30 10:30:41', '1', '1000236368', null, '0');
INSERT INTO `edu_subject` VALUES ('28', 'ssm', '5', '1', '2021-01-30 10:44:56', '1', '2021-01-30 10:44:56', '1', '1000236374', null, '0');

-- ----------------------------
-- Table structure for edu_teacher
-- ----------------------------
DROP TABLE IF EXISTS `edu_teacher`;
CREATE TABLE `edu_teacher` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '讲师ID',
  `name` varchar(20) NOT NULL COMMENT '讲师姓名',
  `intro` varchar(255) NOT NULL COMMENT '讲师资历,一句话说明讲师',
  `level` int(10) unsigned NOT NULL COMMENT '头衔 1高级讲师 2首席讲师',
  `avatar` varchar(255) DEFAULT NULL COMMENT '讲师头像',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `income_amount` decimal(10,2) DEFAULT '0.00' COMMENT '累计收入',
  `cash_out_money` decimal(10,2) DEFAULT '0.00' COMMENT '可提现金额',
  `payee_name` varchar(50) DEFAULT NULL COMMENT '收款人姓名',
  `card_number` varchar(255) DEFAULT NULL COMMENT '银行卡号',
  `bank` varchar(255) DEFAULT NULL COMMENT '收款银行',
  `del_flag` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `create_by` bigint(20) DEFAULT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` text COMMENT '讲师简介',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='讲师';

-- ----------------------------
-- Records of edu_teacher
-- ----------------------------
INSERT INTO `edu_teacher` VALUES ('2', '墨鱼老师', '具备深厚的数学思维功底、丰富的小学教育经验，授课风格生动活泼，擅长用形象生动的比喻帮助理解、简单易懂的语言讲解难题，深受学生喜欢', '2', 'http://xuedenedu.oss-cn-qingdao.aliyuncs.com/2020/08/31/career/a0cf19e9-e1a4-4bd2-bf83-21da264b4d5dfile.png', '1', '17500.00', '17490.00', '张三', '456321654987', '中国工商银行', '0', '2021-01-22 21:37:42', null, '2', '2021-05-28 19:03:25', '毕业于师范大学数学系，热爱教育事业，执教数学思维6年有余');
INSERT INTO `edu_teacher` VALUES ('3', '葡萄师兄', '有几十年的种植葡萄经验', '2', 'http://alioss.xueden.cn/2021/01/23/career/502ab6e0-c4f6-47e8-9218-9cfcc36aa7ealogo.png', '2', '0.00', '0.00', null, null, null, '0', '2021-01-22 19:42:45', null, '1', '2021-01-23 08:54:28', '有几十年的种植葡萄经验');
INSERT INTO `edu_teacher` VALUES ('4', '耕田大师', '专门耕田的', '1', 'http://alioss.xueden.cn/2021/01/23/career/9e0fd76e-752d-44c4-9d66-73adb1b02d39墨鱼课堂2.png', '0', '0.00', '0.00', null, null, null, '0', '2021-01-23 08:28:00', '1', '1', '2021-01-23 08:28:00', '有几十年的耕田经验，擅长耕水田，梯田等');
INSERT INTO `edu_teacher` VALUES ('5', '梁志杰', '非常好的', '1', 'http://www.xueden.cn/128.png', '0', '0.00', '0.00', null, null, null, '0', '2021-05-29 09:31:04', '26', '26', '2021-05-29 09:31:04', '非常好的');

-- ----------------------------
-- Table structure for edu_video
-- ----------------------------
DROP TABLE IF EXISTS `edu_video`;
CREATE TABLE `edu_video` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '视频ID',
  `course_id` bigint(19) NOT NULL COMMENT '课程ID',
  `chapter_id` bigint(19) NOT NULL COMMENT '章节ID',
  `title` varchar(250) NOT NULL COMMENT '节点名称',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序字段',
  `play_count` bigint(20) unsigned DEFAULT '0' COMMENT '播放次数',
  `is_free` int(2) unsigned NOT NULL DEFAULT '0' COMMENT '是否可以试听：0免费 1收费',
  `video_source_id` varchar(100) DEFAULT NULL COMMENT '视频资源',
  `duration` float NOT NULL DEFAULT '0' COMMENT '视频时长（秒）',
  `preview_duration` int(11) DEFAULT '0' COMMENT '预览时长',
  `status` varchar(20) DEFAULT '' COMMENT '视频状态:见阿里云文档',
  `size` bigint(20) unsigned DEFAULT '0' COMMENT '视频源文件大小（字节）',
  `version` bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT '乐观锁',
  `video_original_name` varchar(255) DEFAULT NULL,
  `file_key` varchar(255) DEFAULT NULL COMMENT '视频标志',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `create_by` bigint(20) DEFAULT NULL,
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT '0' COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  PRIMARY KEY (`id`),
  KEY `idx_course_id` (`course_id`) USING BTREE,
  KEY `idx_chapter_id` (`chapter_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=927 DEFAULT CHARSET=utf8mb4 COMMENT='课程视频';

-- ----------------------------
-- Records of edu_video
-- ----------------------------
INSERT INTO `edu_video` VALUES ('3', '4', '1', '1-1 课程介绍', '1', '0', '0', '1e3b862ff9e74553841c9e31cec9b554', '105.976', '0', '', '4460463', '1', null, 'bc7a1ef078ddb77e1f7b2e694f38e6b7', '2021-01-27 08:57:34', '1', '2021-01-27 20:11:39', '1', null, '0');
INSERT INTO `edu_video` VALUES ('4', '4', '2', '2-1 IDEA简介', '1', '0', '0', '26aba866092943c1b21e2757e5608450', '297.564', '0', '', '10382098', '1', null, 'c8dab10550b5d4199e9e391bae0f47ba', '2021-01-27 20:14:39', '1', '2021-01-27 20:16:30', '1', null, '0');
INSERT INTO `edu_video` VALUES ('5', '4', '2', '2-2 IDEA下载和安装', '1', '0', '0', '4179fa6a2ccb4f9cb149625132ef38be', '223.562', '0', '', '11740164', '1', null, '0a90ca0075df95a7ff8352b92865f855', '2021-01-27 20:18:20', '1', '2021-01-27 20:19:27', '1', null, '0');
INSERT INTO `edu_video` VALUES ('6', '4', '2', '2-3 IDEA配置', '1', '1', '0', '433211b1f78346b582654acf840f1a82', '212.532', '0', '', '10895984', '1', null, '05a50735e3f9d4ced895963a0bceac2e', '2021-01-27 20:38:56', '1', '2021-02-10 21:24:55', '1', null, '0');
INSERT INTO `edu_video` VALUES ('7', '4', '3', '3-1 IDEA创建简单java工程', '1', '2', '0', '7857015d7bca4b55bef89179bcb4ee12', '343.795', '0', '', '14894090', '1', null, '169f471ec29f01b49052c0d48ba4d108', '2021-01-27 20:52:22', '1', '2021-02-10 21:24:50', '1', null, '0');
INSERT INTO `edu_video` VALUES ('8', '4', '3', '3-2 IDEA快捷键的使用', '1', '0', '1', 'aaa74099be2447a983082d8a50f68541', '522.379', '0', '', '23721981', '1', null, 'dee4151c24e56003b879ab1426ba04ff', '2021-01-27 20:52:39', '1', '2021-01-27 21:04:01', '1', null, '0');
INSERT INTO `edu_video` VALUES ('9', '4', '3', '3-3 IDEA添加代码提示模板', '1', '0', '1', '8369193ebd9840d583d2be1bb159f68f', '250.566', '0', '', '12172409', '1', null, 'e2c028431519a0a9df3bb5c6f24c4b75', '2021-01-27 20:52:53', '1', '2021-01-27 21:06:46', '1', null, '0');
INSERT INTO `edu_video` VALUES ('10', '4', '3', '3-4 IDEA设置组件内容模板', '1', '0', '1', '478aebae8982417ea20e4c75c0fcd2a2', '130.032', '0', '', '9186652', '1', null, 'd0c260f2943f0d1d70b2257db1e7f73a', '2021-01-27 20:53:04', '1', '2021-01-27 21:15:04', '1', null, '0');
INSERT INTO `edu_video` VALUES ('11', '4', '3', '3-5 IDEA添加类和方法注释', '1', '0', '1', '5e8d01c16a59431689cf8685c684a9dc', '165.628', '0', '', '9405281', '1', null, '82e2263d92f0606f60de42bf1c3cf61d', '2021-01-27 20:53:14', '1', '2021-01-27 21:17:03', '1', null, '0');
INSERT INTO `edu_video` VALUES ('12', '4', '3', '3-6 使用IDEA创建Web工程', '1', '0', '1', '4993efc7c77d4ffe9bbc28d43e315b01', '235.566', '0', '', '12341039', '1', null, '34c390ea4e4698097b05bd0590939d0b', '2021-01-27 20:53:25', '1', '2021-01-27 21:22:53', '1', null, '0');
INSERT INTO `edu_video` VALUES ('13', '4', '3', '3-7 使用IDEA创建普通maven工程', '1', '0', '1', 'c40ce211986f4cd9a16cbd67fc2eb033', '252.563', '0', '', '13224640', '1', null, 'aa856f83f95797cfd89fd4bab6e3459e', '2021-01-27 20:53:34', '1', '2021-01-27 21:25:44', '1', null, '0');
INSERT INTO `edu_video` VALUES ('14', '4', '3', '3-8 使用IDEA创建maven聚合工程', '1', '0', '1', 'b7e98bff2fa24be09d0aa11ebbaed76b', '431.566', '0', '', '28533082', '1', null, 'd9a6854db52bff5585eee4591acefc81', '2021-01-27 20:53:43', '1', '2021-01-27 21:54:31', '1', null, '0');
INSERT INTO `edu_video` VALUES ('15', '4', '4', '4-1 在IDEA中使用本地Git仓库管理代码', '1', '0', '1', 'ff2af9dbe06a4af6a3ccd5497260af75', '207.029', '0', '', '12672701', '1', null, '59deba846a2383a80d9b097c0363accb', '2021-01-27 20:54:15', '1', '2021-01-27 22:02:08', '1', null, '0');
INSERT INTO `edu_video` VALUES ('16', '4', '4', '4-2 在IDEA中使用GitHub远程仓库管理代码', '1', '0', '1', 'fb296bac3ddd4ab39fcd82b9a2b596b1', '250.474', '0', '', '13701139', '1', null, '8e8606760efb08ef6702ec97d52f370d', '2021-01-27 20:54:51', '1', '2021-01-27 22:20:51', '1', null, '0');
INSERT INTO `edu_video` VALUES ('17', '34', '5', '1-1 java简介', '1', '0', '0', '3a7be9a142aa49fcb01524b8076957b4', '134.56', '0', '', '5830734', '1', null, 'b145871ca78ce587c137aab2ec2d8a32', '2021-01-27 22:23:44', '1', '2021-01-27 22:25:17', '1', null, '0');
INSERT INTO `edu_video` VALUES ('18', '34', '5', '1-2 java三大版本', '1', '0', '0', '1eb500bd9ffe47a794ab9861b5af0365', '80.0624', '0', '', '3749290', '1', null, 'a7f6228b28e794d116f25cbcd4c86bd3', '2021-01-27 22:23:54', '1', '2021-01-28 08:32:48', '1', null, '0');
INSERT INTO `edu_video` VALUES ('19', '34', '5', '1-3 java特点', '1', '0', '0', '2b7f68c91ebb41c7b93c14b882962614', '232.06', '0', '', '5886701', '1', null, '44fa41f9db869b47951087769dda6fc1', '2021-01-27 22:24:01', '1', '2021-01-28 08:34:59', '1', null, '0');
INSERT INTO `edu_video` VALUES ('20', '34', '5', '1-4 java运行原理', '1', '0', '0', '30f19352369e446f91c67fc2e9d620f7', '86.0299', '0', '', '3710600', '1', null, 'd7d73fcf243aa625fbd075feb879567d', '2021-01-27 22:24:10', '1', '2021-01-28 08:36:07', '1', null, '0');
INSERT INTO `edu_video` VALUES ('21', '34', '5', '1-5 jdk、jre、jvm区别与联系', '1', '0', '0', '128a5c09283e4e9e86d9da749b2522b1', '76.0454', '0', '', '2731214', '1', null, 'dcf51cb8341830a30882bb4a36c16cf2', '2021-01-27 22:24:18', '1', '2021-01-28 08:37:06', '1', null, '0');
INSERT INTO `edu_video` VALUES ('22', '34', '5', '1-6 jdk下载安装以及配置环境变量', '1', '0', '0', 'cd0adcfcda694932ae6b94e6c432ee8c', '565.568', '0', '', '36695812', '1', null, '0446a94776a1c467a4aa78fa3882f4f0', '2021-01-27 22:24:29', '1', '2021-01-28 08:41:00', '1', null, '0');
INSERT INTO `edu_video` VALUES ('23', '34', '5', '1-7 第一个java程序', '1', '0', '0', 'a3313acc52c843c08d67e859d38f7ede', '182.532', '0', '', '8766523', '1', null, 'ab8acf6e9f15a87bfdac190edc3d63e1', '2021-01-27 22:24:36', '1', '2021-01-28 08:42:10', '1', null, '0');
INSERT INTO `edu_video` VALUES ('24', '34', '6', '2-1 注释', '1', '0', '0', '7840be36dfd34c08bf3f6f1b873220ce', '159.01', '0', '', '8400964', '1', null, 'e868ebfc776c48134a17dd32179afd70', '2021-01-28 08:48:41', '1', '2021-01-28 08:51:08', '1', null, '0');
INSERT INTO `edu_video` VALUES ('25', '34', '6', '2-2 认识java标识符', '1', '0', '0', 'f5c9e5c0521a4af69d843b32e11e3831', '269.932', '0', '', '13026073', '1', null, 'c00d0868343a830055554a80834db8de', '2021-01-28 08:48:57', '1', '2021-01-28 08:54:25', '1', null, '0');
INSERT INTO `edu_video` VALUES ('26', '34', '6', '2-3 java中的关键字', '1', '0', '0', '028cd2b1d416437cb2390c1a0d15915c', '82.0593', '0', '', '3389081', '1', null, '60da076104d5e4e0292f1c67b29074e4', '2021-01-28 08:49:06', '1', '2021-01-28 08:55:40', '1', null, '0');
INSERT INTO `edu_video` VALUES ('27', '34', '6', '2-4 变量的本质和变量的声明', '1', '0', '1', '294a7cdafd774482a1469435b37f81b6', '263.523', '0', '', '13798492', '1', null, '5137a01229f534ff12a200d22da57d28', '2021-01-28 08:49:17', '1', '2021-01-28 08:56:50', '1', null, '0');
INSERT INTO `edu_video` VALUES ('28', '34', '6', '2-5 变量的分类', '1', '0', '1', '7461ea6b14704b0eab23debcffff3601', '301.558', '0', '', '14454344', '1', null, '69adaeacd6702cbb525928d461c4a30b', '2021-01-28 08:49:26', '1', '2021-01-28 08:57:58', '1', null, '0');
INSERT INTO `edu_video` VALUES ('29', '34', '6', '2-6 常量与final', '1', '0', '1', '63db6ef7ccdf4308a741bb2f14bdbf58', '173.964', '0', '', '7977608', '1', null, 'c3be56f1dcb621136a7eaaaee0010c03', '2021-01-28 08:49:37', '1', '2021-01-28 08:58:50', '1', null, '0');
INSERT INTO `edu_video` VALUES ('30', '34', '6', '2-7 基本数据类型', '1', '0', '1', '1d45ee518ed24798b5e5d6b6dd1cff4b', '106.069', '0', '', '4836959', '1', null, '4eeec9816fb6f316a3b15294e57dcedf', '2021-01-28 08:49:46', '1', '2021-01-28 09:00:59', '1', null, '0');
INSERT INTO `edu_video` VALUES ('31', '34', '6', '2-8 整型变量和整型常量', '1', '0', '1', '02f9ca5cdea94db883f2ce447e65d278', '633.533', '0', '', '29013294', '1', null, '3debdb5a0e9f2178ec83012dcb2fb317', '2021-01-28 08:49:56', '1', '2021-01-28 09:03:26', '1', null, '0');
INSERT INTO `edu_video` VALUES ('32', '34', '6', '2-9 浮点型变量和浮点型常量', '1', '0', '1', 'a463a1cf464b4fcfa78e8f1bce4940ef', '528.068', '0', '', '26552035', '1', null, 'aa070562ce2eaaee56dfd633a753fd15', '2021-01-28 08:50:04', '1', '2021-01-28 09:05:39', '1', null, '0');
INSERT INTO `edu_video` VALUES ('33', '34', '6', '2-10 字符型变量和字符型常量', '1', '0', '1', '8aff141afaaf44e8af276e54471ec0c9', '317.533', '0', '', '17093415', '1', null, '8c8d09a51f32dc9e068490748df0db78', '2021-01-28 08:50:14', '1', '2021-01-28 09:08:45', '1', null, '0');
INSERT INTO `edu_video` VALUES ('34', '34', '6', '2-11 boolean类型变量和常量', '1', '0', '1', '3c321ce2d34849c883de983cc96199bf', '195.024', '0', '', '9342686', '1', null, '649b625ce8689d90139f30c8e1cd34cd', '2021-01-28 08:50:22', '1', '2021-01-28 09:10:08', '1', null, '0');
INSERT INTO `edu_video` VALUES ('35', '34', '7', '3-1 运算符简介', '1', '0', '1', '60ffa08749d64ff8a2374b1e69dd3d73', '93.53', '0', '', '4350635', '1', null, 'd991ea17e199a10d7277dff31b3bdc6f', '2021-01-28 09:10:34', '1', '2021-01-28 09:12:49', '1', null, '0');
INSERT INTO `edu_video` VALUES ('36', '34', '7', '3-2 算术运算符以及自增和自减的使用', '1', '0', '1', 'feff385501db4c38ab1d94989033d5b6', '736.56', '0', '', '36492860', '1', null, '2753f508d0653d81c9cbcf5f66b53460', '2021-01-28 09:10:45', '1', '2021-01-28 09:15:34', '1', null, '0');
INSERT INTO `edu_video` VALUES ('37', '34', '7', '3-3 赋值及其扩展赋值运算符', '1', '0', '1', 'b84e3151fed84b6193ebae30c2987692', '184.529', '0', '', '9163397', '1', null, '144beda04f89aded7ad2478213f61325', '2021-01-28 09:10:58', '1', '2021-01-28 09:16:35', '1', null, '0');
INSERT INTO `edu_video` VALUES ('38', '34', '7', '3-4 关系运算符', '1', '0', '1', '1d2f6b22716345f9a164019f601d4c76', '354.058', '0', '', '19028437', '1', null, '1a389709c2df31271373cd84d92d42d9', '2021-01-28 09:11:08', '1', '2021-01-28 09:18:07', '1', null, '0');
INSERT INTO `edu_video` VALUES ('39', '34', '7', '3-5 逻辑运算符', '1', '0', '1', '70d8e66ccee24ab3b23008be818be161', '421.558', '0', '', '23571745', '1', null, '233a1f0aa239258366f97afe0b0b836f', '2021-01-28 09:11:18', '1', '2021-01-28 09:19:53', '1', null, '0');
INSERT INTO `edu_video` VALUES ('40', '34', '7', '3-6 位运算符', '1', '0', '1', '0780efedde4b45b8a538ad7a804a9011', '362.835', '0', '', '20515599', '1', null, '204473a254b3f0c64c639a5b61e32501', '2021-01-28 09:11:28', '1', '2021-01-28 09:21:16', '1', null, '0');
INSERT INTO `edu_video` VALUES ('41', '34', '7', '3-7 字符串运算符', '1', '0', '1', 'dc728ca38fad4cdd9ca1e5fa5ae154c4', '272.533', '0', '', '14969978', '1', null, 'e34e2a0316525c34787b02f57ec2a5d7', '2021-01-28 09:11:38', '1', '2021-01-28 09:22:22', '1', null, '0');
INSERT INTO `edu_video` VALUES ('42', '34', '7', '3-8 三目运算符', '1', '0', '1', '07a5590ea13e4856881a83edf8b0f7c3', '251.565', '0', '', '13956149', '1', null, 'd6e8efafcca97460e900466bc1f77f06', '2021-01-28 09:11:49', '1', '2021-01-28 09:51:15', '1', null, '0');
INSERT INTO `edu_video` VALUES ('43', '34', '7', '3-9 运算符优先级的问题', '1', '0', '1', 'ab642cfe85cd4f65b6f68c8d1b3fa543', '164.49', '0', '', '11113491', '1', null, 'a22d4436f49656a05ad983793381f5de', '2021-01-28 09:11:58', '1', '2021-01-28 09:56:24', '1', null, '0');
INSERT INTO `edu_video` VALUES ('44', '34', '7', '3-10 自动类型转化', '1', '0', '1', '2c5ce224230847b1bb031cbe7ca8c940', '344.561', '0', '', '18333195', '1', null, '0c16ba6102cef1b807061adfecae4efd', '2021-01-28 09:12:08', '1', '2021-01-28 10:25:44', '1', null, '0');
INSERT INTO `edu_video` VALUES ('45', '34', '7', '3-11 强制类型转化', '1', '0', '1', 'f5998ce34b5343eea92229b1aa2c9e51', '224.026', '0', '', '14323894', '1', null, 'c7abe393a9af0cbd3ddbe2873f006448', '2021-01-28 09:12:18', '1', '2021-01-28 10:27:13', '1', null, '0');
INSERT INTO `edu_video` VALUES ('46', '34', '8', '4-1 控制语句介绍', '1', '0', '1', 'ce96547ab47d4ba6b13c6418064b0a70', '160.566', '0', '', '9130866', '1', null, '8332e804403de93138f517f86b832f15', '2021-01-28 10:34:05', '1', '2021-01-28 10:37:14', '1', null, '0');
INSERT INTO `edu_video` VALUES ('47', '34', '8', '4-2 if单选择结构', '1', '0', '1', 'bfb3f4ef1d2946af9dbda30602f94698', '259.065', '0', '', '15041322', '1', null, '91d3ee0944b099118dbdab27cb324984', '2021-01-28 10:34:24', '1', '2021-01-28 10:41:56', '1', null, '0');
INSERT INTO `edu_video` VALUES ('48', '34', '8', '4-3 if-else双选择结构', '1', '0', '1', '0fe20529c6f54edeb22bb727d1624564', '119.025', '0', '', '7774691', '1', null, '12f3d465dc7db76961cea3d1f8524702', '2021-01-28 10:35:10', '1', '2021-01-28 10:42:40', '1', null, '0');
INSERT INTO `edu_video` VALUES ('49', '34', '8', '4-4 if-else if-else多选择结构', '1', '0', '1', '55273961b6af47be81073355ed308375', '434.561', '0', '', '23220362', '1', null, 'e921ad7aafab1179ecd8a8a9f75e89a2', '2021-01-28 10:35:19', '1', '2021-01-28 10:49:48', '1', null, '0');
INSERT INTO `edu_video` VALUES ('50', '34', '8', '4-5 switch多选择结构', '1', '0', '1', '52fc7c6f32bf4777b66c6172b3d6d071', '397.061', '0', '', '22731428', '1', null, '4b46820f9a0bb8d18a563ee2e4385559', '2021-01-28 10:35:26', '1', '2021-01-28 10:54:05', '1', null, '0');
INSERT INTO `edu_video` VALUES ('51', '34', '8', '4-6 while循环', '1', '0', '1', '94e3cc81de0942cfa3078f2acec25a3f', '274.53', '0', '', '16348777', '1', null, '35b1a1faaf93a972a9f19a2ea448f6b9', '2021-01-28 10:35:34', '1', '2021-01-28 10:55:14', '1', null, '0');
INSERT INTO `edu_video` VALUES ('52', '34', '8', '4-7 do-while循环', '1', '0', '1', '1d5bb0b8a2d24fb6b8ff510713477b28', '151.557', '0', '', '10296012', '1', null, '42306085b211d4b4f570012c09e397dc', '2021-01-28 10:35:43', '1', '2021-01-28 10:56:12', '1', null, '0');
INSERT INTO `edu_video` VALUES ('53', '34', '8', '4-8 for循环', '1', '0', '1', 'ff41d1625c3c405082cdd140a9fd2a10', '247.06', '0', '', '14597971', '1', null, 'b29aa222d123ac321283533a4c061c63', '2021-01-28 10:36:02', '1', '2021-01-28 10:57:19', '1', null, '0');
INSERT INTO `edu_video` VALUES ('54', '34', '8', '4-9 嵌套循环', '1', '0', '1', '83a99046e7d04a51bcf6ab5fb6da237c', '299.561', '0', '', '17016074', '1', null, 'bb84a7a0890a2611f0f7176aa9bb0a7a', '2021-01-28 10:36:14', '1', '2021-01-28 10:58:38', '1', null, '0');
INSERT INTO `edu_video` VALUES ('55', '34', '8', '4-10 break语句和continue语句', '1', '0', '1', '31efb3d16b0e4f8c9e186e4af77d52c0', '692.976', '0', '', '40149616', '1', null, 'b17b537352e5f133b4a8ef873be7f26d', '2021-01-28 10:36:22', '1', '2021-01-28 11:01:44', '1', null, '0');
INSERT INTO `edu_video` VALUES ('56', '34', '9', '5-1 代码块', '1', '0', '1', 'b788810a72bf4026a321900b93510b88', '231.503', '0', '', '11371722', '1', null, 'a1867d58f6bac179d50c0c1d1e734f12', '2021-01-28 11:02:14', '1', '2021-01-28 11:03:36', '1', null, '0');
INSERT INTO `edu_video` VALUES ('57', '34', '9', '5-2 方法介绍', '1', '0', '1', 'c350a73dafd14da2b0e0717242eea5c5', '370.567', '0', '', '22121597', '1', null, '65d848274a8ec8778ec5ecc984970937', '2021-01-28 11:02:22', '1', '2021-01-28 11:07:26', '1', null, '0');
INSERT INTO `edu_video` VALUES ('58', '34', '9', '5-3 方法的重载', '1', '0', '1', 'f4ec9233c2034bd69cae951c4af32f1b', '296.565', '0', '', '16226563', '1', null, 'ae1f566ad78d5edfc6f5ba0157bbb2df', '2021-01-28 11:02:30', '1', '2021-01-28 11:12:02', '1', null, '0');
INSERT INTO `edu_video` VALUES ('59', '34', '9', '5-4 递归结构', '1', '0', '1', 'c2aef6497c6d4386a485119c18e5f7a8', '361.558', '0', '', '24295131', '1', null, '0f9fe456edc8dfa659516d9dce9c2218', '2021-01-28 11:02:39', '1', '2021-01-28 11:13:55', '1', null, '0');
INSERT INTO `edu_video` VALUES ('60', '35', '10', '1-1 面向过程和面向对象', '1', '0', '0', '734b40baa963425480d59baa7743f72b', '292.525', '0', '', '15618183', '1', null, 'd9e574d1da91d95445a7d16e060468e2', '2021-01-28 12:30:46', '1', '2021-01-28 12:37:30', '1', null, '0');
INSERT INTO `edu_video` VALUES ('61', '35', '10', '1-2 类和对象介绍', '1', '0', '0', '61860f455d2f45b7b2fa601373c292a3', '182.532', '0', '', '12069141', '1', null, '36eebda30570c85303bb804ec715d200', '2021-01-28 12:30:56', '1', '2021-01-28 12:38:29', '1', null, '0');
INSERT INTO `edu_video` VALUES ('62', '35', '10', '1-3 构造方法', '1', '0', '0', 'a85a1d15061149aaa8e2090a36737984', '543.068', '0', '', '34889511', '1', null, '950b8fa3095def67bdd2c268af8d8c81', '2021-01-28 12:31:07', '1', '2021-01-28 12:40:49', '1', null, '0');
INSERT INTO `edu_video` VALUES ('63', '35', '10', '1-4 static关键字', '1', '0', '0', 'e62c11cfcb9e4a2c8e507ce6cad1bb1c', '293.059', '0', '', '15105386', '1', null, '0d1448de27927452c285eb17fa9b9e2b', '2021-01-28 12:31:17', '1', '2021-01-28 12:42:00', '1', null, '0');
INSERT INTO `edu_video` VALUES ('64', '35', '11', '2-1 什么是封装', '1', '0', '1', '5ffe81e906934103a32a88ce9ba759ae', '260.528', '0', '', '14438079', '1', null, '810a4f8c4635a87e6a4ea44197f2dfac', '2021-01-28 12:31:31', '1', '2021-01-28 12:43:23', '1', null, '0');
INSERT INTO `edu_video` VALUES ('65', '35', '11', '2-2 使用包管理java中的类', '1', '0', '1', '3e4cb500927d47c3b18755af53da1c50', '269.56', '0', '', '15035835', '1', null, '60c8220db4b9b0c8168778cdd183a024', '2021-01-28 12:31:41', '1', '2021-01-28 12:44:44', '1', null, '0');
INSERT INTO `edu_video` VALUES ('66', '35', '11', '2-3 java中的访问修饰符', '1', '0', '1', '4238fdab3bd74641bde526b218f84cb1', '512.557', '0', '', '28153715', '1', null, 'cb8af9edab10327dd37b4bd8558e2a6d', '2021-01-28 12:31:49', '1', '2021-01-28 12:46:39', '1', null, '0');
INSERT INTO `edu_video` VALUES ('67', '35', '11', '2-4 java中this关键字', '1', '0', '1', '3a179c3fbcc74dd3980cf72c4989449d', '575.065', '0', '', '29097596', '1', null, 'c2bf68f559ec2c0170610dfcc206e4af', '2021-01-28 12:31:57', '1', '2021-01-28 12:48:46', '1', null, '0');
INSERT INTO `edu_video` VALUES ('68', '35', '11', '2-5 java中的内部类', '1', '0', '1', 'b838d78dff364842a3e505117fe879a9', '374.608', '0', '', '20389596', '1', null, 'd48f8ab918bb112dbae686c64f0d022d', '2021-01-28 12:32:05', '1', '2021-01-28 12:50:14', '1', null, '0');
INSERT INTO `edu_video` VALUES ('69', '35', '12', '3-1 java中的继承', '1', '0', '1', '1bc2578c725b49a09fb075e2c3efa09c', '445.568', '0', '', '21851161', '1', null, '536b2613c806d6675be18b906d419706', '2021-01-28 12:32:20', '1', '2021-01-28 12:52:05', '1', null, '0');
INSERT INTO `edu_video` VALUES ('70', '35', '12', '3-2 java中的方法重写', '1', '0', '1', 'effd5c68b48640daa0229172504f78ee', '266.031', '0', '', '13615261', '1', null, '566962e534c3c35f323a39e943e8eda2', '2021-01-28 12:32:31', '1', '2021-01-28 12:53:11', '1', null, '0');
INSERT INTO `edu_video` VALUES ('71', '35', '12', '3-3 java中final关键字', '1', '0', '1', '88159633fdd84c2093f3bb3474ce649c', '204.545', '0', '', '9843462', '1', null, '5eb756dd4c26b5321277049eb2bc274e', '2021-01-28 12:32:39', '1', '2021-01-28 12:54:04', '1', null, '0');
INSERT INTO `edu_video` VALUES ('72', '35', '12', '3-4 java中super关键字', '1', '0', '1', 'b8f5efb599c745528a6ce1331693b666', '477.611', '0', '', '26902462', '1', null, '7b4c36471641dc33f99a431b7b1fc390', '2021-01-28 12:32:46', '1', '2021-01-28 12:55:57', '1', null, '0');
INSERT INTO `edu_video` VALUES ('73', '35', '12', '3-5 java中Object类的toString方法', '1', '0', '1', '836d49a85cfd4882a7d9a1427e29ef32', '266.031', '0', '', '17396632', '1', null, '1c10d09ef8877a10a0e5066dfb0a5559', '2021-01-28 12:32:54', '1', '2021-01-28 12:57:12', '1', null, '0');
INSERT INTO `edu_video` VALUES ('74', '35', '12', '3-6 java中Object类equals方法和==', '1', '0', '1', 'de974f5fdc5d41f9b4ac83359ea19bb2', '432.541', '0', '', '24441003', '1', null, 'cdb67615184c6e7d27db1050d197dc03', '2021-01-28 12:33:09', '1', '2021-01-28 12:58:54', '1', null, '0');
INSERT INTO `edu_video` VALUES ('75', '35', '13', '4-1 java中的多态', '1', '0', '1', 'af285ac0eff24445926dd336a73c24f0', '440.065', '0', '', '23097642', '1', null, 'aac16181c419d894bf4cb65253dc401f', '2021-01-28 12:33:23', '1', '2021-01-28 13:00:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('76', '35', '13', '4-2 多态中引用类型转换', '1', '0', '1', 'e8c8a7abfb1d478ab7b53a7ae167ad60', '465.026', '0', '', '24020234', '1', null, '1b957d19001972800b445412383d8d90', '2021-01-28 12:33:31', '1', '2021-01-28 13:02:23', '1', null, '0');
INSERT INTO `edu_video` VALUES ('77', '35', '13', '4-3 java 中的抽象类', '1', '0', '1', '6816798d9750461cab7a08cc86c88bc0', '455.529', '0', '', '25491566', '1', null, '3e2d49815967b31ee0b5608cf8d42e9d', '2021-01-28 12:33:38', '1', '2021-01-28 13:04:08', '1', null, '0');
INSERT INTO `edu_video` VALUES ('78', '35', '13', '4-4 java中的接口', '1', '0', '1', 'a6fe7c8162284e5298c0de8e2a4d1060', '570.561', '0', '', '30023807', '1', null, '768944a09ac015e801d7a83d5e8acc8d', '2021-01-28 12:33:47', '1', '2021-01-28 13:06:03', '1', null, '0');
INSERT INTO `edu_video` VALUES ('79', '35', '14', '5-1 数组的概述、特点以及声明和赋值', '1', '0', '1', '11907a161c694705b8c2d8bac5a8ef29', '377.51', '0', '', '20628898', '1', null, 'db67af3819ccb70087275ab554ba0fa2', '2021-01-28 12:34:01', '1', '2021-01-28 13:07:49', '1', null, '0');
INSERT INTO `edu_video` VALUES ('80', '35', '14', '5-2 使用循环操作java中的数组', '1', '0', '1', 'e2c7b125a4754324bb75d9f9af005cd9', '291.526', '0', '', '14268437', '1', null, '1b6b9434344165af3b2ab644906eded4', '2021-01-28 12:34:22', '1', '2021-01-28 13:08:50', '1', null, '0');
INSERT INTO `edu_video` VALUES ('81', '35', '14', '5-3 使用Arrays类操作Java中的数组', '1', '0', '1', '5c5a75e1cd2249118285300d57616fed', '447.031', '0', '', '25160505', '1', null, '5b9c406c858baeece57b460766830557', '2021-01-28 12:34:32', '1', '2021-01-28 13:09:42', '1', null, '0');
INSERT INTO `edu_video` VALUES ('82', '35', '14', '5-4 使用foreach操作数组', '1', '0', '1', '0a33c0034134427b9f1792fdf122e93b', '102.029', '0', '', '5205304', '1', null, 'a604dcd5b8183d88b6e61bab658d9569', '2021-01-28 12:34:41', '1', '2021-01-28 13:09:26', '1', null, '0');
INSERT INTO `edu_video` VALUES ('83', '35', '14', '5-5 Java中的二维数组', '1', '0', '1', '5b2ee85809904d5a86d3f08af3939122', '405.56', '0', '', '20065240', '1', null, '4134103c6dc396e15567867ca69caf2d', '2021-01-28 12:34:50', '1', '2021-01-28 13:10:52', '1', null, '0');
INSERT INTO `edu_video` VALUES ('84', '35', '14', '5-6 java中的冒泡排序', '1', '0', '1', '0426ba952b9d4588ae9a423344f4493c', '384.058', '0', '', '22122152', '1', null, 'fff48178ba3685503db8c3bee9076030', '2021-01-28 12:34:57', '1', '2021-01-28 13:11:36', '1', null, '0');
INSERT INTO `edu_video` VALUES ('85', '36', '15', '1-1 异常概述及分类', '1', '0', '0', 'd548de21d10d46a2a12f502e76d93840', '178.561', '0', '', '11484746', '1', null, '6222efd906032435039801100201e1b3', '2021-01-28 13:22:59', '1', '2021-01-28 13:24:31', '1', null, '0');
INSERT INTO `edu_video` VALUES ('86', '36', '15', '1-2 Error与Exception的区别', '1', '0', '0', '62502806ec4747caa89c347d97e5c630', '156.479', '0', '', '12515946', '1', null, 'd82a704e831847ffa3458386aa8a3361', '2021-01-28 13:23:12', '1', '2021-01-28 16:30:13', '1', null, '0');
INSERT INTO `edu_video` VALUES ('87', '36', '15', '1-3 使用try-catch-finally实现异常处理', '1', '0', '0', '1f285fb33ce34afeb36358969ef3cc18', '291.434', '0', '', '14773937', '1', null, 'bc35f9f41b636bc0da7b7817b0408530', '2021-01-28 13:23:21', '1', '2021-01-28 16:31:18', '1', null, '0');
INSERT INTO `edu_video` VALUES ('88', '36', '15', '1-4 java中使用throws和throw抛出异常', '1', '0', '0', '27d5ab552b4d45a8bc0c930d460441ed', '381.063', '0', '', '20566851', '1', null, '85636ca652989eb548cec7a387abd5c8', '2021-01-28 13:23:31', '1', '2021-01-28 16:32:41', '1', null, '0');
INSERT INTO `edu_video` VALUES ('89', '36', '15', '1-5 java中自定义异常', '1', '0', '0', 'fdddcb35d1a4475bb21d1e6ddc13c804', '511.977', '0', '', '28059839', '1', null, 'f4d6fbb8f6a14331b5d56b6772ee0b99', '2021-01-28 13:23:40', '1', '2021-01-28 16:34:44', '1', null, '0');
INSERT INTO `edu_video` VALUES ('90', '36', '16', '2-1 java中String类', '1', '0', '1', '089a1dc211a747ecbc0a27034de203b0', '374.027', '0', '', '19752788', '1', null, 'c485457ca402b6631ea9d7f1f575d621', '2021-01-28 16:35:03', '1', '2021-01-28 16:37:19', '1', null, '0');
INSERT INTO `edu_video` VALUES ('91', '36', '16', '2-2 String类常用方法', '1', '0', '1', 'a07eb3efb38345c58b1cfba928c831ed', '435.026', '0', '', '23587287', '1', null, 'd8b3aa1d0f9c569766d22c95971bd148', '2021-01-28 16:35:13', '1', '2021-01-28 16:39:00', '1', null, '0');
INSERT INTO `edu_video` VALUES ('92', '36', '16', '2-3 Java中的StringBuilder类', '1', '0', '1', '106e08e0763b4ecda553480f97a67f5c', '246.526', '0', '', '12148323', '1', null, '447931e2cca22c745d1773cdfbe5ce1f', '2021-01-28 16:35:22', '1', '2021-01-28 16:40:04', '1', null, '0');
INSERT INTO `edu_video` VALUES ('93', '36', '16', '2-4 Java中的 StringBuilder类的常用方法', '1', '0', '1', 'fe9997e849744d6a9fa61c235069bef1', '286.929', '0', '', '14891770', '1', null, '15ee335adb85b42fd66a4a0d2dcb8dc4', '2021-01-28 16:35:30', '1', '2021-01-28 16:41:24', '1', null, '0');
INSERT INTO `edu_video` VALUES ('95', '36', '16', '2-5 Java中的StringBuffer类', '1', '0', '1', '6e722b27172048f797c41ba837af5c87', '242.068', '0', '', '16254420', '1', null, 'eb5426cace3abb29c41808418d39601e', '2021-01-28 16:46:14', '1', '2021-01-28 16:47:20', '1', null, '0');
INSERT INTO `edu_video` VALUES ('96', '36', '17', '3-1 Java 中的包装类', '1', '0', '1', '0164679e4dd548319e602d2b3bcf7132', '318.067', '0', '', '17587896', '1', null, '0bd7b53f13708b543cc7449afad57b10', '2021-01-28 16:47:43', '1', '2021-01-28 16:49:40', '1', null, '0');
INSERT INTO `edu_video` VALUES ('97', '36', '17', '3-2 Java 中基本类型和包装类之间的转换', '1', '0', '1', '0496e631bce347c19e85d594f637985e', '332.069', '0', '', '17674414', '1', null, '837c6c2844798292d9cc0857e03c3e45', '2021-01-28 16:47:53', '1', '2021-01-28 17:24:56', '1', null, '0');
INSERT INTO `edu_video` VALUES ('98', '36', '17', '3-3 使用Date和SimpleDateFormat类表示时间', '1', '0', '1', 'b6c53c8bc9ff4ccaa6e13ff393c467aa', '473.966', '0', '', '24934911', '1', null, 'ac5b33c144f0940bd80d518c3d158ee1', '2021-01-28 16:48:01', '1', '2021-01-28 17:26:53', '1', null, '0');
INSERT INTO `edu_video` VALUES ('99', '36', '17', '3-4 Calendar类的应用', '1', '0', '1', 'bcaafedfc239444783b1c2be7360d527', '419.561', '0', '', '23262143', '1', null, 'c6fe80704b232fc25d7dd3c8242a310b', '2021-01-28 16:48:09', '1', '2021-01-28 17:28:27', '1', null, '0');
INSERT INTO `edu_video` VALUES ('100', '36', '17', '3-5 使用 Math 类操作数据', '1', '0', '1', 'e0ac210dc1e742f4a419603de912a7f8', '363.532', '0', '', '18240138', '1', null, '707c2fe09f9b44d35ccecf5484b38c26', '2021-01-28 16:48:18', '1', '2021-01-28 17:30:07', '1', null, '0');
INSERT INTO `edu_video` VALUES ('101', '36', '18', '4-1 java中的集合框架概述', '1', '0', '1', '06f8d3cc24c845d6917687460828b06f', '142.06', '0', '', '7370548', '1', null, '387642da8a8152b32808c00538ea3b16', '2021-01-28 17:30:59', '1', '2021-01-28 17:32:59', '1', null, '0');
INSERT INTO `edu_video` VALUES ('102', '36', '18', '4-2 Collection接口、子接口以及实现类', '1', '0', '1', 'eec9574eb41b4bd58e43444b425bf696', '108.53', '0', '', '5018373', '1', null, '75a661d28e130cb7d95559a7c1cae29e', '2021-01-28 17:31:09', '1', '2021-01-28 17:39:16', '1', null, '0');
INSERT INTO `edu_video` VALUES ('103', '36', '18', '4-3 学生选课系统--创建学生类和课程类', '1', '0', '1', '19777b251fb446ea821f6f8abe5209e4', '283.028', '0', '', '18675318', '1', null, 'a88355b47d715f6ad8fcb703c9a2933c', '2021-01-28 17:31:17', '1', '2021-01-28 17:40:43', '1', null, '0');
INSERT INTO `edu_video` VALUES ('104', '36', '18', '4-4学生选课系统--添加课程', '1', '0', '1', '3164148e66b64ee2825f922128597dab', '794.564', '0', '', '45993414', '1', null, 'defb9255c2eba587d582ba92b0ff87ce', '2021-01-28 17:31:25', '1', '2021-01-28 17:58:03', '1', null, '0');
INSERT INTO `edu_video` VALUES ('105', '36', '18', '4-5学生选课系统--课程查询', '1', '0', '1', '9aa32a90800f492591ee3cdd960e244f', '469.531', '0', '', '29012740', '1', null, '7470c1d3f0ba2ff286034282f30244e7', '2021-01-28 17:31:34', '1', '2021-01-28 18:00:19', '1', null, '0');
INSERT INTO `edu_video` VALUES ('106', '36', '18', '4-6 学生选课系统--课程修改', '1', '0', '1', 'fa8806d4219542e2b0586dcd61b294d0', '107.532', '0', '', '5768508', '1', null, '4042f07224b2d868006129d9709297ea', '2021-01-28 17:31:43', '1', '2021-01-28 18:01:26', '1', null, '0');
INSERT INTO `edu_video` VALUES ('107', '36', '18', '4-7 学生选课系统--课程删除', '1', '0', '1', '1c804b35746740a4af5c8db8a9954c9f', '432.565', '0', '', '26203111', '1', null, '04b8031b6dfb7624024584be4926f099', '2021-01-28 17:31:52', '1', '2021-01-28 18:03:58', '1', null, '0');
INSERT INTO `edu_video` VALUES ('108', '36', '18', '4-8 学生选课系统--应用泛型管理课程', '1', '0', '1', '62619d69925248f598a1d31ee01a38a5', '472.967', '0', '', '29341718', '1', null, 'ff14f8d8fc946f93eb612a9eb08831f3', '2021-01-28 17:32:00', '1', '2021-01-28 18:06:52', '1', null, '0');
INSERT INTO `edu_video` VALUES ('109', '36', '18', '4-9 学生选课系统--通过Set集合管理课程', '1', '0', '1', 'b98a29a4695146b2996032b1919269ad', '719.563', '0', '', '45396663', '1', null, '9f1680ebdef5caa01d151ddba960f0a4', '2021-01-28 17:32:10', '1', '2021-01-28 18:10:27', '1', null, '0');
INSERT INTO `edu_video` VALUES ('110', '36', '19', '5-1 Map和HashMap简介', '1', '0', '1', 'dd4375988cb84b4f81a5a382d7754765', '115.032', '0', '', '5396165', '1', null, '2de13fde977604568579db0ad95ef901', '2021-01-28 18:10:56', '1', '2021-01-28 18:12:07', '1', null, '0');
INSERT INTO `edu_video` VALUES ('111', '36', '19', '5-2 学生选课---使用Map添加学生', '1', '0', '1', '9153cb0bf5764ff4ad05b08d02908f45', '904.812', '0', '', '56087760', '1', null, 'd4071ae3afa801c9a4e54aa5e2f5dbc0', '2021-01-28 18:11:09', '1', '2021-01-28 18:32:00', '1', null, '0');
INSERT INTO `edu_video` VALUES ('112', '36', '19', '5-3 学生选课---删除Map中的学生', '1', '0', '1', '2d4e7fd40c9b4836ae35a011e0e978aa', '571.002', '0', '', '35590007', '1', null, '5e1e08b23cc839be75084f4d670ac5ad', '2021-01-28 18:11:19', '1', '2021-01-28 18:34:28', '1', null, '0');
INSERT INTO `edu_video` VALUES ('113', '36', '19', '5-4 学生选课---修改Map中的学生', '1', '0', '1', '29ce341ac93d498a88784bbfb6783d18', '537.565', '0', '', '32106511', '1', null, 'd353afdf5993e2f159bbf3326f07b940', '2021-01-28 18:11:30', '1', '2021-01-28 18:36:40', '1', null, '0');
INSERT INTO `edu_video` VALUES ('114', '36', '20', '6-1 学生选课---判断 List 中课程是否存在', '1', '0', '1', '1392d3c70d944ac9aacb415dc0bb14f0', '349.066', '0', '', '21039248', '1', null, 'c4f8248536b63bada5192f4e15bc44ec', '2021-01-28 18:37:23', '1', '2021-01-28 18:39:32', '1', null, '0');
INSERT INTO `edu_video` VALUES ('115', '36', '20', '6-2 学生选课---判断 List 中课程的位置', '1', '0', '1', '8604d3414efd4996a1719d2f8d9eb19e', '243.531', '0', '', '14904464', '1', null, 'dcf827fc71b7be67b4716e7d508a8dfd', '2021-01-28 18:37:46', '1', '2021-01-28 18:40:40', '1', null, '0');
INSERT INTO `edu_video` VALUES ('116', '36', '20', '6-3应用 Collections.sort() 实现 List 排序', '1', '0', '1', '0c3a9a46b42d4ab7b2c68ad48bd9c1dd', '482.557', '0', '', '26769020', '1', null, '6d8a093ce0c91e3a6dd87d20496287e2', '2021-01-28 18:38:08', '1', '2021-01-28 18:42:35', '1', null, '0');
INSERT INTO `edu_video` VALUES ('117', '37', '21', '1-1 mysql基础', '1', '16', '0', 'f48293cf6d5442b493c8e6b8a453b8f7', '92.5315', '0', '', '3291968', '1', null, '5f190f169b5be10b47900396c0cfe809', '2021-01-28 18:54:41', '1', '2021-01-31 20:49:48', '1', null, '0');
INSERT INTO `edu_video` VALUES ('118', '37', '21', '1-2 Mysql的安装与配置', '1', '1', '0', '229f6ea32f6844e3942ab60fd929b75c', '332.069', '0', '', '17484586', '1', null, '7530aae438c3df25c815c67cd59c7782', '2021-01-28 18:54:53', '1', '2021-01-31 20:50:34', '1', null, '0');
INSERT INTO `edu_video` VALUES ('119', '37', '21', '1-3 启动与停止MySQL服务', '1', '1', '0', '612de5b596504ab7a3507cf42f5db325', '181.069', '0', '', '13511822', '1', null, '4bd7a567ca80c4f3d11bae0d786a2491', '2021-01-28 18:55:04', '1', '2021-01-31 20:51:10', '1', null, '0');
INSERT INTO `edu_video` VALUES ('120', '37', '21', '1-4 MySQL登录与退出', '1', '0', '0', 'b4f911f6b8514d1baedc693c096bd428', '184.065', '0', '', '5999318', '1', null, '41df4cb491a4457704075340f7886bb3', '2021-01-28 18:55:13', '1', '2021-01-28 19:00:12', '1', null, '0');
INSERT INTO `edu_video` VALUES ('121', '37', '21', '1-5 MySQL常用命令以及语法规范', '1', '0', '0', '69d11324a080418a85b0c7dcd2e231e6', '164.49', '0', '', '6030321', '1', null, '7a7ccf064801a6955c7804d0a25bbc71', '2021-01-28 18:55:30', '1', '2021-01-28 19:01:10', '1', null, '0');
INSERT INTO `edu_video` VALUES ('122', '37', '21', '1-6 操作数据库', '1', '0', '0', 'f301f08e6c6e4fda8510a92118bd4b73', '230.969', '0', '', '7766292', '1', null, 'e281dd1f5ed9377484c85af76acf3431', '2021-01-28 18:55:50', '1', '2021-01-28 19:02:11', '1', null, '0');
INSERT INTO `edu_video` VALUES ('123', '37', '22', '2-1 mysql数据类型', '1', '1', '1', '4a041036cd1242af89cf8ae305c1c74b', '68.5685', '0', '', '3133748', '1', null, 'd3a6a80b1ffcb967355d4ae78d560a78', '2021-01-29 09:24:53', '1', '2021-01-31 20:51:44', '1', null, '0');
INSERT INTO `edu_video` VALUES ('124', '37', '22', '2-2 MySql数据类型之整型', '1', '0', '1', 'aadfefe492b9447f941006455c52a2ff', '185.992', '0', '', '6943227', '1', null, '798191b494f67bf94b4086e08d5682cb', '2021-01-29 09:25:04', '1', '2021-01-29 09:28:18', '1', null, '0');
INSERT INTO `edu_video` VALUES ('125', '37', '22', '2-3 MySQL数据类型之浮点型', '1', '0', '1', '60601bec85fe442f8369ff2ba1bb9c3e', '128.569', '0', '', '4671106', '1', null, 'a2c7188ad4ba7d85a6f5db890daf3f50', '2021-01-29 09:25:13', '1', '2021-01-29 09:28:56', '1', null, '0');
INSERT INTO `edu_video` VALUES ('126', '37', '22', '2-4 MySQL数据类型之日期时间型', '1', '0', '1', '8da5b2b498bb4f58b6ce5bdb355a14a2', '181.557', '0', '', '5360179', '1', null, '76cdfe40bd94fc05812c6267a8b757f2', '2021-01-29 09:25:21', '1', '2021-01-29 09:29:35', '1', null, '0');
INSERT INTO `edu_video` VALUES ('127', '37', '22', '2-5 MySQL数据类型之字符型', '1', '0', '1', '5ce462e2a0c6442cb13f2e4fbb7bd63a', '100.032', '0', '', '3636666', '1', null, 'f30fcd0646dcc0bfea272b1cb080a658', '2021-01-29 09:25:29', '1', '2021-01-29 09:49:59', '1', null, '0');
INSERT INTO `edu_video` VALUES ('128', '37', '22', '2-6 MySQL创建数据表', '1', '0', '1', '68c107a53d3e477981ed405ddb84e056', '204.568', '0', '', '7613620', '1', null, 'ddc19acbe90a3968e83c8cad7291b244', '2021-01-29 09:25:38', '1', '2021-01-29 09:56:07', '1', null, '0');
INSERT INTO `edu_video` VALUES ('129', '37', '22', '2-7 MySQL查看数据表', '1', '0', '1', '2df7603078cc42ab970747ac2d1a308f', '130.032', '0', '', '4291248', '1', null, '16a5e8377d5d714d2132c7cd4f023ac3', '2021-01-29 09:25:57', '1', '2021-01-29 09:57:01', '1', null, '0');
INSERT INTO `edu_video` VALUES ('130', '37', '22', '2-8 MySQL查看数据表结构', '1', '0', '1', '90f85dd4e04047f3bbf8bc761e526e24', '75.5577', '0', '', '2562877', '1', null, '14678fd47a90e77efbb1d1bd23ec00a2', '2021-01-29 09:26:05', '1', '2021-01-29 09:57:31', '1', null, '0');
INSERT INTO `edu_video` VALUES ('131', '37', '22', '2-9 MySQL记录的插入与查找', '1', '0', '1', 'cc4161acfbfc4cc4b0d82b8d87e0e3b6', '144.057', '0', '', '5123384', '1', null, '71b320a9449b3e815a6f02864403fa5a', '2021-01-29 09:26:12', '1', '2021-01-29 09:58:07', '1', null, '0');
INSERT INTO `edu_video` VALUES ('132', '37', '22', '2-10 MySQL空值与非空', '1', '0', '1', 'dcf1d06c735e4ca1a047d4dcf68a0edc', '364.437', '0', '', '14014330', '1', null, '4fd4b9f0efd8ce165431968568afc9b7', '2021-01-29 09:26:22', '1', '2021-01-29 09:59:12', '1', null, '0');
INSERT INTO `edu_video` VALUES ('133', '37', '22', '2-11 MySQL自动编号', '1', '0', '1', 'cba0226db1f842da9b136e53b62cd50d', '256.557', '0', '', '8063712', '1', null, '6ac6224a37920720a14d611741a2e736', '2021-01-29 09:26:31', '1', '2021-01-29 09:59:59', '1', null, '0');
INSERT INTO `edu_video` VALUES ('134', '37', '22', '2-12 MySQL初涉主键约束', '1', '0', '1', 'abaebda365874687b73b0e8f92b9c4e1', '254.56', '0', '', '9592929', '1', null, '673fa6930f85f2abc7af88e542b0a834', '2021-01-29 09:26:38', '1', '2021-01-29 10:01:11', '1', null, '0');
INSERT INTO `edu_video` VALUES ('135', '37', '22', '2-13 MySQL初涉唯一约束', '1', '0', '1', '0256aa5f03ee48bb86f53d37cbe1482d', '424.925', '0', '', '14830993', '1', null, 'c8bb8119932fb1524fc9f53e2a8fdc1e', '2021-01-29 09:26:45', '1', '2021-01-29 10:02:26', '1', null, '0');
INSERT INTO `edu_video` VALUES ('136', '37', '23', '3-1 MySQL 外键约束的要求解析', '1', '0', '0', '87c84443e9974da3b537197504ac9c31', '580.058', '0', '', '21979380', '1', null, 'bb413e4f3ea316c6d802115155d6067b', '2021-01-29 10:05:17', '1', '2021-01-29 10:08:55', '1', null, '0');
INSERT INTO `edu_video` VALUES ('137', '37', '23', '3-2 MySQL外键约束的参照操作', '1', '0', '0', 'b849f961043c440087245c66d3ef0b42', '430.893', '0', '', '18356902', '1', null, '23fd781405cc0e61ef493f1decec9d68', '2021-01-29 10:05:50', '1', '2021-01-29 12:09:27', '1', null, '0');
INSERT INTO `edu_video` VALUES ('138', '37', '23', '3-3 MySQL 表级约束与列级约束', '1', '0', '0', '3ef3a484d16f442cb36d2fb7d63ee0f5', '74.0252', '0', '', '3378055', '1', null, '204345bbdfba1bb528324cb08ee1b7e7', '2021-01-29 10:06:00', '1', '2021-01-29 12:14:02', '1', null, '0');
INSERT INTO `edu_video` VALUES ('139', '37', '23', '3-4 MySQL 修改数据表-添加或删除列', '1', '0', '0', '2f4df5d65b57470f99b330d90b61ac96', '430.057', '0', '', '16462862', '1', null, 'e91b8499b3ef8c759d8aef388eb1ddb4', '2021-01-29 10:06:13', '1', '2021-01-29 12:30:53', '1', null, '0');
INSERT INTO `edu_video` VALUES ('140', '37', '23', '3-5 MySQL 修改数据表--添加约束', '1', '0', '0', '0abfe7e2004c44ed807d056067acb910', '343.028', '0', '', '12789815', '1', null, '2d1f187b12b471ea76725a370abfcbe2', '2021-01-29 10:06:41', '1', '2021-01-29 12:40:51', '1', null, '0');
INSERT INTO `edu_video` VALUES ('141', '37', '23', '3-6 MySQL 修改数据表--删除约束', '1', '0', '0', '2c266a26ece946a48f3dda447414be4b', '186.526', '0', '', '6646227', '1', null, 'c30a53be2111b14502926b12b835c516', '2021-01-29 10:06:53', '1', '2021-01-29 12:46:18', '1', null, '0');
INSERT INTO `edu_video` VALUES ('142', '37', '23', '3-7 MySQL 修改数据表--修改列定义和更名数据表', '1', '0', '0', '3dd2e9af1e2142ab962ef58185d067c8', '348.531', '0', '', '12918796', '1', null, '10f7319c9d1d1c441cc1d4a7ec7c9262', '2021-01-29 10:07:03', '1', '2021-01-29 12:45:32', '1', null, '0');
INSERT INTO `edu_video` VALUES ('143', '37', '24', '4-1 MySQL 插入记录INSERT', '1', '0', '0', '9f28de06e9ae4e209faf2c7e9be612af', '289.065', '0', '', '10090711', '1', null, 'eb94b360110f31da0136bbfcc97e3122', '2021-01-29 12:46:56', '1', '2021-01-29 12:49:32', '1', null, '0');
INSERT INTO `edu_video` VALUES ('144', '37', '24', '4-2 MySQL 插入记录INSERT SET-SELECT', '1', '0', '0', '65b75d353820474494e130a08ec2c4b3', '125.434', '0', '', '4771188', '1', null, '2d3d336b8edeb0f7b56276f326c06dff', '2021-01-29 12:47:08', '1', '2021-01-29 12:50:10', '1', null, '0');
INSERT INTO `edu_video` VALUES ('145', '37', '24', '4-3 MySQL 单表更新记录UPDATE', '1', '0', '0', 'b4bc6d348a034b7c84f2352ec63242c4', '196.069', '0', '', '6268340', '1', null, '99172b05e5ff4fdc8a7035c41379773c', '2021-01-29 12:47:16', '1', '2021-01-29 12:50:51', '1', null, '0');
INSERT INTO `edu_video` VALUES ('146', '37', '24', '4-4 MySQL 单表删除记录DELETE', '1', '0', '0', '227bfbfa2f8244b59b8a797571a5d998', '100.032', '0', '', '3332111', '1', null, '2e2ad14fe17db23d4dd81a596f805823', '2021-01-29 12:47:26', '1', '2021-01-29 12:52:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('147', '37', '24', '4-5 MySQL 查询表达式解析', '1', '0', '0', '83cd4fa1dc874e7aaf1b4a05dafd867d', '284.026', '0', '', '10411381', '1', null, '93a597a8a69113d228a1cedae0216847', '2021-01-29 12:47:35', '1', '2021-01-29 12:55:53', '1', null, '0');
INSERT INTO `edu_video` VALUES ('148', '37', '24', '4-6 MySQL where语句进行条件查询', '1', '0', '0', 'e07d43c5d60f4bca8d51fb5648d62734', '78.0655', '0', '', '2606944', '1', null, '8f40a1f437b387033bc38deaad1b4996', '2021-01-29 12:47:50', '1', '2021-01-29 12:56:26', '1', null, '0');
INSERT INTO `edu_video` VALUES ('149', '37', '24', '4-7 MySQL group by语句对查询结果分组', '1', '0', '0', '496aedfd00cf4a6ebe43b0f33484ae2f', '154.064', '0', '', '6006662', '1', null, 'b0ec778d62f6ed0a93195cf00e51aa5d', '2021-01-29 12:48:02', '1', '2021-01-29 12:57:14', '1', null, '0');
INSERT INTO `edu_video` VALUES ('150', '37', '24', '4-8 having语句设置分组条件', '1', '0', '0', 'fbcb6b7496694d3292d5f786ac3bae6f', '175.566', '0', '', '6198939', '1', null, '44341bb01e4581959ffb942ec2892968', '2021-01-29 12:48:12', '1', '2021-01-29 12:58:59', '1', null, '0');
INSERT INTO `edu_video` VALUES ('151', '37', '24', '4-9 order by语句对查询结果排序', '1', '0', '0', 'd0c29a076e724196a7d599a5b795f9f6', '174.057', '0', '', '5783700', '1', null, 'a3a3122175349cfba693c774f815a18b', '2021-01-29 12:48:27', '1', '2021-01-29 12:59:44', '1', null, '0');
INSERT INTO `edu_video` VALUES ('152', '37', '24', '4-10 limit语句限制查询数量', '1', '0', '0', 'a5ad18fb5fa942dc982ea4ce9b62563c', '118.468', '0', '', '3978119', '1', null, '4a3f4bc17e1b0b882cfbcf94f898a8f8', '2021-01-29 12:48:37', '1', '2021-01-29 13:04:18', '1', null, '0');
INSERT INTO `edu_video` VALUES ('153', '37', '25', '5-1 MySql 子查询简介', '1', '0', '0', 'e5c2a3a4f4904a3886de55cac6f8194f', '110.527', '0', '', '4554345', '1', null, '7fefc0a9fc195b7d48c8a65569ae919e', '2021-01-29 13:05:32', '1', '2021-01-29 13:07:44', '1', null, '0');
INSERT INTO `edu_video` VALUES ('154', '37', '25', '5-2 由比较运算符引发的子查询', '1', '0', '0', '4391351cad19417d9307b4f43a092dde', '509.562', '0', '', '23844491', '1', null, 'bd575d45cebbfce3c07631298c470925', '2021-01-29 13:05:41', '1', '2021-01-29 13:09:40', '1', null, '0');
INSERT INTO `edu_video` VALUES ('155', '37', '25', '5-3 使用any、some或all修饰的比较运算符', '1', '0', '0', 'c56eab0b711c403ab6eb7914d730308f', '276.526', '0', '', '15193289', '1', null, 'eecfff66abad03bd1cc1ae37f81b79a7', '2021-01-29 13:05:55', '1', '2021-01-29 13:11:57', '1', null, '0');
INSERT INTO `edu_video` VALUES ('156', '37', '25', '5-4 由[NOT] IN或EXISTS引发的子查询', '1', '0', '0', '2b851e139c954e91afb4cbcd72ffcd8b', '113.569', '0', '', '5642223', '1', null, '707429d433d3b2ab0348814ade8432e7', '2021-01-29 13:06:06', '1', '2021-01-29 13:13:04', '1', null, '0');
INSERT INTO `edu_video` VALUES ('157', '37', '25', '5-5 使用INSERT...SELECT插入记录', '1', '0', '0', 'fbed95f2fe874f79be42701afbe53a4a', '306.062', '0', '', '12924256', '1', null, '900f8bbce2e3485ebcc4a8fd41a71c22', '2021-01-29 13:06:16', '1', '2021-01-29 13:14:20', '1', null, '0');
INSERT INTO `edu_video` VALUES ('158', '37', '25', '5-6 多表更新', '1', '0', '0', '128fcd5e55124539abe57344f142f8e7', '242.532', '0', '', '11123745', '1', null, '1477c0dcf6a1662c5fa1e8fdaf4e8ac4', '2021-01-29 13:06:26', '1', '2021-01-29 13:15:34', '1', null, '0');
INSERT INTO `edu_video` VALUES ('159', '37', '25', '5-7 多表更新之一步到位', '1', '0', '0', '22e63d9528e24159895b56936ac11c79', '403.4', '0', '', '21205062', '1', null, '78f693673e068587e25bbcf6a8ac2b2c', '2021-01-29 13:06:37', '1', '2021-01-29 13:32:22', '1', null, '0');
INSERT INTO `edu_video` VALUES ('160', '37', '25', '5-8 连接的语法结构', '1', '0', '0', '0d881d27ab494d3da893f9ba5a0657e2', '109.064', '0', '', '3504151', '1', null, 'c5fbc106a4c75ace86576866449cd4eb', '2021-01-29 13:06:46', '1', '2021-01-29 13:36:03', '1', null, '0');
INSERT INTO `edu_video` VALUES ('161', '37', '25', '5-9 内连接INNER JOIN', '1', '0', '0', 'f99bdad121334509a349639540406947', '243.066', '0', '', '8576555', '1', null, '1a42c7fb191ce9c1965650ebecf167a4', '2021-01-29 13:06:56', '1', '2021-01-29 13:37:11', '1', null, '0');
INSERT INTO `edu_video` VALUES ('162', '37', '25', '5-10 外连接OUTER JOIN', '1', '0', '0', 'eb9de8afab324332adc33534ddfc09e5', '281.008', '0', '', '10900666', '1', null, '5618882f8ebf7c6c6223daa1407bd114', '2021-01-29 13:07:12', '1', '2021-01-29 13:42:51', '1', null, '0');
INSERT INTO `edu_video` VALUES ('163', '38', '26', '1-1 课程概述', '1', '0', '0', '14fd92f8dcef44b1941187610c5ff36f', '63.0654', '0', '', '1978162', '1', null, '4a7a226c7ac89ed5a6e0618e22cc5a56', '2021-01-29 15:42:22', '1', '2021-01-29 15:42:55', '1', null, '0');
INSERT INTO `edu_video` VALUES ('164', '38', '26', '1-2 Junit4简介', '1', '0', '0', 'd64e94bf4f0e43b28f330881b48f4cdd', '108.53', '0', '', '4714743', '1', null, '8812719f5a679e106b1615cdbfa8d3ca', '2021-01-29 15:42:33', '1', '2021-01-29 15:43:52', '1', null, '0');
INSERT INTO `edu_video` VALUES ('165', '38', '27', '2-1 JUnit4快速入门', '1', '0', '0', '4153a9b5cde44ecfabbdaa4ce1980a88', '552.031', '0', '', '26677633', '1', null, 'b9cb84e5a9b25c6ee438e6e629d26a13', '2021-01-29 15:45:56', '1', '2021-01-29 15:47:43', '1', null, '0');
INSERT INTO `edu_video` VALUES ('166', '38', '28', '3-1 完善代码', '1', '0', '0', '74df9ed9436446388b48437cf7d42610', '214.46', '0', '', '12117261', '1', null, '97fa07d1fefd3fdfac6644aa6b09dd72', '2021-01-29 15:48:16', '1', '2021-01-29 15:50:10', '1', null, '0');
INSERT INTO `edu_video` VALUES ('167', '38', '28', '3-2 测试失败的两种情况', '1', '0', '0', 'b1272652161c49acb0d73aade14fdecc', '162.029', '0', '', '8519943', '1', null, 'fd8cdf854348c64676bf9c53949b4200', '2021-01-29 15:48:27', '1', '2021-01-29 15:51:30', '1', null, '0');
INSERT INTO `edu_video` VALUES ('168', '38', '28', '3-3 IDEA安装JUnit4插件', '1', '0', '0', '575deeb9ccee499798861527d94e5915', '110.063', '0', '', '5522760', '1', null, '8d55fa915dc3f80d65bc7e1df826f76f', '2021-01-29 15:48:36', '1', '2021-01-29 15:52:12', '1', null, '0');
INSERT INTO `edu_video` VALUES ('169', '38', '28', '3-4 在IDEA中使用JUnit4插件', '1', '0', '0', '51dbe88e820f45baa4aef13ea726e356', '265.033', '0', '', '16643554', '1', null, '414a83092c0abb77398eba80f5427965', '2021-01-29 15:48:46', '1', '2021-01-29 15:53:27', '1', null, '0');
INSERT INTO `edu_video` VALUES ('170', '38', '28', '3-5 JUnit运行流程', '1', '0', '0', '4e7a142d7d314f3797b4c260a967a752', '135.558', '0', '', '7846054', '1', null, '4cbc51c10c7a52264b22051ff3d9d723', '2021-01-29 15:48:56', '1', '2021-01-29 15:55:28', '1', null, '0');
INSERT INTO `edu_video` VALUES ('171', '38', '28', '3-6 JUnit常用注解', '1', '0', '0', 'ac5e80e76d6743aba2d66dc8d44340ee', '103.027', '0', '', '5598970', '1', null, 'bbb7cd3654781dd2cc82cae75087c329', '2021-01-29 15:49:06', '1', '2021-01-29 15:56:15', '1', null, '0');
INSERT INTO `edu_video` VALUES ('172', '38', '29', '4-1 JUnit4测试套件的使用', '1', '0', '0', '0af20ee809084d12b5025d4c7ccf5248', '301.023', '0', '', '15553230', '1', null, '6879059b543d08d6967c4d96400ceb51', '2021-01-29 15:58:23', '1', '2021-01-29 15:59:33', '1', null, '0');
INSERT INTO `edu_video` VALUES ('173', '39', '30', '1-1 jdbc概述', '1', '0', '0', 'eb1666da4f2346788ffb08ccff62249a', '228.066', '0', '', '9655835', '1', null, '4c1e90f4fdf1c0841b71f64b6a676a24', '2021-01-29 18:15:40', '1', '2021-01-29 18:16:26', '1', null, '0');
INSERT INTO `edu_video` VALUES ('174', '39', '31', '2-1 加载一个Driver驱动', '1', '0', '0', 'd84f382f08ec4bdebcf44c0bbfd026ed', '354.569', '0', '', '20733434', '1', null, 'c1406ff50dae5365211723c2fa5206c3', '2021-01-29 18:17:06', '1', '2021-01-29 18:19:30', '1', null, '0');
INSERT INTO `edu_video` VALUES ('175', '39', '31', '2-2 创建数据库连接', '1', '0', '0', '329e01e0a73f4fe0932e0c47830669bc', '288.067', '0', '', '15235983', '1', null, '95b0ea6d2601b244bcd08d21a228c862', '2021-01-29 18:17:16', '1', '2021-01-29 18:39:54', '1', null, '0');
INSERT INTO `edu_video` VALUES ('176', '39', '31', '2-3 创建Statement并发送命令', '1', '0', '0', '153fcb8fd0d8417da1c1b5b6ef5b6e5b', '488.478', '0', '', '28578843', '1', null, 'b29d07f87e545ad91ded0c0b52b26b0c', '2021-01-29 18:17:25', '1', '2021-01-29 18:54:02', '1', null, '0');
INSERT INTO `edu_video` VALUES ('177', '39', '31', '2-4 使用PreparedStatement防止SQL注入', '1', '0', '0', '5fa2f1941fbe4744ada143e37e187f71', '283.005', '0', '', '17977192', '1', null, 'e8f9b3b69798939a14cff7ba86e4ca1d', '2021-01-29 18:17:35', '1', '2021-01-29 18:56:43', '1', null, '0');
INSERT INTO `edu_video` VALUES ('178', '39', '31', '2-5 处理ResultSet结果', '1', '0', '0', '036bb1109d2a4f5a800d18d91b8cc1df', '316.024', '0', '', '19858658', '1', null, '02a625d4f695d6432b6c7bb51226e5b4', '2021-01-29 18:17:45', '1', '2021-01-29 18:59:52', '1', null, '0');
INSERT INTO `edu_video` VALUES ('179', '39', '31', '2-6 关闭数据库资源', '1', '0', '1', '6684da6295de4501bc08259445055285', '309.499', '0', '', '21107982', '1', null, '459091c69f892b77f60baa9907026138', '2021-01-29 18:17:55', '1', '2021-01-29 19:03:58', '1', null, '0');
INSERT INTO `edu_video` VALUES ('180', '39', '32', '3-1 事务的概念', '1', '0', '0', 'c021f82de8214322ad4e1752c356af02', '109.505', '0', '', '6560796', '1', null, '1e69666be021bf2af3b434b46556f4f2', '2021-01-29 19:04:52', '1', '2021-01-29 19:06:23', '1', null, '0');
INSERT INTO `edu_video` VALUES ('181', '39', '32', '3-2 事务的特点', '1', '0', '0', '98ba78e5979141bb88cec00e9754b3b6', '91.5331', '0', '', '5231258', '1', null, 'f1e0105ee16f285388f034b814d0d704', '2021-01-29 19:05:03', '1', '2021-01-29 19:08:17', '1', null, '0');
INSERT INTO `edu_video` VALUES ('182', '39', '32', '3-3 事务的隔离级别', '1', '0', '0', 'bebdc70848c54290854d3b5faa9325d5', '347.069', '0', '', '11203449', '1', null, '73f62067c96ce27b3e88f4d90afd2a13', '2021-01-29 19:05:12', '1', '2021-01-29 19:09:38', '1', null, '0');
INSERT INTO `edu_video` VALUES ('183', '39', '32', '3-4 手动启动事务管理', '1', '0', '0', 'db21ac36fca94629a22863ee738e4f15', '580.568', '0', '', '42894438', '1', null, '4f3c127a53b902863c27b9452b646c83', '2021-01-29 19:05:20', '1', '2021-01-29 19:14:14', '1', null, '0');
INSERT INTO `edu_video` VALUES ('184', '39', '32', '3-5 使用批处理Batch插入数据', '1', '0', '0', '84da21efe36d4f20b3b35e08e7f30b9b', '382.526', '0', '', '26925472', '1', null, '0455f9e79bf1404ad4c548d86f7e87a9', '2021-01-29 19:05:30', '1', '2021-01-29 19:19:42', '1', null, '0');
INSERT INTO `edu_video` VALUES ('185', '39', '32', '3-6 连接池', '1', '0', '0', '97a82aa2818241259fd310b04bdfb4aa', '317.533', '0', '', '18880427', '1', null, '8bf9494cc73c5a083e5f878173ce3523', '2021-01-29 19:05:40', '1', '2021-01-29 19:21:12', '1', null, '0');
INSERT INTO `edu_video` VALUES ('186', '39', '33', '4-1 了解DBUtils', '1', '0', '0', '855639e3b9ae4b088b32d6b1a9e4951a', '218.569', '0', '', '12447603', '1', null, '0517222b383569f351e4f2f76aaff47a', '2021-01-29 19:21:57', '1', '2021-01-29 19:23:35', '1', null, '0');
INSERT INTO `edu_video` VALUES ('187', '39', '33', '4-2 使用DBUtils工具实现新增数据', '1', '0', '0', '4c96529f58454f99aedf7ac155d2e033', '374.561', '0', '', '24957858', '1', null, '29a79d0ba7fae3e9f3399bf632f6e058', '2021-01-29 19:22:09', '1', '2021-01-29 19:25:42', '1', null, '0');
INSERT INTO `edu_video` VALUES ('188', '39', '33', '4-3 使用DBUtils工具实现更新数据', '1', '0', '0', 'b78018caa6b64680bdd5e696cc3c84d0', '143.058', '0', '', '8796782', '1', null, 'b35f337d643192634a3a285a782af4a5', '2021-01-29 19:22:17', '1', '2021-01-29 19:27:30', '1', null, '0');
INSERT INTO `edu_video` VALUES ('189', '39', '33', '4-4 使用DBUtils工具实现查询数据', '1', '0', '0', '983c806a6d3a41f2b393e5b45f43c836', '174.568', '0', '', '11606090', '1', null, '768d61cc1e78cddf7899f69abf98d57d', '2021-01-29 19:22:28', '1', '2021-01-29 19:30:02', '1', null, '0');
INSERT INTO `edu_video` VALUES ('190', '39', '33', '4-5 使用DBUtils工具实现删除数据', '1', '0', '0', '84bf8d8b79494bc38feaa484bf62a499', '111.479', '0', '', '7666383', '1', null, 'e4a78b5096dd8cbb697cd51b8efced0b', '2021-01-29 19:22:38', '1', '2021-01-29 19:39:38', '1', null, '0');
INSERT INTO `edu_video` VALUES ('191', '40', '34', '1-1 认识html5', '1', '0', '0', 'd76f6a11775a44728085e36887afebbc', '174.893', '0', '', '6654384', '1', null, '9d0bf08bae25c33c8d1bf110cff9e633', '2021-01-29 19:47:57', '1', '2021-01-29 19:49:16', '1', null, '0');
INSERT INTO `edu_video` VALUES ('192', '40', '34', '1-2 认识html标签和元素', '1', '0', '0', '6521fdc5e09b4a778eb5e2124abf8c52', '131.495', '0', '', '6063157', '1', null, '193daea56a4878c01f196a42047a09d2', '2021-01-29 19:48:11', '1', '2021-01-29 19:50:00', '1', null, '0');
INSERT INTO `edu_video` VALUES ('193', '40', '34', '1-3 认识html文件基本结构', '1', '0', '0', 'e6527a972177472dac1830e208e08a35', '131.03', '0', '', '5844370', '1', null, '95c5d4c5d430d0ac98369a2b60db18e7', '2021-01-29 19:48:20', '1', '2021-01-29 19:51:27', '1', null, '0');
INSERT INTO `edu_video` VALUES ('194', '40', '34', '1-4 认识head标签', '1', '0', '0', '26340a52ba284264a65bb9821527be86', '106.533', '0', '', '5459780', '1', null, 'fafad3904f556115839eded46ca2450e', '2021-01-29 19:48:29', '1', '2021-01-29 19:52:21', '1', null, '0');
INSERT INTO `edu_video` VALUES ('195', '40', '34', '1-5 了解HTML的代码注释', '1', '0', '0', 'a84d2a92d2684cd280120e007a55c4c8', '120.024', '0', '', '4709315', '1', null, '4cbaf8e7b04c3cb1c278265234bc4b94', '2021-01-29 19:48:38', '1', '2021-01-29 19:52:56', '1', null, '0');
INSERT INTO `edu_video` VALUES ('196', '40', '35', '2-1使用P标签，添加段落', '1', '0', '0', '0eaf4995543f4b45a62804c22f564217', '80.5268', '0', '', '3679295', '1', null, '3b173dba7be4a1c4e1a662f0ce8e27ae', '2021-01-29 19:53:12', '1', '2021-01-29 19:54:27', '1', null, '0');
INSERT INTO `edu_video` VALUES ('197', '40', '35', '2-2 了解hx标签，为你的网页添加标题', '1', '0', '0', '15e1e18b984e406f81dae665b33e3abf', '168.066', '0', '', '7099028', '1', null, '936fd0a59512401c699227694f032992', '2021-01-29 19:53:23', '1', '2021-01-29 19:55:18', '1', null, '0');
INSERT INTO `edu_video` VALUES ('198', '40', '35', '2-3 加入强调语气，使用strong和em标签', '1', '0', '0', 'f9745323ace640f6ba2268f80381d7dd', '144.01', '0', '', '6889250', '1', null, '5620b587819e88a3679beb1c992ac509', '2021-01-29 19:53:31', '1', '2021-01-29 19:56:14', '1', null, '0');
INSERT INTO `edu_video` VALUES ('199', '40', '35', '2-4 使用span标签为文字设置单独样式', '1', '0', '0', 'faeb7b341dd8433aaa009dba8f4e2f1a', '207.563', '0', '', '12153248', '1', null, '48892f82b7cd1806732746743bc6d6c4', '2021-01-29 19:53:40', '1', '2021-01-29 19:57:50', '1', null, '0');
INSERT INTO `edu_video` VALUES ('200', '40', '35', '2-5 使用br标签分行显示文本', '1', '0', '0', 'deac206f2cc94f889085e5ec2e7f0b47', '81.8968', '0', '', '3346402', '1', null, '81ce0809df3f6c142ac9eb2553793b61', '2021-01-29 19:53:51', '1', '2021-01-29 19:58:32', '1', null, '0');
INSERT INTO `edu_video` VALUES ('201', '40', '35', '2-6 address标签，为网页加入地址信息', '1', '0', '0', 'c0ccd8345e5146aaaa42cd2fc97abd47', '72.5624', '0', '', '3091040', '1', null, '57c7ec549f8a3d99967b2c7cc6c89171', '2021-01-29 19:54:01', '1', '2021-01-29 19:58:59', '1', null, '0');
INSERT INTO `edu_video` VALUES ('202', '40', '36', '3-1 使用ul，添加新闻信息列表', '1', '0', '0', 'c3aaef8f2b7845ba9bddcbdd3f16b082', '167.068', '0', '', '10448654', '1', null, 'bfe60716b46dfcc953281b615e4f9b88', '2021-01-29 19:59:33', '1', '2021-01-29 20:01:19', '1', null, '0');
INSERT INTO `edu_video` VALUES ('203', '40', '36', '3-2 使用ol，添加图书销售排行榜', '1', '0', '0', '9a530d7661e54c42ae31254720f21813', '118.561', '0', '', '5411931', '1', null, '860e69edc317170a33af181eb8056093', '2021-01-29 19:59:43', '1', '2021-01-29 20:01:58', '1', null, '0');
INSERT INTO `edu_video` VALUES ('204', '40', '36', '3-3 认识div在排版中的作用', '1', '0', '0', '94b31c2c9cc448d581fdb5b910f3fd5d', '110.063', '0', '', '6068615', '1', null, '3e298cb237a5f15d78269646730b58e9', '2021-01-29 19:59:51', '1', '2021-01-29 20:02:43', '1', null, '0');
INSERT INTO `edu_video` VALUES ('205', '40', '36', '3-4 给div命名，使逻辑更加清晰', '1', '0', '0', 'f18af7b0ba454d10b5f5b73a7da9633d', '94.5284', '0', '', '5420640', '1', null, '67edc8c2430d271a7ddc424679bc5734', '2021-01-29 20:00:00', '1', '2021-01-29 20:03:17', '1', null, '0');
INSERT INTO `edu_video` VALUES ('206', '40', '36', '3-5 table标签，认识网页上的表格', '1', '0', '0', '23db2ba943144cd59bae4d09fc889247', '341.542', '0', '', '18177874', '1', null, '50baf1c38acd9b704a33ea6f6cbf0f08', '2021-01-29 20:00:14', '1', '2021-01-29 20:04:46', '1', null, '0');
INSERT INTO `edu_video` VALUES ('207', '40', '37', '4-1 使用a标签，链接到另一个页面', '1', '0', '0', 'f1e17dc0fdf94dd8a5e113ed7ec47d5c', '267.564', '0', '', '11424265', '1', null, 'f55b9755a545961f02a84b9c53ee2c6f', '2021-01-29 20:05:15', '1', '2021-01-29 20:06:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('208', '40', '37', '4-2 a标签target属性', '1', '0', '0', '8a334b226fc34645891cba696d2e2ddb', '240.536', '0', '', '17990271', '1', null, '7d180c8ee6dadac4783a59eb030bad42', '2021-01-29 20:05:25', '1', '2021-01-29 20:09:52', '1', null, '0');
INSERT INTO `edu_video` VALUES ('209', '40', '37', '4-3 认识img标签，为网页插入图片', '1', '0', '0', 'aec2746ccf10432f9f8fda1be2af61ce', '221.1', '0', '', '13363436', '1', null, 'c0eb20f4499657541b106b54522e8208', '2021-01-29 20:05:34', '1', '2021-01-29 20:19:25', '1', null, '0');
INSERT INTO `edu_video` VALUES ('210', '40', '37', '4-4认识video标签，为网页插入视频', '1', '0', '0', '8197411ad0194b9aa55f5e026cea5994', '182.532', '0', '', '8472566', '1', null, '5432c435201621780f175dea061e757a', '2021-01-29 20:05:43', '1', '2021-01-29 20:20:23', '1', null, '0');
INSERT INTO `edu_video` VALUES ('211', '40', '38', '5-1 使用表单标签，与用户交互', '1', '0', '0', '92ead5113bf445d7b77e6033601ae25a', '270.025', '0', '', '11192589', '1', null, 'ff5661994ca2f394f34401043f05014d', '2021-01-29 20:21:38', '1', '2021-01-29 20:23:21', '1', null, '0');
INSERT INTO `edu_video` VALUES ('212', '40', '38', '5-2 文本输入框、密码输入框', '1', '0', '0', '171e09eac91748ceb015e38270bc9bb6', '155.434', '0', '', '5992718', '1', null, 'c250bbada22b7176c721f1c11de415ff', '2021-01-29 20:21:50', '1', '2021-01-29 20:24:04', '1', null, '0');
INSERT INTO `edu_video` VALUES ('213', '40', '38', '5-3 文本域，支持多行文本输入', '1', '0', '0', '78935150a5494a15a9c531aa30d0b92a', '156.503', '0', '', '6502339', '1', null, 'd4db8751bc211f69ac44e14e34187d7a', '2021-01-29 20:22:05', '1', '2021-01-29 20:24:53', '1', null, '0');
INSERT INTO `edu_video` VALUES ('214', '40', '38', '5-4 使用单选框、复选框，让用户选择', '1', '0', '0', '5a2b6162b8ca458884b34a4e7043c302', '294.057', '0', '', '13714626', '1', null, '7dd5f728873e2684fe5b2cbdd35fc975', '2021-01-29 20:22:18', '1', '2021-01-29 20:26:04', '1', null, '0');
INSERT INTO `edu_video` VALUES ('215', '40', '38', '5-5 使用下拉列表框，节省空间', '1', '0', '0', '2970bfca19c14f749bc20e1034cad9b5', '178.027', '0', '', '7120368', '1', null, '5a6dc749ffb0337b1813d3cf07032917', '2021-01-29 20:22:28', '1', '2021-01-29 20:26:48', '1', null, '0');
INSERT INTO `edu_video` VALUES ('216', '41', '39', '1-1 认识CSS样式', '1', '0', '0', 'cd21a61ee7d04e32b92c53e5fd74e6ff', '229.994', '0', '', '9536832', '1', null, 'aa317f644f9dc2227a33ba6b3d1bc07f', '2021-01-29 20:32:43', '1', '2021-01-29 20:33:55', '1', null, '0');
INSERT INTO `edu_video` VALUES ('217', '41', '39', '1-2 CSS代码语法', '1', '0', '0', '6318c6fb30024fcc91f41a887bb17016', '142.524', '0', '', '6845763', '1', null, '150f5dae8447e91c7f558b5bf751c571', '2021-01-29 20:32:55', '1', '2021-01-29 20:34:44', '1', null, '0');
INSERT INTO `edu_video` VALUES ('218', '41', '39', '1-3 CSS注释代码', '1', '0', '0', '6921089cc9ae43f08dd07c7d5a2f997f', '62.0669', '0', '', '2341056', '1', null, 'b070487639955b9fb803113eebdf09c1', '2021-01-29 20:33:04', '1', '2021-01-29 20:35:06', '1', null, '0');
INSERT INTO `edu_video` VALUES ('219', '41', '40', '2-1 内联式css样式，直接写在现有的HTML标签中', '1', '0', '0', 'd7a8eb3ac7a8427da9e62e5c54a5037e', '195.024', '0', '', '8476867', '1', null, 'ba1797774b3ca9f90e28b228f493007f', '2021-01-29 20:35:26', '1', '2021-01-29 20:36:34', '1', null, '0');
INSERT INTO `edu_video` VALUES ('220', '41', '40', '2-2 嵌入式css样式，写在当前的文件中', '1', '0', '0', '731def4b2c8f4e5dba808a0564f2e22b', '105.558', '0', '', '4200097', '1', null, 'ac58766f6e562c6c8134c4231188e497', '2021-01-29 20:35:36', '1', '2021-01-29 20:37:11', '1', null, '0');
INSERT INTO `edu_video` VALUES ('221', '41', '40', '2-3 外部式css样式，写在单独的一个文件中', '1', '0', '0', '50e39cef5f8e479ab7ce8dc5397bc50f', '283.028', '0', '', '13242817', '1', null, '985121b3bf5be03fe7e3c0b89773efe1', '2021-01-29 20:35:46', '1', '2021-01-29 20:38:12', '1', null, '0');
INSERT INTO `edu_video` VALUES ('222', '41', '40', '2-4 三种方法的优先级', '1', '0', '0', '716ff4e18b4a43918b2adf29320de412', '352.502', '0', '', '15636787', '1', null, 'f8ec4d00674bdac53f064ef314ae2692', '2021-01-29 20:35:54', '1', '2021-01-29 20:39:42', '1', null, '0');
INSERT INTO `edu_video` VALUES ('223', '41', '41', '3-1 什么是选择器', '1', '0', '0', '7545332b613b482f867ed3fa302bc15e', '78.0655', '0', '', '3562812', '1', null, 'd6ab19437c6ea2941a0502407f742778', '2021-01-29 20:40:02', '1', '2021-01-29 20:41:55', '1', null, '0');
INSERT INTO `edu_video` VALUES ('224', '41', '41', '3-2 标签选择器', '1', '0', '0', 'da67448b0abc4896add8ce4a61290d9f', '61.0685', '0', '', '2663803', '1', null, 'b1068ec65c8d4b84a73b9e0fe45166fb', '2021-01-29 20:40:12', '1', '2021-01-29 20:42:24', '1', null, '0');
INSERT INTO `edu_video` VALUES ('225', '41', '41', '3-3 类选择器', '1', '0', '0', 'c1bc8807606240999d1d706b5f27dc0e', '278.059', '0', '', '11449557', '1', null, '09209d0f9ff7e03cb2cac8be2f031a4b', '2021-01-29 20:40:21', '1', '2021-01-29 20:43:28', '1', null, '0');
INSERT INTO `edu_video` VALUES ('226', '41', '41', '3-4 ID选择器', '1', '0', '0', '0ef272a771374138a8cdfa2ac9500c47', '100.032', '0', '', '4426890', '1', null, '1ee9acc3bae56257c54c7b77a94de247', '2021-01-29 20:40:29', '1', '2021-01-29 20:44:10', '1', null, '0');
INSERT INTO `edu_video` VALUES ('227', '41', '41', '3-5 类和ID选择器的区别', '1', '0', '0', '99954e7c9d734a84a3aa0dd429fb1379', '297.935', '0', '', '17422246', '1', null, '69414372c82978eed2e2def33f3a5b04', '2021-01-29 20:40:40', '1', '2021-01-29 20:45:35', '1', null, '0');
INSERT INTO `edu_video` VALUES ('228', '41', '41', '3-6 子选择器', '1', '0', '0', '711a8de0b5974ec382bbfd16b0b9ae53', '255.025', '0', '', '9813448', '1', null, '08d2952ab304f198fab4168dcc7d1a0b', '2021-01-29 20:40:50', '1', '2021-01-29 20:46:28', '1', null, '0');
INSERT INTO `edu_video` VALUES ('229', '41', '41', '3-7 包含(后代)选择器', '1', '0', '0', '8610fdeb0ea5406f9a5c4e86679f228f', '267.03', '0', '', '12841826', '1', null, '81489bd55aec37ae2f565883aaa7302a', '2021-01-29 20:40:59', '1', '2021-01-29 20:47:47', '1', null, '0');
INSERT INTO `edu_video` VALUES ('230', '41', '41', '3-8 通用选择器', '1', '0', '0', 'c4f182da18d44a44b0c6d35c72afbd7d', '109.064', '0', '', '4913238', '1', null, '7e894a8cad7676f058298661c3b91919', '2021-01-29 20:41:09', '1', '2021-01-29 20:48:23', '1', null, '0');
INSERT INTO `edu_video` VALUES ('231', '41', '41', '3-9 伪类选择符', '1', '0', '0', 'eeb0b3af55664c4386bec9c4484928f3', '225.512', '0', '', '11254307', '1', null, 'fd9df47a08257389feb237d6ee8411bd', '2021-01-29 20:41:19', '1', '2021-01-29 20:49:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('232', '41', '41', '3-10 分组选择符', '1', '0', '0', '23fc3198fb0f405ea6f11199eb879385', '144.567', '0', '', '5954264', '1', null, '0a69aaf4ecc5dbb3c09f55ad5c43ad3f', '2021-01-29 20:41:28', '1', '2021-01-29 20:50:16', '1', null, '0');
INSERT INTO `edu_video` VALUES ('233', '41', '42', '4-1 继承', '1', '0', '0', 'c631fb5613d940098f6ac3cc97d6d3d2', '235.032', '0', '', '10280461', '1', null, 'af43aec6fb5a1a634cb2fe7682003809', '2021-01-29 20:50:46', '1', '2021-01-29 20:52:10', '1', null, '0');
INSERT INTO `edu_video` VALUES ('234', '41', '42', '4-2 特殊性', '1', '0', '0', 'ad235f44f62b412f95f1923c0c4a30e2', '292.061', '0', '', '10797707', '1', null, 'b6a3ef4c2fb59ab3efd3eb4456ea09ff', '2021-01-29 20:50:56', '1', '2021-01-29 20:53:00', '1', null, '0');
INSERT INTO `edu_video` VALUES ('235', '41', '42', '4-3 层叠', '1', '0', '0', 'e03aa702835b43beb85c6e7b2ac0e2ce', '160.961', '0', '', '5979515', '1', null, '7a7ddfdc7d1639f129967174e0d522c5', '2021-01-29 20:51:04', '1', '2021-01-29 20:53:44', '1', null, '0');
INSERT INTO `edu_video` VALUES ('236', '41', '42', '4-4 重要性', '1', '0', '0', '4b1f9543c46e4dbab0a100457036944d', '106.069', '0', '', '3489243', '1', null, '1966d3b2a168c86906430e3af7fe5c05', '2021-01-29 20:51:17', '1', '2021-01-29 20:54:19', '1', null, '0');
INSERT INTO `edu_video` VALUES ('237', '41', '43', '5-1 文字排版--字体', '1', '0', '0', '9ce433b252964a03bd6f6bf66b8045e3', '196.557', '0', '', '9095587', '1', null, '207194918e43a5f417fe0adc3bf84994', '2021-01-29 20:54:38', '1', '2021-01-29 20:56:15', '1', null, '0');
INSERT INTO `edu_video` VALUES ('238', '41', '43', '5-2 文字排版--字号、颜色', '1', '0', '0', '6747594af86e4134881d5a5852422f2e', '92.0671', '0', '', '4000748', '1', null, 'e6879ac4c9ef4016206e787d6b36d7c6', '2021-01-29 20:54:48', '1', '2021-01-29 20:56:48', '1', null, '0');
INSERT INTO `edu_video` VALUES ('239', '41', '43', '5-3 文字排版--粗体、斜体', '1', '0', '0', '98026e9d25664c139125233825899592', '129.033', '0', '', '6064631', '1', null, 'e09294d2ed28a1779228a2fbe05b7f7e', '2021-01-29 20:54:57', '1', '2021-01-29 20:57:28', '1', null, '0');
INSERT INTO `edu_video` VALUES ('240', '41', '43', '5-4 文字排版--下划线、删除线', '1', '0', '0', '8563f1ee394740648970b3cb4cc86fcb', '118.561', '0', '', '4802042', '1', null, '46ecccd993ca7ee765cf2fee98c3e561', '2021-01-29 20:55:06', '1', '2021-01-29 20:58:10', '1', null, '0');
INSERT INTO `edu_video` VALUES ('241', '41', '43', '5-5 段落排版--缩进、行间距（行高）', '1', '0', '0', '9c53a0fa3e284a96ae0cd77f7042e047', '157.06', '0', '', '6843426', '1', null, '96a1395e92ab84def5113e35b1940f18', '2021-01-29 20:55:15', '1', '2021-01-29 20:59:10', '1', null, '0');
INSERT INTO `edu_video` VALUES ('242', '41', '43', '5-6 段落排版--中文字间距、字母间距、对齐', '1', '1', '0', '8e9da0b375714e5b86d8b8b383084223', '213.531', '0', '', '9213630', '1', null, 'b0be93102ef561088f174c58f312c960', '2021-01-29 20:55:32', '1', '2021-02-04 17:46:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('243', '42', '44', '1-1 元素分类', '1', '0', '0', 'bd2953684971416a8429361673e92449', '86.0299', '0', '', '4017109', '1', null, '85366c551433c790a4f4801b5d810803', '2021-01-29 21:05:33', '1', '2021-01-29 21:07:08', '1', null, '0');
INSERT INTO `edu_video` VALUES ('244', '42', '44', '1-2 元素分类--块级元素', '1', '0', '0', '8206e00e734e4611a034f652346ead78', '227.973', '0', '', '9325330', '1', null, '5f260b53d424b19c3b9b339aa081b24a', '2021-01-29 21:05:42', '1', '2021-01-29 21:08:04', '1', null, '0');
INSERT INTO `edu_video` VALUES ('245', '42', '44', '1-3 元素分类--内联元素', '1', '0', '0', 'a6560cb609ec4fb285230b2adccd85da', '142.524', '0', '', '6117852', '1', null, 'b50eef33b8efa4b7ea8f93e6a6ed131d', '2021-01-29 21:05:51', '1', '2021-01-29 21:08:53', '1', null, '0');
INSERT INTO `edu_video` VALUES ('246', '42', '44', '1-4 元素分类--内联块状元素', '1', '0', '0', '41b692f09f61495f8244e42e92588b78', '134.026', '0', '', '5847338', '1', null, 'ff1fd8dc5731b39038c9e2d288242080', '2021-01-29 21:06:00', '1', '2021-01-29 21:09:30', '1', null, '0');
INSERT INTO `edu_video` VALUES ('247', '42', '44', '1-5 盒子模型', '1', '0', '0', '9f4c61cd60a34aa9ba885e5efd6763f7', '398.06', '0', '', '17793130', '1', null, '42c2ee5ffa5006bfe4bec204c9ed26e2', '2021-01-29 21:06:07', '1', '2021-01-29 21:10:53', '1', null, '0');
INSERT INTO `edu_video` VALUES ('248', '42', '44', '1-6 盒模型--边框', '1', '0', '0', '391b4038816d46e585c9046ab11cdcbb', '331.534', '0', '', '15973932', '1', null, '89e29b1ff0fcc488e4355c95ad5189de', '2021-01-29 21:06:16', '1', '2021-01-29 21:12:17', '1', null, '0');
INSERT INTO `edu_video` VALUES ('249', '42', '44', '1-7 盒模型--填充', '1', '0', '0', '235bb81dfb854fd1ba7f007824094ae0', '168.53', '0', '', '7382128', '1', null, 'cc1fa99718b9e26befd73c3f39399d54', '2021-01-29 21:06:25', '1', '2021-01-29 21:13:02', '1', null, '0');
INSERT INTO `edu_video` VALUES ('250', '42', '44', '1-8 盒模型--边界', '1', '0', '0', 'c4b8516b12ab49d28b50f47099fab49d', '248.57', '0', '', '11322396', '1', null, '8b647725eb2786d397b4b556b56b5697', '2021-01-29 21:06:35', '1', '2021-01-29 21:14:03', '1', null, '0');
INSERT INTO `edu_video` VALUES ('251', '42', '45', '2-1 css布局模型', '1', '0', '0', 'f2efc8dcc7c84a6893f0818d23c60009', '66.5252', '0', '', '2026963', '1', null, '38e14de887f62c2b3541103e8a1c5554', '2021-01-29 21:14:23', '1', '2021-01-29 21:15:57', '1', null, '0');
INSERT INTO `edu_video` VALUES ('252', '42', '45', '2-2 流动模型', '1', '0', '0', '04657247872c4ce9bb79d6e78880f8f3', '262.06', '0', '', '11019718', '1', null, '6ecccb54cfe7784f04875cae2358af94', '2021-01-29 21:14:33', '1', '2021-01-29 21:17:04', '1', null, '0');
INSERT INTO `edu_video` VALUES ('253', '42', '45', '2-3 浮动模型', '1', '0', '0', 'a528eb4d0a3f4605bc4d12357b8578ef', '265.567', '0', '', '10500727', '1', null, '4ae3bb29249aa2b8d243b7adfa5345cc', '2021-01-29 21:14:43', '1', '2021-01-29 21:18:26', '1', null, '0');
INSERT INTO `edu_video` VALUES ('254', '42', '45', '2-4 层模型', '1', '0', '0', 'e4c12b28c18a4dfca86781030e008877', '79.9927', '0', '', '4870077', '1', null, 'fe1039500d4b047a9cbb308e321e9aa7', '2021-01-29 21:14:51', '1', '2021-01-29 21:19:10', '1', null, '0');
INSERT INTO `edu_video` VALUES ('255', '42', '45', '2-5 层模型--绝对定位', '1', '0', '0', 'da56864562844d5bb85e7d2a7686bf0e', '282.54', '0', '', '11489902', '1', null, '216c6bc1c27982466e36f53fb3cedf82', '2021-01-29 21:15:01', '1', '2021-01-29 21:20:17', '1', null, '0');
INSERT INTO `edu_video` VALUES ('256', '42', '45', '2-6 层模型--相对定位', '1', '0', '0', 'ae20f38a90744059a87aaa357c3c371e', '259.065', '0', '', '9494303', '1', null, '738d6b0a490a84adc7a41b25de62bfdc', '2021-01-29 21:15:11', '1', '2021-01-29 21:21:10', '1', null, '0');
INSERT INTO `edu_video` VALUES ('257', '42', '45', '2-7 层模型--固定定位', '1', '0', '0', '20ea775f76bb403f92a6ffec2988180b', '125.527', '0', '', '14944939', '1', null, '2e015d815466af26c9ddb45ee93d9e55', '2021-01-29 21:15:24', '1', '2021-01-29 21:22:26', '1', null, '0');
INSERT INTO `edu_video` VALUES ('258', '42', '45', '2-8 Relative与Absolute组合使用', '1', '0', '0', '039e03a2c62e442f8d4193fea959ce8b', '512.441', '0', '', '24310077', '1', null, '8785912b9c979bd5d3d944864cced349', '2021-01-29 21:15:33', '1', '2021-01-29 21:24:15', '1', null, '0');
INSERT INTO `edu_video` VALUES ('259', '42', '46', '3-1 盒模型代码简写', '1', '0', '0', 'e3da47c804b94221bd51cadd4a35243b', '167.973', '0', '', '8731574', '1', null, '8a7fda585f2c65e719ff3e992452389c', '2021-01-29 21:24:36', '1', '2021-01-29 21:25:40', '1', null, '0');
INSERT INTO `edu_video` VALUES ('260', '42', '46', '3-2 颜色值缩写', '1', '0', '0', 'ae5fae8912c74c828d6d76fa6418b76b', '203.569', '0', '', '8803343', '1', null, '25885f74b7e06d1713d92a5ce85e6803', '2021-01-29 21:24:47', '1', '2021-01-29 21:26:36', '1', null, '0');
INSERT INTO `edu_video` VALUES ('261', '42', '46', '3-3 字体缩写', '1', '0', '0', '47e5e49df61c4866ae36c5cca03c60e0', '138.043', '0', '', '7649298', '1', null, 'aad31cf3df7e295db10d8ac88dc504f2', '2021-01-29 21:24:57', '1', '2021-01-29 21:27:22', '1', null, '0');
INSERT INTO `edu_video` VALUES ('262', '42', '47', '4-1 颜色值', '1', '0', '0', '0862a112d7624870bdc03204a55a1f09', '274.971', '0', '', '12310474', '1', null, '46e4d6c4ca4f25b5c074dbacc8d9733e', '2021-01-29 21:27:53', '1', '2021-01-29 21:29:03', '1', null, '0');
INSERT INTO `edu_video` VALUES ('263', '42', '47', '4-2 长度值', '1', '0', '0', 'b16a054602a64eee8027a3c8018a60c2', '337.432', '0', '', '15523178', '1', null, '9ca39bd55b89ea636c232abff6b02ec9', '2021-01-29 21:28:09', '1', '2021-01-29 21:30:20', '1', null, '0');
INSERT INTO `edu_video` VALUES ('264', '42', '48', '5-1 水平居中设置-行内元素', '1', '0', '0', 'b36c0d12af474c12a4f55d5d57691c27', '243.066', '0', '', '10715994', '1', null, '7ff950ab83ee7e22e1be9c5e74b35cab', '2021-01-29 21:31:22', '1', '2021-01-29 21:33:40', '1', null, '0');
INSERT INTO `edu_video` VALUES ('265', '42', '48', '5-2 水平居中设置-定宽块状元素', '1', '0', '0', '86270b6c5b5b4c9ab4514b2728fb941a', '140.527', '0', '', '5582724', '1', null, 'b46cd36a802263ba26a23548226b84ab', '2021-01-29 21:31:33', '1', '2021-01-29 21:34:22', '1', null, '0');
INSERT INTO `edu_video` VALUES ('266', '42', '48', '5-3 水平居中总结-不定宽块状元素方法（一）', '1', '0', '0', '44f9622c17a04d25bd8eecf4f3a22112', '253.028', '0', '', '12050988', '1', null, '7282ee7330d382f6807ee7585de64036', '2021-01-29 21:31:49', '1', '2021-01-29 21:35:52', '1', null, '0');
INSERT INTO `edu_video` VALUES ('267', '42', '48', '5-4 水平居中总结-不定宽块状元素方法（二）', '1', '0', '0', '762b88f54477405594449c6ed89b504f', '290.528', '0', '', '13537754', '1', null, 'b0968e5f89cf2387d8b13889f7ebf3c5', '2021-01-29 21:31:59', '1', '2021-01-29 21:36:51', '1', null, '0');
INSERT INTO `edu_video` VALUES ('268', '42', '48', '5-5 水平居中总结-不定宽块状元素方法（三）', '1', '0', '0', '8f120c5a154c4291aec4fdf266b11b91', '254.537', '0', '', '12688758', '1', null, '371264d4454803d4e1092a1cffe9b2d8', '2021-01-29 21:32:10', '1', '2021-01-30 08:12:51', '1', null, '0');
INSERT INTO `edu_video` VALUES ('269', '42', '48', '5-6 垂直居中-父元素高度确定的单行文本', '1', '0', '0', '0674deaf85fa4c979ea37f65321737f9', '346.511', '0', '', '16320155', '1', null, '68a8b83f89412b5e6751fab997447bbf', '2021-01-29 21:32:21', '1', '2021-01-30 08:14:15', '1', null, '0');
INSERT INTO `edu_video` VALUES ('270', '42', '48', '5-7 垂直居中-父元素高度确定的多行文本（一）', '1', '0', '0', '4a3a40cc4eff4ccf8c9dc0de0ded8e69', '297.03', '0', '', '13087704', '1', null, 'f4467d003f89139788301ec06220dcff', '2021-01-29 21:32:32', '1', '2021-01-30 08:15:25', '1', null, '0');
INSERT INTO `edu_video` VALUES ('271', '42', '48', '5-8 垂直居中-父元素高度确定的多行文本（二）', '1', '0', '0', '4d64ed19884645a197026acec0508fef', '197.695', '0', '', '9155728', '1', null, '1493a02070abba9239f51df62ff89be5', '2021-01-29 21:32:48', '1', '2021-01-30 08:16:15', '1', null, '0');
INSERT INTO `edu_video` VALUES ('272', '43', '49', '1-1 为什么学习JavaScript', '1', '0', '0', '2338f1ab6d584199bcb8cac9b20933c1', '95.5269', '0', '', '5752027', '1', null, 'ccfa934acfa374402d8b848ec123c9ed', '2021-01-30 08:22:33', '1', '2021-01-30 08:24:26', '1', null, '0');
INSERT INTO `edu_video` VALUES ('273', '43', '49', '1-2 如何引入JS', '1', '0', '0', '734276fed7fa4676bd79650f8ab6ef7f', '189.568', '0', '', '8488249', '1', null, 'df15afb7b692586e939e710eb4bed719', '2021-01-30 08:22:43', '1', '2021-01-30 08:25:54', '1', null, '0');
INSERT INTO `edu_video` VALUES ('274', '43', '49', '1-3 引用JS外部文件', '1', '0', '0', '5dcf7570bcb54e19a61b243c897213f9', '168.53', '0', '', '7609535', '1', null, '57bf2329a230af8f3ca33b67e8017604', '2021-01-30 08:22:52', '1', '2021-01-30 08:26:52', '1', null, '0');
INSERT INTO `edu_video` VALUES ('275', '43', '49', '1-4 JS在页面中的位置', '1', '0', '0', '546c4805ad3f40d4a66b971c1ceb34cc', '88.5609', '0', '', '6142649', '1', null, 'b148d96155a0a092edac7f785d0c482b', '2021-01-30 08:23:01', '1', '2021-01-30 08:27:54', '1', null, '0');
INSERT INTO `edu_video` VALUES ('276', '43', '49', '1-5 认识语句和符号', '1', '0', '0', 'fd90cdfd24394525b1a21965114c4dca', '192.563', '0', '', '7475963', '1', null, '9d10beebedf254c36a726bd789788047', '2021-01-30 08:23:11', '1', '2021-01-30 08:29:24', '1', null, '0');
INSERT INTO `edu_video` VALUES ('277', '43', '49', '1-6 JavaScript中的注释', '1', '0', '0', '206d07718ef046e09b5da172ade3f0aa', '124.064', '0', '', '5105494', '1', null, '0e29846a9df323d919a992cba7a0fb68', '2021-01-30 08:23:21', '1', '2021-01-30 08:30:00', '1', null, '0');
INSERT INTO `edu_video` VALUES ('278', '43', '49', '1-7 什么是变量', '1', '0', '0', '21ef7e64a07d49f295ec3dac9335acc2', '221.565', '0', '', '9791044', '1', null, '4f4e436406bcc758c58ff48c6b3d4334', '2021-01-30 08:23:32', '1', '2021-01-30 08:31:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('279', '43', '49', '1-8 判断语句（if...else）', '1', '0', '0', '1c16ef9acfa2418891e2f76020e5bb72', '178.004', '0', '', '6740453', '1', null, '3076eb559ef821c891b68d8352583772', '2021-01-30 08:23:41', '1', '2021-01-30 08:32:44', '1', null, '0');
INSERT INTO `edu_video` VALUES ('280', '43', '49', '1-9 什么是函数', '1', '0', '0', 'da14e414f2e94d1fb187e41549f1921e', '203.477', '0', '', '9148227', '1', null, '9c8b981ed32682776e79a2644c147a45', '2021-01-30 08:23:50', '1', '2021-01-30 08:34:17', '1', null, '0');
INSERT INTO `edu_video` VALUES ('281', '43', '50', '2-1 输出内容（document.write）', '1', '0', '0', 'cbefcd5eb3cb452a8ce4e2da748cbb5f', '299.027', '0', '', '12935768', '1', null, '441b6af893c889b60fbc979a1a901dd8', '2021-01-30 08:34:42', '1', '2021-01-30 08:36:26', '1', null, '0');
INSERT INTO `edu_video` VALUES ('282', '43', '50', '2-2 alert 消息对话框', '1', '0', '0', 'a671c32ed2034813a8ba33f8acd7cd76', '98.5687', '0', '', '4545753', '1', null, '1a897da4358aacc9576ca9c1b2c50c68', '2021-01-30 08:34:51', '1', '2021-01-30 08:37:01', '1', null, '0');
INSERT INTO `edu_video` VALUES ('283', '43', '50', '2-3 确认（confirm 消息对话框）', '1', '0', '0', 'fd5a2bda9d0e45b3aa1cd8efcb158e53', '230.505', '0', '', '9788244', '1', null, '95b9d90e0352d17a6919547c5ab7ff2c', '2021-01-30 08:35:00', '1', '2021-01-30 08:37:52', '1', null, '0');
INSERT INTO `edu_video` VALUES ('284', '43', '50', '2-4 提问（prompt 消息对话框）', '1', '0', '0', 'c695e704e8bd4b5cb2a88614dbcdeb0f', '211.069', '0', '', '8744817', '1', null, 'b74dbba88f8c5ce8ffa2d3991b64e12f', '2021-01-30 08:35:08', '1', '2021-01-30 08:44:46', '1', null, '0');
INSERT INTO `edu_video` VALUES ('285', '43', '50', '2-5 打开新窗口（window.open）', '1', '0', '0', '923c12ff07ac4e7080926ba7b381f02b', '368.524', '0', '', '18534422', '1', null, 'd41c9760b9e6332606f02134e1e0f1df', '2021-01-30 08:35:20', '1', '2021-01-30 08:46:31', '1', null, '0');
INSERT INTO `edu_video` VALUES ('286', '43', '51', '3-1 认识DOM', '1', '0', '0', '638d92eab935410d85356c15b7170c2f', '145.566', '0', '', '6636387', '1', null, '41696c6a444fcec9cdbfcf092fb624b4', '2021-01-30 08:46:57', '1', '2021-01-30 08:48:08', '1', null, '0');
INSERT INTO `edu_video` VALUES ('287', '43', '51', '3-2 通过ID获取元素', '1', '0', '0', '1a0162a9977a4e1f912ff8a3f1cec30c', '229.46', '0', '', '9048098', '1', null, 'bfefbd61fdabc308749738328ebb728b', '2021-01-30 08:47:06', '1', '2021-01-30 08:49:24', '1', null, '0');
INSERT INTO `edu_video` VALUES ('288', '43', '51', '3-3 innerHTML 属性', '1', '0', '0', '13e544214c8c43f4a4ca9676b2b5e83d', '144.057', '0', '', '6081152', '1', null, '353185e4b36e47e7d496225b8e332e90', '2021-01-30 08:47:16', '1', '2021-01-30 08:50:11', '1', null, '0');
INSERT INTO `edu_video` VALUES ('289', '43', '51', '3-4 改变 HTML 样式', '1', '0', '0', '25c9064dffee4ea2b86dfbd05b3408d4', '222.029', '0', '', '9528420', '1', null, '5aa4b6ae0579ac0166f7962b1cf30c92', '2021-01-30 08:47:25', '1', '2021-01-30 08:51:22', '1', null, '0');
INSERT INTO `edu_video` VALUES ('290', '43', '51', '3-5 显示和隐藏（display属性）', '1', '0', '0', '216d8a717af74bd8b131aedb877bea99', '341.031', '0', '', '15912071', '1', null, '0db61ba42cf3df491531f50a13f03811', '2021-01-30 08:47:33', '1', '2021-01-30 08:52:45', '1', null, '0');
INSERT INTO `edu_video` VALUES ('291', '44', '52', '1-1 jQuery简介', '1', '0', '0', '962c926b7e5b4159b20edff5c7f9adcb', '76.533', '0', '', '3421314', '1', null, '03eb45eb60bcca13f8e88663ccefcd8a', '2021-01-30 08:58:05', '1', '2021-01-30 08:59:20', '1', null, '0');
INSERT INTO `edu_video` VALUES ('292', '44', '52', '1-2 jQuery安装', '1', '0', '0', '21f6b906bba94ad7b09dcaec46685127', '180.024', '0', '', '7152372', '1', null, '8f9a8852a3a1bd58a898519bd9533299', '2021-01-30 08:58:17', '1', '2021-01-30 09:00:05', '1', null, '0');
INSERT INTO `edu_video` VALUES ('293', '44', '52', '1-3 jQuery HelloWorld体验', '1', '0', '0', 'a4d081345f3f4c0187438be2c9835848', '286', '0', '', '12485365', '1', null, 'cd0821570edb561a2cf506678dfa4aa2', '2021-01-30 08:58:27', '1', '2021-01-30 10:13:27', '1', null, '0');
INSERT INTO `edu_video` VALUES ('294', '44', '52', '1-4 jQuery对象与DOM对象', '1', '0', '0', 'ce15480b358f4fb1afea43e379c39e6e', '572.558', '0', '', '29350857', '1', null, 'a163166e1b96d26d6660be299e14a676', '2021-01-30 08:58:37', '1', '2021-01-30 10:18:31', '1', null, '0');
INSERT INTO `edu_video` VALUES ('295', '44', '52', '1-5 jQuery对象转化成DOM对象', '1', '0', '0', '230a486bc92e4173b1656b99389b2100', '338.524', '0', '', '16024962', '1', null, '4be58fb3d8127091eca7420ed90c3f89', '2021-01-30 08:58:47', '1', '2021-01-30 10:19:44', '1', null, '0');
INSERT INTO `edu_video` VALUES ('296', '44', '52', '1-6 DOM对象转化成jQuery对象', '1', '0', '0', '4e4aeb1ad436444cb4a4a3f3844f3a59', '284.56', '0', '', '14657918', '1', null, '257d41820f124dfe45699f27dec18f96', '2021-01-30 08:58:56', '1', '2021-01-30 10:28:12', '1', null, '0');
INSERT INTO `edu_video` VALUES ('297', '44', '53', '2-1 jQuery选择器之id选择器', '1', '0', '1', 'afd24b867e0548dbaefe183ace4e8256', '432.24', '0', '', '27696301', '1', null, '08d59f0c710a57f1eaff8630b15c3a45', '2021-02-04 17:04:04', '1', '2021-02-04 17:07:12', '1', null, '0');
INSERT INTO `edu_video` VALUES ('298', '44', '53', '2-2 jQuery选择器之类选择器', '1', '0', '1', 'ec286f670eea472298dda28cbe174c3c', '100.032', '0', '', '3913956', '1', null, '7f668025742c3bfadd8edf505335ef5e', '2021-02-04 17:04:23', '1', '2021-02-04 17:07:54', '1', null, '0');
INSERT INTO `edu_video` VALUES ('299', '44', '53', '2-3 jQuery选择器之元素选择器', '1', '0', '1', '9be9400cd269427ab2a7dbf69bd09a67', '111.061', '0', '', '4979460', '1', null, '63166c83020156cba0f52621fcbad198', '2021-02-04 17:04:33', '1', '2021-02-04 17:08:30', '1', null, '0');
INSERT INTO `edu_video` VALUES ('300', '44', '53', '2-4 jQuery选择器之全选择器.', '1', '0', '1', '3a1e698e10d948ac8298884ced7c280c', '86.564', '0', '', '3708359', '1', null, '9ab15693436df334fbbe505abb9eb8e4', '2021-02-04 17:04:41', '1', '2021-02-04 17:09:09', '1', null, '0');
INSERT INTO `edu_video` VALUES ('301', '44', '53', '2-5 jQuery选择器之子选择器和后代选择器', '1', '0', '1', '37ce722c8886419cb1537678831606c5', '561.528', '0', '', '26021729', '1', null, '49168f0473b9ef478285f2aceb4f86be', '2021-02-04 17:04:51', '1', '2021-02-04 17:11:04', '1', null, '0');
INSERT INTO `edu_video` VALUES ('302', '44', '53', '2-6 jQuery选择器之相邻兄弟选择器和一般兄弟选择器', '1', '0', '1', 'd48805c805d444f3b8444214d0e428e0', '299.003', '0', '', '14300693', '1', null, 'ea233cebaad13a09fc2650251f96a3bb', '2021-02-04 17:05:02', '1', '2021-02-04 17:12:09', '1', null, '0');
INSERT INTO `edu_video` VALUES ('303', '44', '53', '2-7 jQuery选择器之基本筛选选择器', '1', '0', '1', 'a2d894920dbd42d0bff4a3e3c3192dc7', '431.566', '0', '', '21273367', '1', null, '350114b28bd2e43f8ecf96a5c7777f4d', '2021-02-04 17:05:12', '1', '2021-02-04 17:14:10', '1', null, '0');
INSERT INTO `edu_video` VALUES ('304', '44', '53', '2-8 jQuery选择器之内容筛选选择器', '1', '0', '1', 'acce65421a9e44b0884e4a9988bc4ce6', '344.027', '0', '', '17429510', '1', null, '54167e9e2287aa4d47e7aef01dd67049', '2021-02-04 17:14:48', '1', '2021-02-04 17:16:21', '1', null, '0');
INSERT INTO `edu_video` VALUES ('305', '44', '53', '2-9 jQuery选择器之可见性筛选选择器', '1', '0', '1', 'dca7471b3bc14473bce7b650db6a8d61', '319.53', '0', '', '18073205', '1', null, '4c4fba8d259e692e4127634712b3bfe1', '2021-02-04 17:14:56', '1', '2021-02-04 17:17:43', '1', null, '0');
INSERT INTO `edu_video` VALUES ('306', '44', '53', '2-10 jQuery选择器之属性筛选选择器', '1', '0', '1', '2ddc223761a54cc681f5d1a5f062ebdd', '530.994', '0', '', '29219863', '1', null, '23cccbce4eb037490abfe10f08e13e9e', '2021-02-04 17:15:04', '1', '2021-02-04 17:20:39', '1', null, '0');
INSERT INTO `edu_video` VALUES ('307', '44', '53', '2-11 jQuery选择器之子元素筛选选择器', '1', '0', '1', '3efdc0f263034c8b985ab5a6a6b32b3a', '452.51', '0', '', '22200158', '1', null, 'c4395f03d38beab26b6dc3ebbaa810cc', '2021-02-04 17:22:22', '1', '2021-02-04 17:24:24', '1', null, '0');
INSERT INTO `edu_video` VALUES ('308', '44', '53', '2-12 jQuery选择器之表单元素选择器', '1', '0', '1', 'e1586c494bf649dc88aa803d67c7240b', '297.564', '0', '', '16541431', '1', null, 'a43c4dc174471c7b3aa20a9eb0cab931', '2021-02-04 17:22:31', '1', '2021-02-04 17:25:50', '1', null, '0');
INSERT INTO `edu_video` VALUES ('309', '44', '53', '2-13 jQuery选择器之表单对象属性筛选选择器', '1', '0', '1', '10e0fb1bcbea41dab410b5dce821272c', '252.563', '0', '', '14131723', '1', null, 'ea4026e9c175115ce5d8eb34e738bf36', '2021-02-04 17:22:38', '1', '2021-02-04 17:27:04', '1', null, '0');
INSERT INTO `edu_video` VALUES ('310', '44', '54', '3-1 jQuery的属性与样式之.attr()与.removeAttr()', '1', '0', '1', '1bb0db2681844d5086011b41058dd99a', '542.023', '0', '', '31804241', '1', null, '8691cddf169aec5c01bce93f77bd424e', '2021-02-04 17:28:29', '1', '2021-02-04 17:32:01', '1', null, '0');
INSERT INTO `edu_video` VALUES ('311', '44', '54', '3-2 jQuery的属性与样式之html()及.text()', '1', '0', '1', 'e688714b2bcd41f1af3789a17c76ab21', '482.069', '0', '', '25913054', '1', null, 'd3f94e20a997ee3251c26ebc137ab02f', '2021-02-04 17:28:39', '1', '2021-02-04 17:34:02', '1', null, '0');
INSERT INTO `edu_video` VALUES ('312', '44', '54', '3-3 jQuery的属性与样式之.val()', '1', '0', '1', '1cd1648ec5b84faa82423e845eb9bf87', '389.027', '0', '', '20650475', '1', null, 'c23916b5f04b96955a399289bee3a343', '2021-02-04 17:28:48', '1', '2021-02-04 17:35:36', '1', null, '0');
INSERT INTO `edu_video` VALUES ('313', '44', '54', '3-4 jQuery的属性与样式之增加样式.addClass()', '1', '0', '1', '5bce05887a6a416aafe3c42af25459b7', '386.032', '0', '', '23780922', '1', null, '99fafdb6c153ae673187659ef56df31e', '2021-02-04 17:28:59', '1', '2021-02-04 17:45:34', '1', null, '0');
INSERT INTO `edu_video` VALUES ('314', '44', '54', '3-5 jQuery的属性与样式之删除样式.removeClass()', '1', '0', '1', 'e9f0708b59ad4c6bb7814f0be8f4236c', '170.063', '0', '', '9484639', '1', null, '15587717de8d9c831bb34c3f9545edd6', '2021-02-04 17:29:08', '1', '2021-02-04 17:51:50', '1', null, '0');
INSERT INTO `edu_video` VALUES ('315', '44', '54', '3-6 jQuery的属性与样式之切换样式.toggleClass()', '1', '0', '1', '5f666dc05c1c4450955b07cc5774bea3', '501.528', '0', '', '29792979', '1', null, 'c52da926977b218d5c3f4e2dee3cb7a6', '2021-02-04 17:29:19', '1', '2021-02-04 17:54:11', '1', null, '0');
INSERT INTO `edu_video` VALUES ('316', '44', '54', '3-7 jQuery的属性与样式之样式操作.css()', '1', '0', '1', 'dff87286c69e4db38a4360adabeb5a3f', '596.567', '0', '', '31388667', '1', null, '8b1adf7700a09736bfe1905c4115f467', '2021-02-04 17:29:30', '1', '2021-02-04 17:56:27', '1', null, '0');
INSERT INTO `edu_video` VALUES ('317', '45', '55', '1-1 layui简介', '1', '0', '0', '052dd72f71a448f08ffa4bd1032ea778', '309.568', '0', '', '20274720', '1', null, 'fd86227aedd678b1d82cdf13310f8b1e', '2021-02-04 17:57:20', '1', '2021-02-04 17:59:45', '1', null, '0');
INSERT INTO `edu_video` VALUES ('318', '45', '55', '1-2 从hello world开始快速上手', '1', '0', '0', 'd562744446d24d1eb22611ecc0e58081', '358.957', '0', '', '14327472', '1', null, '16ba896fa2c3b554bae5e87bfc1398d4', '2021-02-04 17:57:28', '1', '2021-02-04 18:02:00', '1', null, '0');
INSERT INTO `edu_video` VALUES ('319', '45', '55', '1-3 模块化的用法与非模块化用法', '1', '0', '0', '4eeef309e2d64322bdb28a21c8612cc6', '331.093', '0', '', '14373325', '1', null, '568bd8ac9703bb3814c8b065eebe252d', '2021-02-04 17:57:40', '1', '2021-02-04 18:32:18', '1', null, '0');
INSERT INTO `edu_video` VALUES ('320', '45', '55', '1-4 全局配置layui.config(options)', '1', '0', '0', '40abc30940e04585a06105e24dd511d9', '121.998', '0', '', '6767095', '1', null, '6f809106eafa32f060743250dda158a5', '2021-02-04 17:57:49', '1', '2021-02-04 18:49:57', '1', null, '0');
INSERT INTO `edu_video` VALUES ('321', '45', '55', '1-5 定义模块layui.define([mods], callback)', '1', '0', '0', '088d987a38c2492ab0b7b1d125799d65', '107.532', '0', '', '5001481', '1', null, '771b1682d7d944fb79b739d9631e0bb4', '2021-02-04 17:57:59', '1', '2021-02-04 18:50:34', '1', null, '0');
INSERT INTO `edu_video` VALUES ('322', '45', '55', '1-6 页面元素规范与说明', '1', '0', '0', '98132bf94bad415996abcdfcb514c7bb', '309.568', '0', '', '14970389', '1', null, '67bcbcffd83208d4620dba8502b69469', '2021-02-04 17:58:11', '1', '2021-02-04 18:52:13', '1', null, '0');
INSERT INTO `edu_video` VALUES ('323', '45', '56', '2-1 栅格系统', '1', '0', '1', '63f5e7024b8e4714a31c0bf1116d4f47', '722.535', '0', '', '35348279', '1', null, '37d25ebe8871e993df343272aa694d15', '2021-02-04 18:53:47', '1', '2021-02-04 18:57:50', '1', null, '0');
INSERT INTO `edu_video` VALUES ('324', '45', '56', '2-2 layui颜色设计感', '1', '0', '1', '3d5e204ffbbf45939bb8051ede9170ea', '209.56', '0', '', '9869691', '1', null, '2ce922d77f87fd7ef8138c1d7d384eab', '2021-02-04 18:53:56', '1', '2021-02-04 19:03:20', '1', null, '0');
INSERT INTO `edu_video` VALUES ('325', '45', '56', '2-3 字体图标', '1', '0', '1', '41a5add5496445608b5d57be556045b6', '205.566', '0', '', '10714110', '1', null, '492a09d73ee166388ac8103a15795ce1', '2021-02-04 18:54:04', '1', '2021-02-04 19:05:20', '1', null, '0');
INSERT INTO `edu_video` VALUES ('326', '45', '56', '2-4 CSS3动画类', '1', '0', '1', '55649b1d0dd74f3eb457c9783d283929', '284.026', '0', '', '12267269', '1', null, 'd98a83cecccad4afa36b52dd5d03526f', '2021-02-04 18:54:12', '1', '2021-02-04 19:07:44', '1', null, '0');
INSERT INTO `edu_video` VALUES ('327', '45', '56', '2-5 layui中的按钮', '1', '0', '1', '61207a30a4a54d16abb9eecbf9796f58', '450.026', '0', '', '22067139', '1', null, 'cefdabdea4996b66ddb0d3587b0fd664', '2021-02-04 18:54:21', '1', '2021-02-04 19:09:25', '1', null, '0');
INSERT INTO `edu_video` VALUES ('328', '45', '56', '2-6 layui中的表单', '1', '0', '1', 'f44d05225bba4a94b4d596cfd8e6173f', '829.068', '0', '', '41803281', '1', null, 'ae45668473897aa79b1f32c98d5d7480', '2021-02-04 18:54:30', '1', '2021-02-04 19:12:52', '1', null, '0');
INSERT INTO `edu_video` VALUES ('329', '45', '56', '2-7 layui中的导航', '1', '0', '1', '9482dec096cb41fda7251cd1047d5a1a', '556.559', '0', '', '27172736', '1', null, '62e011154ab818e59686465f55323237', '2021-02-04 18:54:38', '1', '2021-02-04 19:15:06', '1', null, '0');
INSERT INTO `edu_video` VALUES ('330', '45', '56', '2-8 Tab选项卡', '1', '0', '1', '4291decaa5ba4791a9b03a3919777643', '296.031', '0', '', '14207029', '1', null, '4b3f7a8ed86e048faf7575484000b9a0', '2021-02-04 18:54:46', '1', '2021-02-04 19:16:39', '1', null, '0');
INSERT INTO `edu_video` VALUES ('331', '45', '56', '2-9 进度条', '1', '0', '1', '115b33c625f248cbabe27c560fad2d7e', '345.559', '0', '', '13181154', '1', null, '40d75735d08c8ff915c801a575d16e70', '2021-02-04 18:54:54', '1', '2021-02-04 19:22:21', '1', null, '0');
INSERT INTO `edu_video` VALUES ('332', '45', '56', '2-10 layui中的面板', '1', '0', '1', 'ffbd02c808c64e3f8b016bcacd8f8d33', '315.443', '0', '', '14339174', '1', null, '6a4ef3e5f1478ed560cdf9dda0f562bf', '2021-02-04 18:55:03', '1', '2021-02-04 19:24:48', '1', null, '0');
INSERT INTO `edu_video` VALUES ('333', '45', '56', '2-11 基 础 表格', '1', '0', '1', '71c2a91834734acaa620d2903454418b', '311.031', '0', '', '14026817', '1', null, '1448d6faa548713a175efba19efd19e3', '2021-02-04 18:55:11', '1', '2021-02-04 19:25:57', '1', null, '0');
INSERT INTO `edu_video` VALUES ('334', '45', '57', '3-1 layer弹出层组件之基础参数（一）', '1', '0', '1', 'fba233c788a5404c92e7853101e1b539', '475.057', '0', '', '24182826', '1', null, '6f267d948a32fb66af1b7418aa54c30f', '2021-02-04 19:27:46', '1', '2021-02-04 19:30:06', '1', null, '0');
INSERT INTO `edu_video` VALUES ('335', '45', '57', '3-2 layer弹出层组件之基础参数（二）', '1', '0', '1', '2ff3300958b1464e9b374d25c4120a14', '319.53', '0', '', '16892663', '1', null, '3aaae2d45e39676a017f24ad9c635817', '2021-02-04 19:27:55', '1', '2021-02-04 19:31:44', '1', null, '0');
INSERT INTO `edu_video` VALUES ('336', '45', '57', '3-3 layer弹出层组件之基础参数（三）', '1', '0', '1', '78c5562d07154ed4be8fe2d98941fc9a', '572.465', '0', '', '26350212', '1', null, '22559e89a175602eaaaa75816ac720a7', '2021-02-04 19:28:04', '1', '2021-02-04 19:34:01', '1', null, '0');
INSERT INTO `edu_video` VALUES ('337', '45', '57', '3-4 layer弹出层组件之基础参数（四）', '1', '0', '1', 'ec128db953ff4ab5bbfe110d86493bff', '534.059', '0', '', '25662057', '1', null, '13b9feefb5d46c27ee439f8937a8cdcd', '2021-02-04 19:28:13', '1', '2021-02-04 19:39:12', '1', null, '0');
INSERT INTO `edu_video` VALUES ('338', '45', '57', '3-5 layer弹出层组件之基础参数（五）', '1', '0', '1', '763d03d816e6453ca24c1ec898bc3f23', '724.997', '0', '', '53540714', '1', null, '7d7d9fa8fec3cb1e2d04e92f5b691923', '2021-02-04 19:28:22', '1', '2021-02-04 19:43:03', '1', null, '0');
INSERT INTO `edu_video` VALUES ('339', '45', '57', '3-6 layer弹出层组件之基础参数（六）', '1', '0', '1', '717bdaee9dc749c4b0ae80bf4ca735d0', '317.069', '0', '', '13750484', '1', null, '1f31a6125d0bfb8b24110d65ddbc3226', '2021-02-04 19:43:23', '1', '2021-02-04 19:45:25', '1', null, '0');
INSERT INTO `edu_video` VALUES ('340', '45', '57', '3-7 layer弹出层组件之基础参数（七）', '1', '0', '1', '14bc230b8b7e426fb802719807c476cd', '314.538', '0', '', '20483088', '1', null, '218e7ca3eb26e52a3ee7dae5bb1defe9', '2021-02-04 19:43:31', '1', '2021-02-04 19:47:07', '1', null, '0');
INSERT INTO `edu_video` VALUES ('341', '45', '57', '3-8 layer弹出层组件之内置方法（一）', '1', '0', '1', 'b3b37d370703461bbd870f36c893cc43', '189.057', '0', '', '11954162', '1', null, '59b947ef2c466e551958f3e4e8a9c786', '2021-02-04 19:43:40', '1', '2021-02-04 19:48:21', '1', null, '0');
INSERT INTO `edu_video` VALUES ('342', '45', '57', '3-9 layer弹出层组件之内置方法（二）', '1', '0', '1', '37d5261f3def4f28868e4628abff583d', '238.91', '0', '', '12534351', '1', null, '569db5546995eec45313496d487d6c55', '2021-02-04 19:43:49', '1', '2021-02-04 19:49:32', '1', null, '0');
INSERT INTO `edu_video` VALUES ('343', '45', '57', '3-10 日期和时间组件之快速使用（一）', '1', '0', '1', '37b1d2f38fd34183b8c28f1c3ffff99f', '230.063', '0', '', '9488407', '1', null, 'c03eea38c34a97fd12b217a43b3098be', '2021-02-04 19:43:58', '1', '2021-02-04 19:50:53', '1', null, '0');
INSERT INTO `edu_video` VALUES ('344', '45', '57', '3-11 日期和时间组件之基础参数（二）', '1', '0', '1', 'bc21dcc1b843484180046ff6deb367d4', '354.569', '0', '', '15507704', '1', null, '8e8f97364a230ffab9ec8783a075befb', '2021-02-04 19:51:12', '1', '2021-02-04 19:53:06', '1', null, '0');
INSERT INTO `edu_video` VALUES ('345', '45', '57', '3-12 日期和时间组件之基础参数（三）', '1', '0', '1', '335f08d6218e4dd9ae987bab3e68aabb', '498.532', '0', '', '21200698', '1', null, '4e0fac50183700130aecbdbfdbc49c5a', '2021-02-04 19:51:20', '1', '2021-02-04 19:54:58', '1', null, '0');
INSERT INTO `edu_video` VALUES ('346', '45', '57', '3-13 分页模块laypage', '1', '0', '1', 'c91a8a0c9c904f0f96ef7454a458c7ce', '506.938', '0', '', '23683034', '1', null, '0698892669837643233dae85d42b9ac6', '2021-02-04 19:51:28', '1', '2021-02-04 19:57:03', '1', null, '0');
INSERT INTO `edu_video` VALUES ('347', '45', '57', '3-14 模板引擎laytpl', '1', '0', '1', 'ce5d416ed9e74c33b8603a2b8ece2f07', '384.058', '0', '', '17578449', '1', null, '3967edc559d29487773a99998c47108c', '2021-02-04 19:51:43', '1', '2021-02-04 19:59:40', '1', null, '0');
INSERT INTO `edu_video` VALUES ('348', '45', '57', '3-15 table 数据表格（一）', '1', '0', '1', 'a87622fd2aaf4a8bb1958337bb11bc37', '309.476', '0', '', '18066808', '1', null, '10d468e9d97bbe80e0dfc7cdc762c389', '2021-02-04 19:51:52', '1', '2021-02-04 20:01:30', '1', null, '0');
INSERT INTO `edu_video` VALUES ('349', '45', '57', '3-16 table 数据表格（二）', '1', '0', '1', 'ddb84fb8250e402abd0e27edceb6090f', '168.53', '0', '', '8646665', '1', null, 'e43353177e0068db96083fe15df81b4d', '2021-02-04 20:02:31', '1', '2021-02-04 20:04:03', '1', null, '0');
INSERT INTO `edu_video` VALUES ('350', '45', '57', '3-17 table 数据表格（三）', '1', '0', '1', 'c8b6266f25bb4c449b738fcab076347e', '399.058', '0', '', '18862016', '1', null, '4438c4565bcd5716d3088a1fe1d6c0e7', '2021-02-04 20:02:39', '1', '2021-02-04 20:11:32', '1', null, '0');
INSERT INTO `edu_video` VALUES ('351', '45', '57', '3-18 table 数据表格（四）', '1', '0', '1', 'c9383832740947c59db60a7227a385ce', '443.524', '0', '', '21782270', '1', null, 'fa56d1f3e09d3787cddd93bb96237b45', '2021-02-04 20:02:47', '1', '2021-02-04 20:13:40', '1', null, '0');
INSERT INTO `edu_video` VALUES ('352', '45', '57', '3-19 templet - 自定义列模板', '1', '0', '1', '068cb960e1304f489cdaa393c5a0e02f', '372.564', '0', '', '20205229', '1', null, '480479df8dfba675cc6d99e0f8507599', '2021-02-04 20:02:57', '1', '2021-02-04 20:15:07', '1', null, '0');
INSERT INTO `edu_video` VALUES ('353', '45', '57', '3-20 toolbar绑定工具条模板', '1', '0', '1', '847259f36bba47888f44182d19305b7c', '126.061', '0', '', '6562126', '1', null, '65ef4e911bae1fcfbe20363c5a552ab0', '2021-02-04 20:03:06', '1', '2021-02-04 20:17:11', '1', null, '0');
INSERT INTO `edu_video` VALUES ('354', '46', '58', '1-1 jsp简介', '1', '0', '0', 'b2a6ba3731a945e9bc5e4857428050df', '369.058', '0', '', '21825590', '1', null, 'ee3bd3ddbfdfcff02016782a445ab555', '2021-02-04 20:18:08', '1', '2021-02-04 20:21:57', '1', null, '0');
INSERT INTO `edu_video` VALUES ('355', '46', '58', '1-2 常见动态网站开发技术对比', '1', '0', '0', '2878f782b763484a9a6ca75936b86f50', '105.024', '0', '', '4139371', '1', null, 'd65e7202fa39c3860a977edc91b7a976', '2021-02-04 20:19:25', '1', '2021-02-04 20:23:02', '1', null, '0');
INSERT INTO `edu_video` VALUES ('356', '46', '58', '1-3 JSP页面元素简介及page指令', '1', '0', '0', '603c1adbad8a419b9d5a7f85ad40902b', '192.563', '0', '', '7756329', '1', null, '7f5655cd5ecd89b5272ae51ca1120613', '2021-02-04 20:19:34', '1', '2021-02-04 20:25:15', '1', null, '0');
INSERT INTO `edu_video` VALUES ('357', '46', '58', '1-4 jsp注释', '1', '0', '0', '8f35a2147b4a4b94809f59aa55844824', '332.533', '0', '', '17166028', '1', null, 'b678a27c148c825ecfcdde688fdd91e4', '2021-02-04 20:19:42', '1', '2021-02-04 20:28:48', '1', null, '0');
INSERT INTO `edu_video` VALUES ('358', '46', '58', '1-5 jsp脚本', '1', '0', '0', 'b3bbb8a101df406f9697f7690ce6d18c', '74.0252', '0', '', '3756874', '1', null, 'e4d25ebdc4ac15628cb607bf832b0a93', '2021-02-04 20:19:50', '1', '2021-02-04 20:29:20', '1', null, '0');
INSERT INTO `edu_video` VALUES ('359', '46', '58', '1-6 JSP声明', '1', '0', '0', '5747a7f8e76b4569a5431d9f7527d85c', '168.461', '0', '', '8660205', '1', null, 'ae4c49495ecabe00226b909e6fe95411', '2021-02-04 20:20:00', '1', '2021-02-04 20:30:44', '1', null, '0');
INSERT INTO `edu_video` VALUES ('360', '46', '58', '1-7 JSP表达式', '1', '0', '0', '53f7592d301446498959ee3a38fb47cb', '168.507', '0', '', '9427492', '1', null, 'cad2621fec337718e2fc6f196a79fad0', '2021-02-04 20:20:19', '1', '2021-02-04 20:31:39', '1', null, '0');
INSERT INTO `edu_video` VALUES ('361', '46', '58', '1-8 JSP页面生命周期', '1', '0', '0', 'cbf01facfa64403f9c46f93ffb7f6c99', '441.527', '0', '', '29794277', '1', null, '7776856e8dabcd31ac38886d13f0b6ef', '2021-02-04 20:20:27', '1', '2021-02-04 20:39:18', '1', null, '0');
INSERT INTO `edu_video` VALUES ('362', '46', '59', '2-1 内置对象简介', '1', '0', '0', '5e2d5a9c54e542378814aa0121d2abce', '119.025', '0', '', '5347455', '1', null, 'a32cf3977be19e6ecaf6d22398b207c4', '2021-02-04 20:40:23', '1', '2021-02-04 20:42:30', '1', null, '0');
INSERT INTO `edu_video` VALUES ('363', '46', '59', '2-2 web程序的请求与响应', '1', '0', '0', 'ce7686a8879b45f8b08f725395b83cf3', '100.264', '0', '', '5493578', '1', null, 'c4ff7dddc7f62a1f9fc49a2c9519e15f', '2021-02-04 20:40:34', '1', '2021-02-04 20:43:17', '1', null, '0');
INSERT INTO `edu_video` VALUES ('364', '46', '59', '2-3 out对象', '1', '0', '0', '3400aa8a0657450f84d7c2191daa459f', '696.343', '0', '', '43351424', '1', null, '253d0d1c30161fe00d1d6084341ed138', '2021-02-04 20:40:49', '1', '2021-02-04 20:46:38', '1', null, '0');
INSERT INTO `edu_video` VALUES ('365', '46', '59', '2-4 get与post提交方式的区别', '1', '0', '0', '1daaf57e099c4eb6b5cb270f9cdcd5d3', '543.068', '0', '', '30746808', '1', null, 'fc83b840a813600a154a7eb53e400043', '2021-02-04 20:40:58', '1', '2021-02-04 20:48:55', '1', null, '0');
INSERT INTO `edu_video` VALUES ('366', '46', '59', '2-5 request对象（一）', '1', '0', '0', 'aa9695fb4c0244db922658555c64837d', '359.561', '0', '', '20505150', '1', null, '673797ecfb2f816d0fcea9f61ad36978', '2021-02-04 20:41:07', '1', '2021-02-04 20:50:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('367', '46', '59', '2-6 request对象（二）', '1', '0', '0', '1181e37fbc66472a8a6c0f6b41e9932c', '415.568', '0', '', '26176763', '1', null, '5ecdf9648dcf8b225d6344d0de5e5733', '2021-02-04 20:41:20', '1', '2021-02-04 20:52:34', '1', null, '0');
INSERT INTO `edu_video` VALUES ('368', '46', '59', '2-7 response对象', '1', '0', '0', 'f6f4a8572fb04cebbb4bcba466084852', '436.024', '0', '', '27629064', '1', null, '45149963ad845bd42dc19eb6256c6235', '2021-02-04 20:41:42', '1', '2021-02-04 20:54:52', '1', null, '0');
INSERT INTO `edu_video` VALUES ('369', '46', '59', '2-8 请求重定向与请求转发的区别', '1', '0', '0', 'eb694432e98b4c3aae09b39f1c38c275', '429.267', '0', '', '24444449', '1', null, 'a0fcae95d5f37210984e5f4155b1edcd', '2021-02-04 20:41:51', '1', '2021-02-04 20:56:41', '1', null, '0');
INSERT INTO `edu_video` VALUES ('370', '46', '60', '3-1 什么是session', '1', '0', '0', '83ff6b6ec0334fcabb73d7f0f96a997c', '141.433', '0', '', '5706110', '1', null, '91ffe2abcff5b9719c7d2ad1ffcbfdbf', '2021-02-04 20:57:02', '1', '2021-02-04 20:58:30', '1', null, '0');
INSERT INTO `edu_video` VALUES ('371', '46', '60', '3-2 session对象', '1', '0', '0', '4815bf05d6854690b02e9726f51bfd2e', '755.531', '0', '', '44616495', '1', null, 'a5e7a3149b25f2079d4b6cf8efd5e564', '2021-02-04 20:57:12', '1', '2021-02-04 21:01:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('372', '46', '60', '3-3 session的生命周期', '1', '0', '0', '8baf81d085ef415bb3ce3abefabe9130', '101.564', '0', '', '4122111', '1', null, '68bac97b56557f934bc0ee90988c5272', '2021-02-04 20:57:21', '1', '2021-02-04 21:02:07', '1', null, '0');
INSERT INTO `edu_video` VALUES ('373', '46', '60', '3-4 application对象', '1', '0', '0', '73e15f7a5f9d4e7bb5ef35a479d5cbd7', '544.903', '0', '', '29407667', '1', null, '3fbed9b661286c6540928420858dc35f', '2021-02-04 20:57:30', '1', '2021-02-04 21:18:08', '1', null, '0');
INSERT INTO `edu_video` VALUES ('374', '46', '60', '3-5 page对象', '1', '0', '0', '214360364a224d7798b007ccfee89bae', '104.467', '0', '', '6197309', '1', null, 'f01dbae0270e99f41dbd4c0b3059fd7d', '2021-02-04 20:57:40', '1', '2021-02-04 21:18:53', '1', null, '0');
INSERT INTO `edu_video` VALUES ('375', '46', '60', '3-6 pageContext对象和config对象', '1', '0', '0', 'b1443f2444e149cfb571b00ba3d71dcd', '133.399', '0', '', '6315076', '1', null, 'fe5cb0565acd923f0ba89768eef49dad', '2021-02-04 20:57:48', '1', '2021-02-04 21:19:38', '1', null, '0');
INSERT INTO `edu_video` VALUES ('376', '46', '60', '3-7 exception对象', '1', '0', '0', '65c6df4699534b8196c04919a351aad7', '303.531', '0', '', '18948815', '1', null, 'bb32cb611972c82d46c58e3228d51f26', '2021-02-04 20:57:57', '1', '2021-02-04 21:21:14', '1', null, '0');
INSERT INTO `edu_video` VALUES ('377', '46', '61', '4-1 JavaBean简介及设计原则', '1', '0', '0', 'd47ddb5c38644b18b7180f36e60e85ec', '152.532', '0', '', '6180858', '1', null, '39f58dafb439d184df72a45dda655777', '2021-02-04 21:21:37', '1', '2021-02-04 21:23:40', '1', null, '0');
INSERT INTO `edu_video` VALUES ('378', '46', '61', '4-2 什么是JSP动作元素', '1', '0', '0', '6a17a15837cc44a5927eb11d2402cd1e', '134.931', '0', '', '5366954', '1', null, '338d10f664a7b5978b58b2bd0f280b35', '2021-02-04 21:22:02', '1', '2021-02-04 21:24:20', '1', null, '0');
INSERT INTO `edu_video` VALUES ('379', '46', '61', '4-3 使用普通方式创建JavaBean', '1', '0', '0', '0cb58c524c244f4e92175eb467267c37', '381.527', '0', '', '21277263', '1', null, 'a1a7a727f6438200d51cdc0aa4f3b74e', '2021-02-04 21:22:11', '1', '2021-02-04 21:26:02', '1', null, '0');
INSERT INTO `edu_video` VALUES ('380', '46', '61', '4-4 useBean动作元素', '1', '0', '0', '249c69bcf8654a96a10e3cca4a6a23ca', '249.498', '0', '', '14450277', '1', null, '633dc1d99c1faa26abf45d548e43b671', '2021-02-04 21:22:23', '1', '2021-02-04 21:27:13', '1', null, '0');
INSERT INTO `edu_video` VALUES ('381', '46', '61', '4-5 setProperty', '1', '0', '0', '40dc12b45bdf46e994ffd528ddca0ee0', '424.53', '0', '', '27667893', '1', null, '0d529de1fb1219f74ece8405a3a4b17e', '2021-02-04 21:22:32', '1', '2021-02-04 21:29:30', '1', null, '0');
INSERT INTO `edu_video` VALUES ('382', '46', '61', '4-6 getProperty', '1', '0', '0', '7ef5acdb3e7841768b65c11a1523f4f4', '169.064', '0', '', '11401045', '1', null, '3b8badba29f15a0c1af885df915eae06', '2021-02-04 21:22:42', '1', '2021-02-04 21:30:35', '1', null, '0');
INSERT INTO `edu_video` VALUES ('383', '46', '61', '4-7 JavaBean四个作用域范围', '1', '0', '0', '8ce168188171426b9c8cc71848e1de27', '71.9354', '0', '', '3530971', '1', null, '1e8e8e996e5f401363f9dd5a4f66fe28', '2021-02-04 21:22:53', '1', '2021-02-04 21:31:07', '1', null, '0');
INSERT INTO `edu_video` VALUES ('384', '46', '61', '4-8 model1简介', '1', '0', '0', '19bc12232da84dceb7668ff1b0645d8d', '94.064', '0', '', '3703526', '1', null, 'bacaaa023fff7621ff8d3ad09f7d98c6', '2021-02-04 21:23:01', '1', '2021-02-04 21:31:40', '1', null, '0');
INSERT INTO `edu_video` VALUES ('385', '46', '62', '5-1 http协议的无状态性', '1', '0', '0', '615ea92555ab48a3b1c10affc9ddfaae', '78.437', '0', '', '3175567', '1', null, '123ad5e123e6a53c34f73b0e1c33372c', '2021-02-04 21:31:59', '1', '2021-02-04 21:33:04', '1', null, '0');
INSERT INTO `edu_video` VALUES ('386', '46', '62', '5-2 Cookie概述', '1', '0', '0', 'c321bcb3adf64c3f924be0b246fb93f7', '75.5113', '0', '', '2601913', '1', null, 'dd0d0f99221c3ccefb8684608994e1eb', '2021-02-04 21:32:10', '1', '2021-02-04 21:33:32', '1', null, '0');
INSERT INTO `edu_video` VALUES ('387', '46', '62', '5-3 JSP页面中创建与使用Cookie', '1', '0', '0', '05894ec9684c471fbf4063c49eb0b6e2', '99.0331', '0', '', '3562434', '1', null, '0e6d4aa4be131629fe3ead8ead10d6b4', '2021-02-04 21:32:19', '1', '2021-02-04 21:34:04', '1', null, '0');
INSERT INTO `edu_video` VALUES ('388', '46', '62', '5-4 案例：Cookie在登录中的应用', '1', '0', '0', '3d83d29c3d06438586ea7157f3b31628', '739.068', '0', '', '41578482', '1', null, '78facdc8aeb535b829d6a0ca72c9bb02', '2021-02-04 21:32:29', '1', '2021-02-04 21:37:08', '1', null, '0');
INSERT INTO `edu_video` VALUES ('389', '46', '62', '5-5 Session与Cookie的对比', '1', '0', '0', 'e07e0277f0d24dfdbfca411d074710e6', '79.5283', '0', '', '2873849', '1', null, 'ea6ae19fad9d007d82b7b26da69d0046', '2021-02-04 21:32:39', '1', '2021-02-04 21:37:39', '1', null, '0');
INSERT INTO `edu_video` VALUES ('390', '46', '63', '6-1 include指令', '1', '0', '0', '3df9425e28ea423ab9d52b61f3623b04', '330.559', '0', '', '18881273', '1', null, '067cec391c6f8c928101dc66571ffcbb', '2021-02-04 21:37:52', '1', '2021-02-04 21:39:53', '1', null, '0');
INSERT INTO `edu_video` VALUES ('391', '46', '63', '6-2 include动作', '1', '0', '0', 'a0396625ce43415cbb8ab01a3fe63ee7', '130.566', '0', '', '6737769', '1', null, 'e2e142445969f36f5bf23d8a484300da', '2021-02-04 21:38:01', '1', '2021-02-04 21:40:38', '1', null, '0');
INSERT INTO `edu_video` VALUES ('392', '46', '63', '6-3 include指令与include动作的区别', '1', '0', '0', '1002020f229d40e89bef0e0b846b93bf', '127.524', '0', '', '5551254', '1', null, 'f584202c25ccca1577ca6e194f643bec', '2021-02-04 21:38:11', '1', '2021-02-04 21:41:15', '1', null, '0');
INSERT INTO `edu_video` VALUES ('393', '46', '63', '6-4 forward动作', '1', '0', '0', '925c4a213b4842fca9d72b0690d1cce7', '264.057', '0', '', '16249776', '1', null, 'cefaf8ef51908274cdbb64dbeab37561', '2021-02-04 21:38:18', '1', '2021-02-04 21:42:34', '1', null, '0');
INSERT INTO `edu_video` VALUES ('394', '46', '63', '6-5 param动作', '1', '0', '0', '8d06a928afbc4ff7af9744986aedb492', '159.428', '0', '', '8611409', '1', null, '0f07b052e33e8e8243813120e6b61efc', '2021-02-04 21:38:25', '1', '2021-02-04 21:43:24', '1', null, '0');
INSERT INTO `edu_video` VALUES ('395', '51', '113', '1-1 为什么使用JSTL', '1', '0', '0', '0b7eedb3759e48029094275725ce3963', '124.064', '0', '', '5407342', '1', null, '10c4c338d584425db42eef09b7583667', '2021-02-04 21:44:30', '1', '2021-02-04 21:45:12', '1', null, '0');
INSERT INTO `edu_video` VALUES ('396', '51', '113', '1-2 JSTL环境搭建', '1', '0', '0', '192226b705e74f3da2aa4dc204e5c8c1', '219.057', '0', '', '17243994', '1', null, '6c9ef929901fa12666107207dcad3f3a', '2021-02-04 21:44:38', '1', '2021-02-04 21:46:43', '1', null, '0');
INSERT INTO `edu_video` VALUES ('397', '51', '114', '2-1 第一个JSTL小程序', '1', '0', '1', '03ead9daa29749778cb7868ab3fbbc27', '122.067', '0', '', '6930838', '1', null, '7d83722e9c03c448e5e586d9ecdc7592', '2021-02-04 21:47:02', '1', '2021-02-04 21:48:16', '1', null, '0');
INSERT INTO `edu_video` VALUES ('398', '51', '114', '2-2 JSTL的好帮手-EL表达式', '1', '0', '1', '89af238e01a84d34826f3a2a4bd9b1df', '248.036', '0', '', '9319262', '1', null, '78629e96f9b6671b3a2b11efed40f7df', '2021-02-04 21:47:11', '1', '2021-02-04 21:49:11', '1', null, '0');
INSERT INTO `edu_video` VALUES ('399', '51', '114', '2-3 EL变量', '1', '0', '1', '341742360a0240a990ad24bcd15cd618', '159.498', '0', '', '8271728', '1', null, 'bf863faf61e7393717bf9f12b44747b8', '2021-02-04 21:47:20', '1', '2021-02-04 21:50:01', '1', null, '0');
INSERT INTO `edu_video` VALUES ('400', '51', '114', '2-4 EL自动类型转换', '1', '0', '1', 'c0a91fac9e0b40f1ae7a815ba37635f7', '117.029', '0', '', '4796150', '1', null, '6a2d78b216ef1aeedc74e8ddf35011e9', '2021-02-04 21:47:28', '1', '2021-02-04 21:50:35', '1', null, '0');
INSERT INTO `edu_video` VALUES ('401', '51', '114', '2-5 EL运算符', '1', '0', '1', '62ad06bcc0c147ebbfe5727f1d45624b', '268.562', '0', '', '15361638', '1', null, '20095739ffc7724422ff07201fb29336', '2021-02-04 21:47:36', '1', '2021-02-04 21:52:07', '1', null, '0');
INSERT INTO `edu_video` VALUES ('402', '51', '115', '3-1 JSTL标签之out标签', '1', '0', '1', '76b49464e07b4aaab73267b996cbc004', '285.025', '0', '', '17150534', '1', null, '19dca0ad7f704489a4e8fdf198217296', '2021-02-04 21:52:24', '1', '2021-02-04 21:54:28', '1', null, '0');
INSERT INTO `edu_video` VALUES ('403', '51', '115', '3-2 JSTL标签之set标签', '1', '0', '1', '5303b2e429a54ae2a4a7342bd74c4264', '829.231', '0', '', '63445968', '1', null, '142d3b0c5a2d14e77014d7b7ce5a9a2e', '2021-02-04 21:52:33', '1', '2021-02-04 21:59:11', '1', null, '0');
INSERT INTO `edu_video` VALUES ('404', '51', '115', '3-3 JSTL标签之remove标签', '1', '0', '1', '66e47b763a2d42bea72a84c264f9ae52', '160.032', '0', '', '9435222', '1', null, '89a495c2dfbfaa87603cda519462a379', '2021-02-04 21:52:44', '1', '2021-02-04 22:00:05', '1', null, '0');
INSERT INTO `edu_video` VALUES ('405', '51', '115', '3-4 JSTL标签之catch标签', '1', '0', '1', 'a9835815e91d48ac9168b3548bc4206e', '130.403', '0', '', '8279575', '1', null, 'ed14e49d4902b2155acc01b0cb25449a', '2021-02-04 21:52:56', '1', '2021-02-04 22:00:50', '1', null, '0');
INSERT INTO `edu_video` VALUES ('406', '51', '115', '3-5 JSTL标签之if标签', '1', '0', '1', 'afd1a45899264f1bafc2b85ea7d35bfa', '403.029', '0', '', '21661385', '1', null, '1fd888b8bfa87fd30a51a10bb6f125e1', '2021-02-04 21:53:05', '1', '2021-02-04 22:02:26', '1', null, '0');
INSERT INTO `edu_video` VALUES ('407', '51', '115', '3-6 JSTL标签之choose-when-otherwise标签', '1', '0', '1', 'c40c3289fc164c55a571f443bae1e324', '512.441', '0', '', '27523641', '1', null, 'f01b89f1d65de65a40739e5892432934', '2021-02-05 12:18:35', '1', '2021-02-05 12:21:14', '1', null, '0');
INSERT INTO `edu_video` VALUES ('408', '51', '115', '3-7 JSTL标签之forEach标签（上）', '1', '0', '1', '061e82fb74a748db98eeab6bae296707', '598.564', '0', '', '34227176', '1', null, '994be2da9efe56138b8404700c880e92', '2021-02-05 12:18:43', '1', '2021-02-05 12:23:44', '1', null, '0');
INSERT INTO `edu_video` VALUES ('409', '51', '115', '3-8 JSTL标签之forEach标签（下）', '1', '0', '1', '05a6775e855c49a29c38489c04b672ec', '459.569', '0', '', '27368197', '1', null, 'cd1bcc0f21a10db436bc2bc7df0a7206', '2021-02-05 12:18:50', '1', '2021-02-05 12:25:54', '1', null, '0');
INSERT INTO `edu_video` VALUES ('410', '51', '115', '3-9 JSTL标签之forTocken标签', '1', '0', '1', '4870e7ef37bf40e48674d5a831c3480e', '167.532', '0', '', '9847775', '1', null, '3d9ce2b30b5af2c51f3ca1c00f036660', '2021-02-05 12:18:57', '1', '2021-02-05 12:26:54', '1', null, '0');
INSERT INTO `edu_video` VALUES ('411', '51', '115', '3-10 JSTL标签之import标签', '1', '0', '1', 'ba88c2720aad40fcb2e39051d36e22d7', '352.038', '0', '', '27496463', '1', null, 'bf6607ad4c8088479766938e293def91', '2021-02-05 12:19:05', '1', '2021-02-05 12:28:42', '1', null, '0');
INSERT INTO `edu_video` VALUES ('412', '51', '115', '3-11 JSTL标签之redirect标签', '1', '0', '1', 'ef00ee742bd04b319aa066dff274a708', '350.528', '0', '', '25542456', '1', null, 'd6bc0147848f2c2c5035e96c8feed312', '2021-02-05 12:19:12', '1', '2021-02-05 12:30:38', '1', null, '0');
INSERT INTO `edu_video` VALUES ('413', '51', '115', '3-12 JSTL标签之url标签', '1', '0', '1', '2fce3ac8022c4207981415c17597b91d', '52.9647', '0', '', '1967084', '1', null, '3918593b12224decc0641425d08aeddb', '2021-02-05 12:19:19', '1', '2021-02-05 12:31:02', '1', null, '0');
INSERT INTO `edu_video` VALUES ('414', '51', '116', '4-1 JSTL函数之常用函数（上）', '1', '0', '1', '7b511015421f43bcb304d1e961f96350', '293.523', '0', '', '22510428', '1', null, 'bb33d9e24428629705a7c546f9184835', '2021-02-05 12:31:39', '1', '2021-02-05 12:33:12', '1', null, '0');
INSERT INTO `edu_video` VALUES ('415', '51', '116', '4-2 JSTL函数之常用函数（下）', '1', '0', '1', '20f0ed81cb584f9181682725f598e55f', '131.03', '0', '', '7369536', '1', null, 'eb6883339485f8ec608cd0825526baf7', '2021-02-05 12:31:47', '1', '2021-02-05 12:34:00', '1', null, '0');
INSERT INTO `edu_video` VALUES ('416', '52', '117', '1-1 Servlet概述', '1', '0', '0', '0ff827fd26494bee9c4bcd5fa03fd737', '95.5269', '0', '', '3877328', '1', null, 'd6656b932a58ba8cdc95c5703cfb007b', '2021-02-05 12:35:53', '1', '2021-02-05 12:37:47', '1', null, '0');
INSERT INTO `edu_video` VALUES ('417', '52', '117', '1-2 Tomcat容器等级', '1', '0', '0', 'ffcbcd06c7aa4b0abb1ff8b76a714b56', '75.5577', '0', '', '2535252', '1', null, 'ca6f2821adab2419dfcf5f04b7999360', '2021-02-05 12:36:10', '1', '2021-02-05 12:38:13', '1', null, '0');
INSERT INTO `edu_video` VALUES ('418', '52', '117', '1-3 手工编写第一个Servlet', '1', '0', '0', '5ff3686139324300a76895a0478fa73e', '981.136', '0', '', '61195511', '1', null, 'cffcc701831029ae23120165ab97c761', '2021-02-05 12:36:21', '1', '2021-02-05 12:42:38', '1', null, '0');
INSERT INTO `edu_video` VALUES ('419', '52', '117', '1-4 Servlet执行流程和生命周期（上）', '1', '0', '0', 'b56f1f2e03f848cb98bb72d5a15d0d5f', '158.569', '0', '', '6232977', '1', null, 'a1da4cd5a1f5525f9b53de08e63556c6', '2021-02-05 12:36:29', '1', '2021-02-05 12:43:33', '1', null, '0');
INSERT INTO `edu_video` VALUES ('420', '52', '117', '1-5 Servlet执行流程和生命周期（下）', '1', '0', '0', '4dc2bb92f3c2491289ecfbfef06cab9d', '370.01', '0', '', '28167251', '1', null, 'c2dfe0ed06e0e2c2efa6c14095d4d4ab', '2021-02-05 12:36:40', '1', '2021-02-05 12:45:41', '1', null, '0');
INSERT INTO `edu_video` VALUES ('421', '52', '117', '1-6 Tomcat装载Servlet的三种情况', '1', '0', '0', 'e134073c80e34b5b8fc5df2077fe6c2a', '393.532', '0', '', '31202996', '1', null, '0a8a9a52b95ae6a19c82bf5dbeee4816', '2021-02-05 12:36:48', '1', '2021-02-05 12:48:05', '1', null, '0');
INSERT INTO `edu_video` VALUES ('422', '52', '117', '1-7 Servlet与JSP内置对象的对应关系', '1', '0', '0', '38f0c2153730471d9f60445b53e078a3', '99.5672', '0', '', '3505964', '1', null, '3be07b8fd1062c5d5f125d006a89430d', '2021-02-05 12:36:59', '1', '2021-02-05 12:49:25', '1', null, '0');
INSERT INTO `edu_video` VALUES ('423', '52', '117', '1-8 Servlet获取表单数据', '1', '0', '0', 'dfab2c8190b045158c38b40fe678b195', '1123.31', '0', '', '82303310', '1', null, 'a6406e7d18b02a9c8c725b56bae4992f', '2021-02-05 12:37:11', '1', '2021-02-05 12:54:50', '1', null, '0');
INSERT INTO `edu_video` VALUES ('424', '52', '117', '1-9 Servlet路径跳转', '1', '0', '0', 'bbf74e43c64441afbf0a2f66d1c425f3', '463.563', '0', '', '30571143', '1', null, '36d68ee314b2d2da8c42bca023c94473', '2021-02-05 12:37:19', '1', '2021-02-05 13:43:29', '1', null, '0');
INSERT INTO `edu_video` VALUES ('425', '52', '118', '2-1 获取初始化参数（上）', '1', '0', '1', '59a7f0aa17724b4cb5322b3855b534f8', '554.028', '0', '', '38575457', '1', null, 'a8903d497a69901d03312785a9d209dd', '2021-02-05 13:43:49', '1', '2021-02-05 13:47:56', '1', null, '0');
INSERT INTO `edu_video` VALUES ('426', '52', '118', '2-2 获取初始化参数（下）', '1', '0', '1', 'b69f8ce3f5094fffae7ded4aec7f42f0', '407.069', '0', '', '31079654', '1', null, 'f1fd6b580c83bce86e2deb64aa01ffc2', '2021-02-05 13:44:30', '1', '2021-02-05 13:50:54', '1', null, '0');
INSERT INTO `edu_video` VALUES ('427', '52', '118', '2-3 MVC模型介绍', '1', '0', '1', '93e2cc04ffc045eaaa63a11c6996a9a5', '91.0687', '0', '', '3153378', '1', null, '2f81fbddb73a5cc35a101c6a98352743', '2021-02-05 13:44:49', '1', '2021-02-05 13:51:41', '1', null, '0');
INSERT INTO `edu_video` VALUES ('428', '52', '118', '2-4 Model2模型介绍', '1', '0', '1', '53f98b2c48c94fad9633e4cda83d6873', '144.057', '0', '', '4549001', '1', null, 'b12b87b4cf6609bafde2a63c7b809ee0', '2021-02-05 13:45:06', '1', '2021-02-05 13:52:13', '1', null, '0');
INSERT INTO `edu_video` VALUES ('429', '52', '118', '2-5 项目概述', '1', '0', '1', '31d75e7dc0ce490abf34fdabb995f01d', '79.5283', '0', '', '2325017', '1', null, 'f47718dfd41c08f77f1b46ca81d3eb3d', '2021-02-05 13:45:19', '1', '2021-02-05 13:52:54', '1', null, '0');
INSERT INTO `edu_video` VALUES ('430', '52', '118', '2-6 界面原型效果及界面开发步骤', '1', '0', '1', '1d0102c857ab47babdefcef5a6d82a10', '131.564', '0', '', '4609828', '1', null, 'b248875e3765086eeb40f35521bac015', '2021-02-05 13:53:09', '1', '2021-02-05 13:54:10', '1', null, '0');
INSERT INTO `edu_video` VALUES ('431', '52', '118', '2-7 创建项目以及商品实体类', '1', '0', '1', '338bae1200e34bdcbb4dfa9e9cef43b8', '251.565', '0', '', '17645054', '1', null, '00d00f36162d6f82b2033e652c227161', '2021-02-05 13:53:17', '1', '2021-02-05 13:55:30', '1', null, '0');
INSERT INTO `edu_video` VALUES ('432', '52', '118', '2-8 购物车类的设计', '1', '0', '1', '7775d6a8fff743fc9f2cb9b6eb9aef9c', '760.57', '0', '', '39900426', '1', null, '53a33d9099ee922c3070053d35343bac', '2021-02-05 13:53:25', '1', '2021-02-05 13:58:13', '1', null, '0');
INSERT INTO `edu_video` VALUES ('433', '52', '118', '2-9 测试购物车类', '1', '0', '1', 'b48bcfabcf6d4134a4a1d184a0090ce3', '663.557', '0', '', '38862868', '1', null, '22c66cf9de9326dcb7c9c3a3d95c7126', '2021-02-05 13:53:32', '1', '2021-02-05 14:01:02', '1', null, '0');
INSERT INTO `edu_video` VALUES ('434', '52', '118', '2-10 如何保证不添加重复商品进购物车', '1', '0', '1', 'f0c18bbec29e4311bb278daf2590b515', '271.023', '0', '', '15368425', '1', null, '4f61e77f7e221b838c42bd40fd436150', '2021-02-05 13:53:39', '1', '2021-02-05 14:02:26', '1', null, '0');
INSERT INTO `edu_video` VALUES ('435', '52', '118', '2-11 数据库的创建和链接', '1', '0', '1', 'afdb447eff62426b9b9c6dddd2bec39a', '595.035', '0', '', '35620051', '1', null, '7525bfc4bb1a684f1ea2ed64da999c60', '2021-02-05 14:02:46', '1', '2021-02-05 14:06:22', '1', null, '0');
INSERT INTO `edu_video` VALUES ('436', '52', '118', '2-12 商品展示', '1', '0', '1', '0fb204035e9f4ed0bbb79e02dd4f4808', '536.567', '0', '', '35219342', '1', null, 'd932139a14325a6c29bb6989e4a0ef69', '2021-02-05 14:02:55', '1', '2021-02-05 14:09:00', '1', null, '0');
INSERT INTO `edu_video` VALUES ('437', '52', '118', '2-13 查看商品详情', '1', '0', '1', 'a2e42e9eab93403985faa3f100f87ce2', '470.042', '0', '', '34644092', '1', null, '895bd2dea01818b67b3d013418433d3b', '2021-02-05 14:03:04', '1', '2021-02-05 14:11:27', '1', null, '0');
INSERT INTO `edu_video` VALUES ('438', '52', '118', '2-14 添加商品到购物车', '1', '0', '1', '3462ed4e51024a5d925abaa68fbbe4aa', '1417.39', '0', '', '103599020', '1', null, '60ff09def3c495dc8d5bb5e182f964c3', '2021-02-05 14:03:17', '1', '2021-02-05 14:18:25', '1', null, '0');
INSERT INTO `edu_video` VALUES ('439', '52', '118', '2-15 显示购物车', '1', '0', '1', '2804ff145b314c6fa5cf93ddd51e120f', '616.536', '0', '', '37397580', '1', null, '7bd9fe3eae5446778a42278586b7026a', '2021-02-05 14:03:27', '1', '2021-02-05 14:21:10', '1', null, '0');
INSERT INTO `edu_video` VALUES ('440', '52', '118', '2-16 更改购买数量', '1', '0', '1', '339e166623cd4f9cb55d5e871d26aa58', '245.528', '0', '', '14362307', '1', null, '8f9de26932bba2494caf486df1d16ba0', '2021-02-05 14:03:38', '1', '2021-02-05 14:22:21', '1', null, '0');
INSERT INTO `edu_video` VALUES ('441', '52', '118', '2-17 商品删除', '1', '0', '1', '31a908fe01194cf9880977041492d11e', '538.471', '0', '', '33163930', '1', null, '03d3e0a22a2b20233934b6ef51f84448', '2021-02-05 14:03:53', '1', '2021-02-05 14:24:53', '1', null, '0');
INSERT INTO `edu_video` VALUES ('442', '53', '119', '1-1 Spring入门课程简介', '1', '0', '0', 'e586d5fd272a46a2b773ffe523bc6bf5', '213.972', '0', '', '14085178', '1', null, '82464fdb62b6a1ecb54afdcc65ffffc4', '2021-02-05 14:26:47', '1', '2021-02-05 14:28:25', '1', null, '0');
INSERT INTO `edu_video` VALUES ('443', '53', '119', '1-2 spring概述', '1', '0', '0', '35e1e8fd9841457c8eb7ad9f0b0d011a', '176.031', '0', '', '7732626', '1', null, '1192b834cab4da0678b7dce35ca44797', '2021-02-05 14:26:57', '1', '2021-02-05 14:29:17', '1', null, '0');
INSERT INTO `edu_video` VALUES ('444', '53', '119', '1-3 Spring框架', '1', '0', '0', '410c9ed89813427da136fe77dd1385a3', '94.5284', '0', '', '3806761', '1', null, '8e5aecd0b9c847e419461eb2aabf4f46', '2021-02-05 14:27:07', '1', '2021-02-05 14:29:56', '1', null, '0');
INSERT INTO `edu_video` VALUES ('445', '53', '119', '1-4 Spring搭建helloworld', '1', '0', '0', '1a7a9a7250b74e88b70ed26e6fad7293', '688.913', '0', '', '40235178', '1', null, '1b3a6154e870a583348c9e2aed7f14ae', '2021-02-05 14:27:16', '1', '2021-02-05 14:32:45', '1', null, '0');
INSERT INTO `edu_video` VALUES ('446', '53', '120', '2-1 接口和面向接口编程', '1', '0', '1', 'baeb814cc7714b99a446d6acc0927087', '316.558', '0', '', '17491278', '1', null, '7b22c546ca019313cc9c5c37d8de181c', '2021-02-05 14:33:35', '1', '2021-02-05 14:35:23', '1', null, '0');
INSERT INTO `edu_video` VALUES ('447', '53', '120', '2-2 什么是IOC', '1', '0', '1', '63ef27d75e4547aa94bfb03a14679393', '122.903', '0', '', '6015241', '1', null, 'f3859cb1ffcd90a098fe04743cd8c8bc', '2021-02-05 14:33:44', '1', '2021-02-05 14:36:11', '1', null, '0');
INSERT INTO `edu_video` VALUES ('448', '53', '120', '2-3 什么是Bean', '1', '0', '1', 'dff45e27f444410ca312a34b0bb43588', '151.441', '0', '', '6333684', '1', null, 'fc6b202e819d6681e96f418be323c16b', '2021-02-05 14:33:51', '1', '2021-02-05 14:37:13', '1', null, '0');
INSERT INTO `edu_video` VALUES ('449', '53', '120', '2-4 Spring注入方式（上）', '1', '0', '1', '0436debe1b82421084f6639d35e01c38', '878.063', '0', '', '56048524', '1', null, '15307299541dd5b2e503dff2efd42e16', '2021-02-05 14:33:59', '1', '2021-02-05 14:41:03', '1', null, '0');
INSERT INTO `edu_video` VALUES ('450', '53', '120', '2-5 Spring注入方式（下）', '1', '0', '1', '5717b31b747044efbc259a55dba91be9', '226.07', '0', '', '17929131', '1', null, '23e78ab489781e2adeb630baaa2fc5c2', '2021-02-05 14:34:07', '1', '2021-02-05 14:42:33', '1', null, '0');
INSERT INTO `edu_video` VALUES ('451', '53', '121', '3-1 Spring Bean装配之Bean的配置项及作用域', '1', '0', '1', '00b20b42cb6f4cc0af8a97ab22dd6bf6', '460.568', '0', '', '29432141', '1', null, 'de3212878d05bc80e16154195ade4dbd', '2021-02-05 17:15:04', '1', '2021-02-05 17:17:49', '1', null, '0');
INSERT INTO `edu_video` VALUES ('452', '53', '121', '3-2 Spring Bean装配之Bean的生命周期', '1', '0', '1', 'c4d847a5c1ad47ddafa65ebdc8397c41', '976.028', '0', '', '68534720', '1', null, '2c6fa2c8cd0d3dbbf9d58c1902a286a5', '2021-02-05 17:15:15', '1', '2021-02-05 17:33:57', '1', null, '0');
INSERT INTO `edu_video` VALUES ('453', '53', '121', '3-3 Spring Bean装配之自动装配', '1', '0', '1', 'd88ea6e28f4046cbb21ca25472f8886d', '1096.56', '0', '', '78888117', '1', null, '8ceb81beba75cca653c6a16ee7853c24', '2021-02-05 17:15:29', '1', '2021-02-05 17:39:43', '1', null, '0');
INSERT INTO `edu_video` VALUES ('454', '53', '121', '3-4 Spring Bean装配之Resource', '1', '0', '1', '695cd44da94b4e938917a63e3e5f37c1', '611.033', '0', '', '44656229', '1', null, '9b0b1f65e55be0cb75e05a900325b20b', '2021-02-05 17:15:39', '1', '2021-02-05 17:43:07', '1', null, '0');
INSERT INTO `edu_video` VALUES ('455', '53', '122', '4-1 Spring Bean装配之Bean的定义及作用域的注解实现', '1', '0', '1', '743734d4cc21452d8f73ac6e65c14cfa', '1220.91', '0', '', '82737506', '1', null, '8257b96f84169153486ffcc54c1e1ca6', '2021-02-05 17:43:54', '1', '2021-02-05 17:49:54', '1', null, '0');
INSERT INTO `edu_video` VALUES ('456', '53', '122', '4-2 Spring Bean装配之Autowired注解说明', '1', '0', '1', '81f96011c0d946f18db76c31a5ca1b00', '857.025', '0', '', '63796868', '1', null, '5439086e71ec0ef49056a59828dc398e', '2021-02-05 17:44:07', '1', '2021-02-05 17:54:20', '1', null, '0');
INSERT INTO `edu_video` VALUES ('457', '53', '122', '4-3 SpringBean装配之Qualifier注解说明', '1', '0', '1', 'b880d1de807e44e08a969cce21dcbabd', '308.013', '0', '', '23440614', '1', null, '546625d98ecdcaa169f6b15331a45c40', '2021-02-05 17:44:16', '1', '2021-02-05 17:56:15', '1', null, '0');
INSERT INTO `edu_video` VALUES ('458', '53', '122', '4-4 @Autowired和@Resource两个注解的区别', '1', '0', '1', '1c1d1c9a85f34ea4bb25c6ca0225b43f', '187.524', '0', '', '13781097', '1', null, '7acd48ae404b1de96013174168984820', '2021-02-05 17:44:25', '1', '2021-02-05 17:57:26', '1', null, '0');
INSERT INTO `edu_video` VALUES ('459', '53', '122', '4-5 SpringBean装配之Service注解说明', '1', '0', '1', '25d0251839b74d809bea6366a3a7d2ad', '90.5578', '0', '', '5537585', '1', null, '9c295b7a3692f7deb034b8eb47884805', '2021-02-05 17:44:34', '1', '2021-02-05 17:58:16', '1', null, '0');
INSERT INTO `edu_video` VALUES ('460', '53', '122', '4-6 SpringBean装配之Repository注解说明', '1', '0', '1', '5489a6542a1a44c9b2767b9c9e8e0cb2', '129.962', '0', '', '9450587', '1', null, 'fcc9dfd99db442581a5d60a42e576a71', '2021-02-05 17:58:46', '1', '2021-02-05 18:00:54', '1', null, '0');
INSERT INTO `edu_video` VALUES ('461', '53', '122', '4-7 Spring Bean装配之基于Java的容器注解说明——@Bean', '1', '0', '1', 'cefa9ed5d6db4fcfac67b37bdeaa17cc', '700.43', '0', '', '46271810', '1', null, 'd9e17d3f12d69ae08873942eb16cf2e9', '2021-02-05 17:58:54', '1', '2021-02-05 18:25:08', '1', null, '0');
INSERT INTO `edu_video` VALUES ('462', '53', '122', '4-8 SpringBean装配之基于Java的容器注解说明——@ImportResource和@Value', '1', '0', '1', '5ac699dca1f142a3bcb537d8b77564e0', '675.027', '0', '', '50949897', '1', null, '7e19e01ec425f5ac3879b6b637f26605', '2021-02-05 17:59:51', '1', '2021-02-05 18:28:38', '1', null, '0');
INSERT INTO `edu_video` VALUES ('463', '53', '122', '4-9 Spring Bean装配之基于Java的容器注解说明——@Bean和@Scope', '1', '0', '1', '144316190256491187e2bce9d25ad2b7', '255.559', '0', '', '15641839', '1', null, '94127d1595e39288c19b6cceb7521fb9', '2021-02-05 18:00:04', '1', '2021-02-05 18:29:55', '1', null, '0');
INSERT INTO `edu_video` VALUES ('464', '53', '123', '5-1 AOP基本概念及特点', '1', '0', '1', '0d7765afa808472fb48ed7de142e1110', '290.064', '0', '', '12320045', '1', null, 'e11677bfe0881eb90248249b2abc0f6f', '2021-02-05 18:30:16', '1', '2021-02-05 18:32:26', '1', null, '0');
INSERT INTO `edu_video` VALUES ('465', '53', '123', '5-2 Spring中的AOP', '1', '0', '1', 'c50aa971a0c145a8ac28ff757cc3895b', '121.533', '0', '', '4835127', '1', null, '4ac61ea3ab04c183d92c9cd1b05c02ec', '2021-02-05 18:30:24', '1', '2021-02-05 18:56:13', '1', null, '0');
INSERT INTO `edu_video` VALUES ('466', '53', '123', '5-3 配置切面aspect', '1', '0', '1', 'ca12d6eeefb442379286db51909f77ad', '351.968', '0', '', '21947960', '1', null, 'a0b14ad17eaa46f8b8c8577cd1b5d988', '2021-02-05 18:30:33', '1', '2021-02-05 18:58:00', '1', null, '0');
INSERT INTO `edu_video` VALUES ('467', '53', '123', '5-4 配置切入点Pointcut', '1', '0', '1', 'e832f538f5124854882e7a4bfeab8993', '199.529', '0', '', '11996845', '1', null, '7a8d63872c6dbe8cd4dbc9f487f9cfa5', '2021-02-05 18:30:42', '1', '2021-02-05 18:59:30', '1', null, '0');
INSERT INTO `edu_video` VALUES ('468', '53', '123', '5-5 Advice应用之前置通知（before advice）的用法', '1', '0', '1', '677d0f7100e1441d850ce230487c8687', '490.568', '0', '', '36254455', '1', null, 'a1aa0f0da741449b11b6ca2f871c265c', '2021-02-05 18:30:50', '1', '2021-02-05 19:02:01', '1', null, '0');
INSERT INTO `edu_video` VALUES ('469', '53', '123', '5-6 Advice应用之前置通知（after returning advice）的用法', '1', '0', '1', 'ef01907161194109b0b0179782dfa4fd', '148.492', '0', '', '11880628', '1', null, 'c42ff24fe958e01a901a4c40cbcf4564', '2021-02-05 18:30:59', '1', '2021-02-05 19:03:06', '1', null, '0');
INSERT INTO `edu_video` VALUES ('470', '53', '123', '5-7 Advice应用之抛出异常后通知（after throwing advice）的用法', '1', '0', '1', '07bd2f6800964fe38bb69eec66059cc5', '217.966', '0', '', '14491851', '1', null, 'ff81938e36f9bae67ed9ec687dbcb206', '2021-02-05 18:31:08', '1', '2021-02-05 19:04:14', '1', null, '0');
INSERT INTO `edu_video` VALUES ('471', '53', '123', '5-8 Advice应用之后通知（after  advice）的用法', '1', '0', '1', 'ec43c3015d504428af3164749c3911e7', '154.993', '0', '', '11023444', '1', null, '2e41b56c8571606611bb72a8df479448', '2021-02-05 18:31:17', '1', '2021-02-05 19:05:29', '1', null, '0');
INSERT INTO `edu_video` VALUES ('472', '53', '123', '5-9 Advice应用之环绕通知（around  advice）的用法', '1', '0', '1', 'e6afcd5943af48ca870bba2c254c7339', '260.064', '0', '', '18586389', '1', null, 'b3ea22f4f874c19d4270899479b5e3c0', '2021-02-05 18:31:26', '1', '2021-02-05 19:06:57', '1', null, '0');
INSERT INTO `edu_video` VALUES ('473', '53', '124', '6-1 AspectJ介绍', '1', '0', '1', 'bf79f5350e2d4121a425ee2acadcfe7f', '370.567', '0', '', '23134981', '1', null, 'e3038b70b44ca0c97884e7ff8a3c1df1', '2021-02-05 19:07:20', '1', '2021-02-05 19:09:11', '1', null, '0');
INSERT INTO `edu_video` VALUES ('474', '53', '124', '6-2 point注解应用', '1', '0', '1', '6748096659ce42f58ef16764237dea92', '213.531', '0', '', '9201129', '1', null, '2fe26ff5ce2d569f7eed01914b44d0a0', '2021-02-05 19:07:30', '1', '2021-02-05 19:10:24', '1', null, '0');
INSERT INTO `edu_video` VALUES ('475', '53', '124', '6-3 Advice定义及实例', '1', '0', '1', '71b1baf4e69b4e9596278f8dccdcf366', '633.208', '0', '', '43369308', '1', null, '7593d1e4337e69e90ffd89958ded39e9', '2021-02-05 19:07:38', '1', '2021-02-05 19:13:25', '1', null, '0');
INSERT INTO `edu_video` VALUES ('476', '54', '125', '1-1 SpringMVC概述及开发环境搭建', '0', '0', '0', 'bd7a8d764e4a4d698e33b2145f87adb7', '250.566', '0', '', '16966097', '1', null, '06b294a5e17b2dddfa65a3019f1fe7b0', '2021-02-05 20:25:25', '1', '2021-02-05 20:25:25', '1', null, '0');
INSERT INTO `edu_video` VALUES ('477', '54', '125', '1-2 SpringMVC第一个程序HelloWorld', '0', '0', '0', '94e81dc4548243e2846a8e29dc83b783', '868.032', '0', '', '60368019', '1', null, 'b3ec68547d5f9cf20977565a6366714e', '2021-02-05 20:28:27', '1', '2021-02-05 20:28:27', '1', null, '0');
INSERT INTO `edu_video` VALUES ('478', '54', '125', '1-6 视图解析器', '6', '0', '0', 'c17fdaf684c147ea8833a05fb377b4ae', '107.067', '0', '', '3761243', '1', null, '9bf3a9e4d34611143b5647c15d751109', '2021-02-05 20:32:19', '1', '2021-02-05 20:36:42', '1', null, '0');
INSERT INTO `edu_video` VALUES ('479', '54', '125', '1-3 Spring MVC 执行流程', '0', '0', '0', '16481a702b8f4fb8a9e96dd33cf8930a', '195.559', '0', '', '6541150', '1', null, '5b436c10804eaa3e34dd8c5f135ba879', '2021-02-05 20:32:28', '1', '2021-02-05 20:32:28', '1', null, '0');
INSERT INTO `edu_video` VALUES ('480', '54', '125', '1-5 处理映射器和适配器', '5', '0', '0', 'd9ca0f41d29749379a701de80adefad8', '304.065', '0', '', '15704468', '1', null, '92b39d6592809aae3aa3e182aa180430', '2021-02-05 20:33:01', '1', '2021-02-05 20:44:45', '1', null, '0');
INSERT INTO `edu_video` VALUES ('481', '54', '125', '1-4 前端控制器DispatcherServlet', '0', '0', '0', '46aa5c6e54584258baa99622648c189d', '433.563', '0', '', '28687027', '1', null, 'f078091cb14cd4038ec99f17528e7bc9', '2021-02-05 20:33:51', '1', '2021-02-05 20:33:51', '1', null, '0');
INSERT INTO `edu_video` VALUES ('482', '54', '126', '2-1 @Controller注解', '0', '0', '1', '81d43580f8614c0f8882390b32378c31', '141.897', '0', '', '7492321', '1', null, '54f02579b4e9ff9b86ea4bcbc85ed380', '2021-02-05 20:50:28', '1', '2021-02-05 20:50:28', '1', null, '0');
INSERT INTO `edu_video` VALUES ('483', '54', '126', '2-4 ModelAndView', '4', '0', '1', '3e5e015994ae4db0b2b7b817ed75e874', '297.564', '0', '', '17938099', '1', null, '5e7c11f24e5cfefeb5e316cb7020f3db', '2021-02-05 20:51:06', '1', '2021-02-05 21:07:20', '1', null, '0');
INSERT INTO `edu_video` VALUES ('484', '54', '126', '2-2@RequestMapping注解', '0', '0', '1', 'c04d2dd6aa1d47c4944d1605ddd90ae1', '477.031', '0', '', '25472205', '1', null, 'db2d2e87582d5aef8e61d88debdeca55', '2021-02-05 20:51:30', '1', '2021-02-05 20:51:30', '1', null, '0');
INSERT INTO `edu_video` VALUES ('485', '54', '126', '2-3 Model和ModelMap', '0', '0', '1', 'c8140881cfe247bf8d3f3e857d2f78c8', '427.038', '0', '', '26666735', '1', null, '348e08fe762b7d1b2c4258aaa0ef59c9', '2021-02-05 20:51:40', '1', '2021-02-05 20:51:40', '1', null, '0');
INSERT INTO `edu_video` VALUES ('486', '54', '126', '2-5 @RequstParam注解', '5', '0', '1', 'e0f08e9e645043759be0a1cbb906e236', '477.031', '0', '', '29579627', '1', null, 'b415a97df6eb28df09c6c841d10ffba2', '2021-02-05 20:51:52', '1', '2021-02-05 21:07:27', '1', null, '0');
INSERT INTO `edu_video` VALUES ('487', '54', '126', '2-6 @PathVariable 注解', '6', '0', '1', 'bec51c651f304f759c35475d45ed90a3', '278.523', '0', '', '18578862', '1', null, 'b1b33c34f3a715438cbcd8befe672f42', '2021-02-06 08:49:56', '1', '2021-02-06 08:51:47', '1', null, '0');
INSERT INTO `edu_video` VALUES ('488', '54', '126', '2-7 @RequestHeader', '7', '0', '1', '63f6c4c3684041829a9e00453bdbf31d', '313.028', '0', '', '22210452', '1', null, '980d2602aaee7ae53387a5358fa9299b', '2021-02-06 08:50:07', '1', '2021-02-06 08:51:55', '1', null, '0');
INSERT INTO `edu_video` VALUES ('489', '54', '126', '2-8 @CookieValue注解', '8', '0', '1', '374d2d6eb00a4fec9017624f57a64e96', '194.56', '0', '', '12676885', '1', null, '5357475701598b5144e8598818ec6c76', '2021-02-06 08:53:07', '1', '2021-02-06 08:58:12', '1', null, '0');
INSERT INTO `edu_video` VALUES ('490', '54', '126', '2-13 @ResponseBody和＠RequestBody注解', '13', '0', '1', 'ee6a24b681fb4ba783173c58cac5e1d3', '423.068', '0', '', '28395864', '1', null, '7acfb4a8e32e72f9e95bc864e57afce9', '2021-02-06 08:54:19', '1', '2021-02-06 08:58:25', '1', null, '0');
INSERT INTO `edu_video` VALUES ('491', '54', '126', '2-9 @ModelAttribute注解（上）', '9', '0', '1', '66346f4463384581bb0d3072446c5560', '578.525', '0', '', '39513004', '1', null, '3fcd0fc067765cf22f9b92ce882aee46', '2021-02-06 08:54:41', '1', '2021-02-06 08:58:18', '1', null, '0');
INSERT INTO `edu_video` VALUES ('492', '54', '126', '2-11 @ModelAttribute注解（下）', '11', '0', '1', '4c69a06a857f4ef3949dd97c7ce98f25', '497.557', '0', '', '40300638', '1', null, '92391c70e795e90f2a70853bec0b4238', '2021-02-06 08:54:50', '1', '2021-02-06 08:58:31', '1', null, '0');
INSERT INTO `edu_video` VALUES ('493', '54', '126', '2-10 @ModelAttribute注解（中）', '10', '0', '1', 'dfe09231877a43b882221deb39d8d954', '676.56', '0', '', '45532159', '1', null, 'dd472d86ab366998cc7df21d3b94777a', '2021-02-06 08:55:02', '1', '2021-02-06 08:58:38', '1', null, '0');
INSERT INTO `edu_video` VALUES ('494', '54', '126', '2-12 @SessionAttribute和＠SessionAttributes 注解', '12', '0', '1', '33f8c231f7fa403cb37fc0d466dba180', '700.569', '0', '', '50079847', '1', null, '188ea7cb64de94c4455f65a7c99fc437', '2021-02-06 08:55:27', '1', '2021-02-06 08:58:44', '1', null, '0');
INSERT INTO `edu_video` VALUES ('495', '54', '127', '3-2 RequestMappingHandlerAdapter', '2', '0', '1', '0b886ebb4b754ecf8994d5502b39f4c5', '111.061', '0', '', '5362233', '1', null, '3ed291010c281e657105a1e42fe4e8da', '2021-02-06 08:59:42', '1', '2021-02-06 09:01:00', '1', null, '0');
INSERT INTO `edu_video` VALUES ('496', '54', '127', '3-1 HttpMessageConverter详解', '0', '0', '1', 'ea46b2814acd47a898ce11a24c5a4e8a', '262.525', '0', '', '13491475', '1', null, 'fba03d9ca7479549a69f923a8b8a88db', '2021-02-06 09:00:13', '1', '2021-02-06 09:00:13', '1', null, '0');
INSERT INTO `edu_video` VALUES ('497', '54', '127', '3-3 自定义 HttpMessageConverter', '3', '0', '1', 'ec5567b33ae947059fa39c41db300e86', '278.523', '0', '', '20996107', '1', null, 'ca2d90d17911abd72523792c64b66637', '2021-02-06 09:00:36', '1', '2021-02-06 09:01:04', '1', null, '0');
INSERT INTO `edu_video` VALUES ('498', '55', '128', '1-1 mybatis简介', '1', '0', '0', '4fbadd4785af46fca28361d83e4b5c71', '228.531', '0', '', '10347913', '1', null, 'f5f168fef4cc90cde6687d7df513aaed', '2021-02-06 09:03:21', '1', '2021-02-06 09:04:59', '1', null, '0');
INSERT INTO `edu_video` VALUES ('499', '55', '128', '1-3 配置MyBatis', '3', '0', '0', '3232aa7d220845d89c8171c46752e3b7', '189.568', '0', '', '12513047', '1', null, 'baf4d1f0618a2edbe9d79d3078a7a87c', '2021-02-06 09:03:28', '1', '2021-02-06 09:05:07', '1', null, '0');
INSERT INTO `edu_video` VALUES ('500', '55', '128', '1-2 创建web项目并集成MyBatis', '2', '0', '0', '6bfc3b9c52d343e19620499c754f8059', '306.062', '0', '', '16996444', '1', null, '56bc3472f2493a3d966b9443be8687da', '2021-02-06 09:03:51', '1', '2021-02-06 09:05:12', '1', null, '0');
INSERT INTO `edu_video` VALUES ('501', '55', '128', '1-4 创建实体类和Mapper.xml文件', '4', '0', '0', 'ef391981839b413b9e6c46d758383995', '345.025', '0', '', '25213495', '1', null, '15d53b9718cf7e039af145619adff3de', '2021-02-06 09:04:12', '1', '2021-02-06 09:05:18', '1', null, '0');
INSERT INTO `edu_video` VALUES ('502', '55', '128', '1-5 编写测试代码让Mybatis跑起来', '5', '0', '0', 'a11d8733cd854fb4ad3d6784b888245d', '411.063', '0', '', '28343960', '1', null, '7de6fb7f5d3e65b08bc8a9425a54dbd4', '2021-02-06 09:04:36', '1', '2021-02-06 09:05:24', '1', null, '0');
INSERT INTO `edu_video` VALUES ('503', '55', '129', '2-1 一个简单的权限控制需求', '1', '0', '1', '022559f74bc647cba5076aa9d89df88a', '104.025', '0', '', '5007904', '1', null, '60fb0c78b029a582db9452b95d27e9e9', '2021-02-06 09:06:30', '1', '2021-02-06 09:13:44', '1', null, '0');
INSERT INTO `edu_video` VALUES ('504', '55', '129', '2-2 创建数据库表', '2', '0', '1', 'b1d1eb081b97467385961c32db66221e', '105.558', '0', '', '5592612', '1', null, '7478b753dd5356bf33359fcf69cbbaa5', '2021-02-06 09:06:31', '1', '2021-02-06 09:13:58', '1', null, '0');
INSERT INTO `edu_video` VALUES ('505', '55', '129', '2-6 resultMap标签详解', '6', '0', '1', '6180d6e6fd6c43a9b629deda7607ce66', '270.025', '0', '', '13603947', '1', null, '1aefe481e32cbbb1684aeddf7d1786e8', '2021-02-06 09:07:06', '1', '2021-02-06 09:13:30', '1', null, '0');
INSERT INTO `edu_video` VALUES ('506', '55', '129', '2-4 创建Mapper接口和Mapper.xml文件', '4', '0', '1', '4b78f4d1ccea4fc3b30c09bd70fcb759', '389.468', '0', '', '21577008', '1', null, '4b1f4a3f275168f3da3eb45787245fd1', '2021-02-06 09:07:19', '1', '2021-02-06 09:13:36', '1', null, '0');
INSERT INTO `edu_video` VALUES ('507', '55', '129', '2-3 创建实体类', '3', '0', '1', 'b87b8e3463754619abd4f833ebc709cc', '430.057', '0', '', '27270458', '1', null, '47fdf34e8cbd007a1b895fdf03bfa120', '2021-02-06 09:08:02', '1', '2021-02-06 09:13:50', '1', null, '0');
INSERT INTO `edu_video` VALUES ('508', '55', '129', '2-5 select标签单表用法', '5', '0', '1', '5a08d938d7de446790dd9f10dd1b63fc', '587.558', '0', '', '42415902', '1', null, '03ac30f6244c1a0b579dcf25c1316a88', '2021-02-06 09:08:53', '1', '2021-02-06 09:14:10', '1', null, '0');
INSERT INTO `edu_video` VALUES ('509', '55', '129', '2-9 select标签多表关联查询（下）', '9', '0', '1', '6364ce64558d465f8703be52ec8df10b', '398.524', '0', '', '31851394', '1', null, '7ef0d5e0d8fd799843c4cbe4cbcac9bc', '2021-02-06 09:09:19', '1', '2021-02-06 09:14:19', '1', null, '0');
INSERT INTO `edu_video` VALUES ('510', '55', '129', '2-10 insert标签的简单用法', '10', '0', '1', 'f6ac5213dc714c1aaa49af9fce4f23e4', '557.604', '0', '', '38198232', '1', null, '28628d3c38cbfe51dce9fd2856e9a945', '2021-02-06 09:09:35', '1', '2021-02-06 09:14:28', '1', null, '0');
INSERT INTO `edu_video` VALUES ('511', '55', '129', '2-7 select标签查询返回ResultMap和ResultType的区别', '7', '0', '1', 'adf6b0c3ea9c4a46bbfdeae20d31871d', '631.026', '0', '', '52453788', '1', null, 'a7d78c1d9ec33635e22f6c7c1dad3b4d', '2021-02-06 09:09:44', '1', '2021-02-06 09:14:38', '1', null, '0');
INSERT INTO `edu_video` VALUES ('512', '55', '129', '2-11 insert标签使用JDBC方式返回主键自增的值', '11', '0', '1', 'e42eef4881184163a35d4e5af42f2cc4', '344.027', '0', '', '28989876', '1', null, '8b6932d073119d61a5a7f757db667ec8', '2021-02-06 09:10:04', '1', '2021-02-06 09:12:45', '1', null, '0');
INSERT INTO `edu_video` VALUES ('513', '55', '129', '2-14 delete标签的用法', '14', '0', '1', 'd087bff2295e435b85188bbd90f1a9b2', '171.061', '0', '', '13607134', '1', null, '83bf254e5a7f843573bd6c9a92590393', '2021-02-06 09:10:34', '1', '2021-02-06 09:12:55', '1', null, '0');
INSERT INTO `edu_video` VALUES ('514', '55', '129', '2-12 insert标签使用selectKey返回主键的值', '12', '0', '1', '85bb4b6f893d460897011a67726f0657', '319.391', '0', '', '25439551', '1', null, 'af64c331e0c23871edb6cb032bda2802', '2021-02-06 09:10:34', '1', '2021-02-06 09:13:02', '1', null, '0');
INSERT INTO `edu_video` VALUES ('515', '55', '129', '2-8 select标签多表关联查询（上）', '8', '0', '1', 'eeede1418b9245869872d2085c8a89a2', '845.067', '0', '', '58375594', '1', null, 'bba343f04b87e1fccd4df8b39e14c574', '2021-02-06 09:10:38', '1', '2021-02-06 09:13:14', '1', null, '0');
INSERT INTO `edu_video` VALUES ('516', '55', '129', '2-13 update标签的用法', '13', '0', '1', 'bfff133b4472452a94097c5effe07864', '405.026', '0', '', '32585436', '1', null, '01bb9db1e6fd62bd1c2bb96e5ae2b39d', '2021-02-06 09:11:32', '1', '2021-02-06 09:13:20', '1', null, '0');
INSERT INTO `edu_video` VALUES ('517', '55', '130', '3-2 mybatis中mapUnderscoreToCamelCase的使用', '2', '0', '1', 'ff4c238186084c4dabb2343375771dda', '97.0594', '0', '', '6877180', '1', null, 'a4fcee23693b6974609aded1f6a2351e', '2021-02-06 09:15:54', '1', '2021-02-06 09:19:44', '1', null, '0');
INSERT INTO `edu_video` VALUES ('518', '55', '130', '3-6 @Insert注解需要返回非自增主键', '6', '0', '1', '978d324935c04097ab1f93e3cc0cf72a', '152.532', '0', '', '12569036', '1', null, 'fb0f7764e4cc8f816d95602d20c21167', '2021-02-06 09:16:16', '1', '2021-02-06 09:19:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('519', '55', '130', '3-5 @Insert注解需要返回自增主键', '5', '0', '1', 'e519450c8427461cbc846164a9d5cf5d', '167.532', '0', '', '14131149', '1', null, '8ca026e9c68b95c5673d861f75c607fa', '2021-02-06 09:16:26', '1', '2021-02-06 09:19:31', '1', null, '0');
INSERT INTO `edu_video` VALUES ('520', '55', '130', '3-8 @Delete注解', '8', '0', '1', '376a19d73b9143169d1c9c66019df2bd', '148.561', '0', '', '10861531', '1', null, 'b110ae9db09fa84f5ee24e8fc53d49ea', '2021-02-06 09:17:04', '1', '2021-02-06 09:19:23', '1', null, '0');
INSERT INTO `edu_video` VALUES ('521', '55', '130', '3-3 使用resultMap方式', '3', '0', '1', '67b92ace1cec4cfcb2a09239dc212270', '415.01', '0', '', '28418824', '1', null, 'd0b1a30722c3b1d7d64906ef933f9346', '2021-02-06 09:17:12', '1', '2021-02-06 09:19:16', '1', null, '0');
INSERT INTO `edu_video` VALUES ('522', '55', '130', '3-7 @update注解', '7', '0', '1', 'd23d1a0d41964f618c8add9475eacdcf', '282.03', '0', '', '23205871', '1', null, '9a94553918aba8c00aabd63c748812e7', '2021-02-06 09:17:24', '1', '2021-02-06 09:19:10', '1', null, '0');
INSERT INTO `edu_video` VALUES ('523', '55', '130', '3-4 @Insert注解不需要返回主键', '4', '0', '1', 'b3e550d019b1433eabc02cec1a7c6010', '456.063', '0', '', '38658096', '1', null, '97c2474b55c8b179f69e7063e6f920ed', '2021-02-06 09:18:01', '1', '2021-02-06 09:19:04', '1', null, '0');
INSERT INTO `edu_video` VALUES ('524', '55', '130', '3-1 @Select注解的用法', '1', '0', '1', 'ea46c58175b441b2b51d05546d7fe9cc', '705.028', '0', '', '46453418', '1', null, '894622b8f88f0b4ac8518bae04f0c5e6', '2021-02-06 09:18:17', '1', '2021-02-06 09:18:59', '1', null, '0');
INSERT INTO `edu_video` VALUES ('525', '55', '131', '4-6 set标签用法', '6', '0', '1', '7ae6e69c4fa64ca68588a5857aeb15a2', '115.032', '0', '', '7640051', '1', null, 'a0c9c34c760f390f984a6cd325bb0271', '2021-02-06 09:21:32', '1', '2021-02-06 09:27:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('526', '55', '131', '4-7 trim标签的用法', '7', '0', '1', '6b77a655d92648b09e53dc47f1bc1ae9', '127.06', '0', '', '4428753', '1', null, 'f7e273bbb0560eff108535b5a250ec20', '2021-02-06 09:21:55', '1', '2021-02-06 09:27:43', '1', null, '0');
INSERT INTO `edu_video` VALUES ('527', '55', '131', '4-5 where标签的用法', '5', '0', '1', '5e2e261f9c324504bb35a07fdc4dd575', '232.06', '0', '', '18918946', '1', null, '480849da2378f70a9b2293657ae2eab6', '2021-02-06 09:22:00', '1', '2021-02-06 09:27:48', '1', null, '0');
INSERT INTO `edu_video` VALUES ('528', '55', '131', '4-3 在insert动态插入列中使用if', '3', '0', '1', 'b936be4c41024c809f23f2f0ac632859', '276.062', '0', '', '22612724', '1', null, '9852370f4fb17854d1f51ff2c6cc4495', '2021-02-06 09:22:19', '1', '2021-02-06 09:27:53', '1', null, '0');
INSERT INTO `edu_video` VALUES ('529', '55', '131', '4-1 if在where条件中使用', '1', '0', '1', 'fc795c159a1e414a94fb26dbe51c90bc', '651.529', '0', '', '45803198', '1', null, '99b20418af6d987426dcfd11f3c9294e', '2021-02-06 09:23:56', '1', '2021-02-06 09:28:23', '1', null, '0');
INSERT INTO `edu_video` VALUES ('530', '55', '131', '4-2 在update更新列中使用if', '2', '0', '1', 'dfa22014389b45deb6e8794e2d35c6ee', '541.513', '0', '', '47710052', '1', null, '78f6cb0ed6c35c37d031d49d57ec2c80', '2021-02-06 09:24:06', '1', '2021-02-06 09:27:59', '1', null, '0');
INSERT INTO `edu_video` VALUES ('531', '55', '131', '4-10 foreach实现动态update', '10', '0', '1', 'e18b7220f53f4991963384be3ec6d56f', '431.032', '0', '', '32158884', '1', null, 'f64fd6a01f103bfe8e2873e9d4031b96', '2021-02-06 09:24:17', '1', '2021-02-06 09:28:03', '1', null, '0');
INSERT INTO `edu_video` VALUES ('532', '55', '131', '4-8 foreach实现in集合', '8', '0', '1', 'a87b2b7470af441fb96db6641d4bec38', '635.461', '0', '', '50179502', '1', null, '192261a59eaa500278d1fcd2855f1443', '2021-02-06 09:24:35', '1', '2021-02-06 09:28:07', '1', null, '0');
INSERT INTO `edu_video` VALUES ('533', '55', '131', '4-11 bind用法', '11', '0', '1', 'd7274447826e4bd985b405633ba61f85', '193.469', '0', '', '15418063', '1', null, '279a580a0349e8125788ae0717e12858', '2021-02-06 09:25:01', '1', '2021-02-06 09:28:11', '1', null, '0');
INSERT INTO `edu_video` VALUES ('534', '55', '131', '4-4 choose用法', '4', '0', '1', 'bf25c9d0a8a64ed5a77440e392ea7eae', '859.533', '0', '', '70613609', '1', null, 'a56c2194a5078aa41cb191c3ce55e59d', '2021-02-06 09:25:15', '1', '2021-02-06 09:28:15', '1', null, '0');
INSERT INTO `edu_video` VALUES ('535', '55', '131', '4-9 foreach实现批量插入', '9', '0', '1', '21f423a1f85949acaaf7b66b5ce1d790', '742.528', '0', '', '61573893', '1', null, 'a21a2b27615c143ea372b93a3d8d59d3', '2021-02-06 09:26:16', '1', '2021-02-06 09:28:19', '1', null, '0');
INSERT INTO `edu_video` VALUES ('536', '55', '132', '5-5 存储过程（上）', '5', '0', '1', 'f37aefe12966485db30cbbf35c43b0b0', '455.529', '0', '', '28740442', '1', null, '28e51255048b647b28c3f008d4f7ed2f', '2021-02-06 09:31:11', '1', '2021-02-06 09:35:23', '1', null, '0');
INSERT INTO `edu_video` VALUES ('537', '55', '132', '5-2 高级结果映射使用resultmap配置处理一对一关系', '2', '0', '1', '46cb1f2b3b4b4fa1976c8a78844a7dfa', '504.546', '0', '', '36704400', '1', null, 'fd789a2a262ac245962f30373b00e876', '2021-02-06 09:31:28', '1', '2021-02-06 09:35:26', '1', null, '0');
INSERT INTO `edu_video` VALUES ('538', '55', '132', '5-6 存储过程（中）', '6', '0', '1', '0fd02fe255544195bc14fc6ebdff1ec0', '664.068', '0', '', '44870952', '1', null, 'd7f3bec7a67a0f835c2916f859d1f30c', '2021-02-06 09:31:39', '1', '2021-02-06 09:35:30', '1', null, '0');
INSERT INTO `edu_video` VALUES ('539', '55', '132', '5-1 高级结果映射使用自动映射处理一对一关系', '1', '0', '1', '5e7816d89ee741f0b009a2048a1268e2', '540.328', '0', '', '47885184', '1', null, '40ad4030952bedd2071a316e14d7e40a', '2021-02-06 09:31:57', '1', '2021-02-06 09:35:33', '1', null, '0');
INSERT INTO `edu_video` VALUES ('540', '55', '132', '5-3 一对多映射（上）', '3', '0', '1', 'd3c02399314944bcaeae40e465686a8e', '658.03', '0', '', '48080030', '1', null, 'fd22ca0b6d15e2866f074b1925b5ee87', '2021-02-06 09:32:09', '1', '2021-02-06 09:35:36', '1', null, '0');
INSERT INTO `edu_video` VALUES ('541', '55', '132', '5-4 一对多映射（下）', '4', '0', '1', 'ee49aeced06e4df2b2e3287bd9ffd58c', '767.536', '0', '', '58560523', '1', null, 'fa36b5fcb6115313bc84e34f11e5d88e', '2021-02-06 09:32:52', '1', '2021-02-06 09:35:40', '1', null, '0');
INSERT INTO `edu_video` VALUES ('542', '55', '132', '5-7 存储过程（下）', '7', '0', '1', '7fe9830a6ed64fa0bef6de95bbff02d7', '649.067', '0', '', '46376927', '1', null, '45bbf1408e0106d728b037b4da183b27', '2021-02-06 09:34:16', '1', '2021-02-06 09:35:45', '1', null, '0');
INSERT INTO `edu_video` VALUES ('543', '55', '133', '6-4 集成Redis缓存', '4', '0', '1', '7645883c83b3436980556aa1d7408519', '183.066', '0', '', '15486085', '1', null, '83312151d3d79b39972e58960a2c54e7', '2021-02-06 09:37:16', '1', '2021-02-06 09:54:41', '1', null, '0');
INSERT INTO `edu_video` VALUES ('544', '55', '133', '6-3 集成EhCache缓存', '3', '0', '1', '85bbd0c7979241e1ad169e2f43ac62f8', '324.058', '0', '', '22061292', '1', null, 'e7dcf6f2b5e63b523b9fcfe80461f455', '2021-02-06 09:37:38', '1', '2021-02-06 09:54:47', '1', null, '0');
INSERT INTO `edu_video` VALUES ('545', '55', '133', '6-2 二级缓存的配置', '2', '0', '1', '3f858df5a64b46d695088009e6de4140', '428.524', '0', '', '22824151', '1', null, '0a59dd5eab1c790585c1f3a8155342ed', '2021-02-06 09:37:40', '1', '2021-02-06 09:54:52', '1', null, '0');
INSERT INTO `edu_video` VALUES ('546', '55', '133', '6-1 一级缓存', '1', '0', '1', 'e82940c0b48d4753a9c0752331cec9d2', '532.526', '0', '', '35056392', '1', null, '8b166b33f924b60eb8d2810f61789dcc', '2021-02-06 09:38:19', '1', '2021-02-06 09:54:55', '1', null, '0');
INSERT INTO `edu_video` VALUES ('547', '56', '134', '1-2 IntelliJ IDEA 配置maven', '2', '0', '0', '8b958eba2bc0473cb1428e63c5ba44a9', '105.465', '0', '', '6241151', '1', null, 'de4286c1831d7592422a771bfadb6b0e', '2021-02-06 09:56:58', '1', '2021-02-06 10:01:47', '1', null, '0');
INSERT INTO `edu_video` VALUES ('548', '56', '134', '1-4 使用 IntelliJ IDEA 导入已有的maven项目', '4', '0', '0', '5043e44172fc421baff19cee7d13df9e', '120.999', '0', '', '7870172', '1', null, '71c44219949645fa033c16b694b07bf2', '2021-02-06 09:56:59', '1', '2021-02-06 10:01:53', '1', null, '0');
INSERT INTO `edu_video` VALUES ('549', '56', '134', '1-3 使用 IntelliJ IDEA 创建maven项目', '3', '0', '0', 'ae60ec455adb49d1b982f8e32cd4ef33', '269.444', '0', '', '16590799', '1', null, '6d92fab9853701c0e21f45d3d7fe4bf3', '2021-02-06 09:57:41', '1', '2021-02-06 10:01:50', '1', null, '0');
INSERT INTO `edu_video` VALUES ('550', '56', '134', '1-1 maven介绍及环境搭建', '1', '0', '0', '72c555ba0f6e4db384e62a657400f3d1', '332.069', '0', '', '22613125', '1', null, '5a17d53df26f338f4419938d73d86407', '2021-02-06 09:57:56', '1', '2021-02-06 10:01:43', '1', null, '0');
INSERT INTO `edu_video` VALUES ('551', '56', '135', '2-2 Maven构建生命周期', '2', '0', '1', '76296902146d494892f503bacdc67f16', '172.896', '0', '', '6244375', '1', null, '244ca186545f5e156345c77a79793ab1', '2021-02-06 09:59:30', '1', '2021-02-06 10:02:01', '1', null, '0');
INSERT INTO `edu_video` VALUES ('552', '56', '135', '2-1 maven中的pom.xml文件', '1', '0', '1', '2896c256abf24ebb8ddf6901cdfdc90b', '159.057', '0', '', '8011258', '1', null, '9d3c63ce786813313ad4f680690d5fc9', '2021-02-06 09:59:36', '1', '2021-02-06 10:02:21', '1', null, '0');
INSERT INTO `edu_video` VALUES ('553', '56', '135', '2-5 maven中的坐标', '5', '0', '1', '0a6caa205d874b3a8d8403bc79bbeab7', '210.025', '0', '', '14038272', '1', null, 'a647a18ed0080259253acaa33fe37708', '2021-02-06 10:00:00', '1', '2021-02-06 10:02:08', '1', null, '0');
INSERT INTO `edu_video` VALUES ('554', '56', '135', '2-4maven常用命令', '4', '0', '1', '3198c4b0b4a74d1aa0568b9d1c2b4d45', '255.025', '0', '', '17771820', '1', null, '14db02d34f62dc77b1f1f539825f262c', '2021-02-06 10:00:22', '1', '2021-02-06 10:02:12', '1', null, '0');
INSERT INTO `edu_video` VALUES ('555', '56', '135', '2-3 Maven 仓库', '3', '0', '1', 'bfaca653388b4155b98420320c5b6428', '495.026', '0', '', '36081454', '1', null, '78ac95ab52747474960b3fce3673ea76', '2021-02-06 10:01:12', '1', '2021-02-06 10:02:18', '1', null, '0');
INSERT INTO `edu_video` VALUES ('556', '47', '64', '1-1 课程介绍', '1', '4', '0', 'a9a294ed883b4c1785740a383e0b193c', '102.029', '0', '', '5726891', '1', null, 'ec2d644447f7a165c0d0664fc95888ad', '2021-02-06 10:04:04', '1', '2021-02-09 12:54:38', '1', null, '0');
INSERT INTO `edu_video` VALUES ('557', '47', '64', '1-2 准备工作', '2', '1', '0', '8ebfd4b24bcc40c6b5fcd61c02768ec8', '200.458', '0', '', '10634025', '1', null, '11f4f24147c5f15cad6eb9b8aba898ea', '2021-02-06 10:04:20', '1', '2021-02-09 12:54:41', '1', null, '0');
INSERT INTO `edu_video` VALUES ('558', '47', '64', '1-4 把数据库脚本导入本地mysql', '4', '0', '0', '0c9db51fc5b94752b2f18ff1e401db36', '172.524', '0', '', '12157958', '1', null, '2df90546de4bd15766c43b2d6e2dcb33', '2021-02-06 10:04:29', '1', '2021-02-06 10:06:33', '1', null, '0');
INSERT INTO `edu_video` VALUES ('559', '47', '64', '1-6 把前台源码导入到WebStorm', '6', '0', '0', '5c477b20d9eb48e58fa8d911c728b81a', '216.062', '0', '', '13670780', '1', null, '5bf8468f699508396c435709e6f66439', '2021-02-06 10:04:33', '1', '2021-02-06 10:06:39', '1', null, '0');
INSERT INTO `edu_video` VALUES ('560', '47', '64', '1-5 部署及运行后端项目', '5', '0', '0', '6cdc66881d86448dbf51c7ed4e26015b', '209.932', '0', '', '15988471', '1', null, '51df2af9b43e3c6314a414d5282ed999', '2021-02-06 10:04:45', '1', '2021-02-06 10:06:45', '1', null, '0');
INSERT INTO `edu_video` VALUES ('561', '47', '64', '1-7 系统功能展示', '7', '2', '0', 'ee865e5d94b04d539903a91afe734c24', '502.526', '0', '', '22906732', '1', null, '2f410f373d6b72b50728093bc381d921', '2021-02-06 10:05:41', '1', '2021-02-09 13:54:06', '1', null, '0');
INSERT INTO `edu_video` VALUES ('562', '47', '64', '1-3 把源码导入到IntelliJ IDEA', '3', '0', '0', '62ea60bcdee74cd3bef5df241b75463f', '505.568', '0', '', '35973132', '1', null, 'ef4ef7e466f2abfc8d42981d12170830', '2021-02-06 10:06:08', '1', '2021-02-06 10:06:57', '1', null, '0');
INSERT INTO `edu_video` VALUES ('563', '47', '65', '2-5 整合log4j', '5', '0', '1', '5b31c5ff08fb4f198598c783c7d76bbe', '70.0314', '0', '', '3655806', '1', null, '79e8e7fab32a6a1a0460a6481c695b06', '2021-02-06 10:14:09', '1', '2021-02-06 10:19:27', '1', null, '0');
INSERT INTO `edu_video` VALUES ('564', '47', '65', '2-2 整合Spring', '2', '2', '1', '2ed672cea8e743b9b2098bb29d0834e0', '272.068', '0', '', '17022823', '1', null, 'd29808781652b0a1859f7e86c64487c0', '2021-02-06 10:15:00', '1', '2021-02-09 13:55:13', '1', null, '0');
INSERT INTO `edu_video` VALUES ('565', '47', '65', '2-1 新建一个maven项目', '1', '3', '1', '62e3b2670ded407fbece4f954420b1c8', '674.563', '0', '', '38061114', '1', null, '6fd3f3e31ef8fac274a6e9e8d144473e', '2021-02-06 10:16:12', '1', '2021-02-09 13:54:57', '1', null, '0');
INSERT INTO `edu_video` VALUES ('566', '47', '65', '2-3 整合SpringMVC', '3', '0', '1', 'cc99f4c8847b461aa4d24948fca1f83c', '605.066', '0', '', '42267718', '1', null, '4375f9aeefb93fbf5eaa009c0d80e7e3', '2021-02-06 10:16:27', '1', '2021-02-06 10:19:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('567', '47', '65', '2-4 整合mybatis', '4', '0', '1', '20a2293c9a864287837d93135431b9b2', '1113.37', '0', '', '78597787', '1', null, '0206d40f2bbebf0a33f4f82787b2c66a', '2021-02-06 10:19:15', '1', '2021-02-06 10:19:42', '1', null, '0');
INSERT INTO `edu_video` VALUES ('568', '47', '66', '3-1 数据表说明', '1', '0', '1', '6f9f9d4abfdf4d4cb9e16ddb2940a083', '88.0268', '0', '', '3834669', '1', null, 'b74752ee468e23c0a9c5855fc890ea0d', '2021-02-06 10:20:58', '1', '2021-02-06 10:29:14', '1', null, '0');
INSERT INTO `edu_video` VALUES ('569', '47', '66', '3-6 功能测试', '6', '0', '1', 'abae540603944c4f9c8c53bf9efe9a1c', '153.53', '0', '', '7086055', '1', null, 'e30dac4171196d399b5f3c8d795a7fd4', '2021-02-06 10:21:13', '1', '2021-02-06 10:28:53', '1', null, '0');
INSERT INTO `edu_video` VALUES ('570', '47', '66', '3-5 创建用户实体类和日志切面类', '5', '0', '1', '675ef91c790444998094d285cb83fb6c', '221.565', '0', '', '17353048', '1', null, '0638ceb5321b187e0f175bf925eeeb17', '2021-02-06 10:21:41', '1', '2021-02-06 10:28:58', '1', null, '0');
INSERT INTO `edu_video` VALUES ('571', '47', '66', '3-3 service层功能实现', '3', '0', '1', '1f947346a128445d85cb735c1ba0df9e', '308.523', '0', '', '18605663', '1', null, '409af9d976370980bd5ec6e4650ffff8', '2021-02-06 10:21:54', '1', '2021-02-06 10:29:04', '1', null, '0');
INSERT INTO `edu_video` VALUES ('572', '47', '66', '3-2 dao层功能实现', '2', '0', '1', '9dd897f3287044d89ba4ded4cf1b00ee', '380.041', '0', '', '23036743', '1', null, '57df9c277ab8c0e410b21ee0a19ea1de', '2021-02-06 10:22:16', '1', '2021-02-06 10:29:07', '1', null, '0');
INSERT INTO `edu_video` VALUES ('573', '47', '66', '3-4 controller层功能实现', '4', '0', '1', 'ed3ec921f2bd44fc9867c0537eb11dd7', '1099.56', '0', '', '75323804', '1', null, 'b70ca24a147eea2c575e35bfd9e32a09', '2021-02-06 10:25:32', '1', '2021-02-06 10:29:11', '1', null, '0');
INSERT INTO `edu_video` VALUES ('574', '47', '67', '4-2 新增用户-service层实现', '2', '0', '1', '5c9a4e66119148b8a31b823d33f451a4', '134.026', '0', '', '8583685', '1', null, 'd35ceb2aa8c4df47d529b58c7e1f6697', '2021-02-06 10:30:26', '1', '2021-02-06 10:31:42', '1', null, '0');
INSERT INTO `edu_video` VALUES ('575', '47', '67', '4-4 新增用户-功能测试', '4', '0', '1', '13887b76133e4b70940049cc5486b7f3', '263.059', '0', '', '10370404', '1', null, 'ae606785f17896dde25d2a5cc6776539', '2021-02-06 10:30:38', '1', '2021-02-06 10:31:47', '1', null, '0');
INSERT INTO `edu_video` VALUES ('576', '47', '67', '4-6 更新用户-service层实现', '6', '0', '1', '2b49116dbe8d4126aa8a2a6de8be1ccc', '208.028', '0', '', '14194225', '1', null, 'd1f65f06c20142614c07354b82e1df18', '2021-02-06 10:30:48', '1', '2021-02-06 10:31:54', '1', null, '0');
INSERT INTO `edu_video` VALUES ('577', '47', '67', '4-1 新增用户-dao层实现', '1', '1', '1', 'e544dc4affdb4f14a2ed3557fcc2da8a', '234.057', '0', '', '16037341', '1', null, '7ab95aead84ac29d5db2a1c6fc1e9b35', '2021-02-06 10:30:49', '1', '2021-02-09 13:53:57', '1', null, '0');
INSERT INTO `edu_video` VALUES ('578', '47', '67', '4-3 新增用户-controller层实现', '3', '0', '1', '88515317d0b940a991b9dcd49a3d3a30', '235.032', '0', '', '18617795', '1', null, '3846c77fde6efd5ab1dd5f5f236f3687', '2021-02-06 10:31:11', '1', '2021-02-06 10:32:03', '1', null, '0');
INSERT INTO `edu_video` VALUES ('579', '47', '67', '4-8 更新用户-功能测试', '8', '0', '1', '4d387fb522c849208c4a1e7815395a22', '182.068', '0', '', '8046838', '1', null, '25f63bab14495b4a96ae7e4b6b139724', '2021-02-06 10:31:16', '1', '2021-02-06 10:32:08', '1', null, '0');
INSERT INTO `edu_video` VALUES ('580', '47', '67', '4-10 删除用户-sevrice层功能实现', '10', '0', '1', '3dac1135eb6a4f008ca721eaebb1a313', '105.535', '0', '', '7106885', '1', null, '65a66ecc157a0031133d105e7f914477', '2021-02-06 10:31:19', '1', '2021-02-06 10:32:12', '1', null, '0');
INSERT INTO `edu_video` VALUES ('581', '47', '67', '4-7 更新用户-controller层实现', '7', '0', '1', '59d65e6596334673b4d3dc947d7dc8a5', '192.563', '0', '', '14001862', '1', null, '6dd846f997b4e46ae0d5db3bf8b37035', '2021-02-06 10:31:27', '1', '2021-02-06 10:32:17', '1', null, '0');
INSERT INTO `edu_video` VALUES ('582', '47', '67', '4-5 更新用户-dao层实现', '5', '0', '1', '9ddf14a7d7714851bb74145733c31228', '387.03', '0', '', '26000999', '1', null, '47dc5ea65a0511ce11b497f9b3eafce0', '2021-02-06 10:31:28', '1', '2021-02-06 10:32:22', '1', null, '0');
INSERT INTO `edu_video` VALUES ('583', '47', '67', '4-9 删除用户-dao层功能实现', '9', '0', '1', '0408abaf671842118135ef49e6a82ac5', '140.736', '0', '', '9374155', '1', null, '5ab845bbba3679f88f67281a9491f942', '2021-02-06 10:31:29', '1', '2021-02-06 10:32:26', '1', null, '0');
INSERT INTO `edu_video` VALUES ('584', '47', '67', '4-12 删除用户-功能测试', '12', '0', '1', '806a303705e648d7948e99a52ec498f5', '149.56', '0', '', '9281149', '1', null, 'b9bdb45b8c887c71cfc04a984243fd3b', '2021-02-06 10:33:41', '1', '2021-02-06 10:35:22', '1', null, '0');
INSERT INTO `edu_video` VALUES ('585', '47', '67', '4-11 删除用户-controller层功能实现', '11', '0', '1', '64c082385caf46b1a022ff08b3dbe07d', '148.027', '0', '', '11804790', '1', null, '266e815a9612ba4e58fc7cafec8ee565', '2021-02-06 10:33:49', '1', '2021-02-06 10:35:26', '1', null, '0');
INSERT INTO `edu_video` VALUES ('586', '47', '67', '4-16 查看用户列表-功能测试', '16', '0', '1', '83caaf32540a42ffa4ad3d527ce16250', '205.566', '0', '', '11238178', '1', null, '20811af656564b7ec87375968c7b3927', '2021-02-06 10:33:55', '1', '2021-02-06 10:35:30', '1', null, '0');
INSERT INTO `edu_video` VALUES ('587', '47', '67', '4-15 查看用户列表-controller层功能实现', '15', '0', '1', 'd2ab152a6db5410b8176f4eeec592a92', '158.058', '0', '', '13243827', '1', null, 'f3f4995f9dbbe94b12aeaf297ecdb9c6', '2021-02-06 10:34:03', '1', '2021-02-06 10:35:34', '1', null, '0');
INSERT INTO `edu_video` VALUES ('588', '47', '67', '4-17 修改用户密码-dao层功能实现', '17', '0', '1', '29df58ee84494f58a0634980b763441a', '143.058', '0', '', '10678849', '1', null, 'f021ecf14cc10732adc7a414f138057f', '2021-02-06 10:34:23', '1', '2021-02-06 10:35:39', '1', null, '0');
INSERT INTO `edu_video` VALUES ('589', '47', '67', '4-13 查看用户列表-dao层功能实现', '13', '0', '1', 'a45e1aae82424893a8333b612e36441a', '269.026', '0', '', '19915001', '1', null, '8e48728edba25abe7fef32b9a1733743', '2021-02-06 10:34:26', '1', '2021-02-06 10:35:44', '1', null, '0');
INSERT INTO `edu_video` VALUES ('590', '47', '67', '4-18 修改用户密码-service层功能实现', '18', '0', '1', '30978f6252f1465db136af454ed73c28', '117.563', '0', '', '9400192', '1', null, '0238d5998ad027b2f1c95a473e3e74ad', '2021-02-06 10:34:28', '1', '2021-02-06 10:35:49', '1', null, '0');
INSERT INTO `edu_video` VALUES ('591', '47', '67', '4-19 修改用户密码-controller层功能实现', '19', '0', '1', '4d4cc296db3c401085a618ba2a55093f', '93.53', '0', '', '8016471', '1', null, '92d2eb0c6bfce54fa939c23e0aee2e88', '2021-02-06 10:34:31', '1', '2021-02-06 10:35:54', '1', null, '0');
INSERT INTO `edu_video` VALUES ('592', '47', '67', '4-20 修改用户密码-功能测试', '20', '0', '1', 'c2aaf56b933a41309fe4c13bd5db2281', '191.007', '0', '', '9328394', '1', null, 'a91034633fda55c2478f95e005c80639', '2021-02-06 10:34:44', '1', '2021-02-06 10:35:59', '1', null, '0');
INSERT INTO `edu_video` VALUES ('593', '47', '67', '4-14 查看用户列表-service层功能实现', '14', '0', '1', 'e367850322454d13a5f69a9d30df8c0d', '407.557', '0', '', '28514116', '1', null, '2c11ae04688b045bf12a6e74253824f4', '2021-02-06 10:34:58', '1', '2021-02-06 10:36:03', '1', null, '0');
INSERT INTO `edu_video` VALUES ('594', '47', '68', '5-6 更新图书-service层功能实现', '6', '0', '1', '4a853232baa34d0ebcff0289295b8c43', '107.067', '0', '', '6734238', '1', null, '898e57bfdd6705689d375648cebd225f', '2021-02-06 10:37:02', '1', '2021-02-06 10:42:51', '1', null, '0');
INSERT INTO `edu_video` VALUES ('595', '47', '68', '5-5 更新图书-dao层功能实现', '5', '0', '1', 'c7f88ff392484fe8bced2051faff862e', '209.56', '0', '', '13438768', '1', null, '7deac55d522950e9503220e2d853a612', '2021-02-06 10:37:25', '1', '2021-02-06 10:42:56', '1', null, '0');
INSERT INTO `edu_video` VALUES ('596', '47', '68', '5-2 新增图书-service层功能实现', '2', '0', '1', 'dac489e99ec04aceb3eb05a7a3f055cc', '273.438', '0', '', '16139619', '1', null, 'e4341d90a7a1b1a87f650c7371cf8ceb', '2021-02-06 10:37:36', '1', '2021-02-06 10:42:59', '1', null, '0');
INSERT INTO `edu_video` VALUES ('597', '47', '68', '5-3 新增图书-controller层功能实现', '3', '0', '1', '8cd576e645dc41929c3b03836261b85d', '260.064', '0', '', '18775870', '1', null, 'a1da39adf7cdfbe22154c1e934e295f5', '2021-02-06 10:37:49', '1', '2021-02-06 10:43:03', '1', null, '0');
INSERT INTO `edu_video` VALUES ('598', '47', '68', '5-1 新增图书-dao层功能实现', '1', '0', '1', '56bfd09a57ee4b8bb4beee3242bbd696', '429.058', '0', '', '25709938', '1', null, '303e0ec1038059b14c194a898882bf77', '2021-02-06 10:38:11', '1', '2021-02-06 10:43:28', '1', null, '0');
INSERT INTO `edu_video` VALUES ('599', '47', '68', '5-4 新增图书-功能测试', '4', '0', '1', 'fe815f62ea834e8d857f19c38fd3b389', '378.067', '0', '', '28964848', '1', null, 'f51dcd1a17a9d2527f903820e5a92703', '2021-02-06 10:38:35', '1', '2021-02-06 10:43:09', '1', null, '0');
INSERT INTO `edu_video` VALUES ('600', '47', '68', '5-8 删除图书功能实现', '8', '0', '1', '12de35c1bd314587b2c48d53df977098', '334.065', '0', '', '21979580', '1', null, 'ea74b853ba3533fa445a1be22f79981a', '2021-02-06 10:38:51', '1', '2021-02-06 10:43:14', '1', null, '0');
INSERT INTO `edu_video` VALUES ('601', '47', '68', '5-7 更新图书-controller层功能实现以及功能测试', '7', '0', '1', '329bb3a27f50446ea21385c60e5f1387', '450.026', '0', '', '36471613', '1', null, '5ece7898a1b4aab7caa2301642eb4bea', '2021-02-06 10:39:32', '1', '2021-02-06 10:43:19', '1', null, '0');
INSERT INTO `edu_video` VALUES ('602', '47', '68', '5-9 查看图书列表功能实现', '9', '0', '1', '4bce04ce633b41f0b0e58fa0802d7af7', '1059.34', '0', '', '74956946', '1', null, '66c27301061f0f942330f55efa4e155f', '2021-02-06 10:42:37', '1', '2021-02-06 10:43:25', '1', null, '0');
INSERT INTO `edu_video` VALUES ('603', '47', '69', '6-4 更新图书库存功能实现', '4', '0', '1', '2c9b45bfc06244c7bcd89cfc84ed9bfe', '455.065', '0', '', '34161398', '1', null, 'db07bb4c1c1ef2a4940600896d5cc53b', '2021-02-06 10:46:04', '1', '2021-02-06 10:48:25', '1', null, '0');
INSERT INTO `edu_video` VALUES ('604', '47', '69', '6-3 查看图书借阅列表功能实现', '3', '0', '1', '94302f4f25084613865ec15f613c9918', '631.536', '0', '', '45336334', '1', null, '6444459de8a9e2c8fc19b467350b8807', '2021-02-06 10:46:44', '1', '2021-02-06 10:48:29', '1', null, '0');
INSERT INTO `edu_video` VALUES ('605', '47', '69', '6-2 图书归还功能实现', '2', '0', '1', '99a50d689ac042149ba789311adc6eb8', '748.031', '0', '', '49916139', '1', null, '914acc0e3c0cb1a26693672d9df27d25', '2021-02-06 10:47:19', '1', '2021-02-06 10:48:32', '1', null, '0');
INSERT INTO `edu_video` VALUES ('606', '47', '69', '6-1 借阅图书功能实现', '1', '2', '1', '26e2501003024fb8a75569c71a012827', '903.024', '0', '', '57365839', '1', null, '5d64b0e1dc3a613b776e57e5953f08b5', '2021-02-06 10:47:29', '1', '2021-02-10 17:25:14', '1', null, '0');
INSERT INTO `edu_video` VALUES ('607', '47', '70', '7-1 数据表说明', '0', '0', '1', 'faff8b6d172c46daab8cbace9c5f9b81', '125.527', '0', '', '5695477', '1', null, '210937bc7fdbc3f57460a4573056fd94', '2021-02-06 10:49:26', '1', '2021-02-06 10:49:26', '1', null, '0');
INSERT INTO `edu_video` VALUES ('608', '47', '70', '7-2 新增日志功能实现', '0', '0', '1', 'ecdba564494d4d62881ab0b48e96f16c', '1548.56', '0', '', '106869363', '1', null, '733d8a88bc1a939e1ef5510f2741b5a6', '2021-02-06 10:55:18', '1', '2021-02-06 10:55:18', '1', null, '0');
INSERT INTO `edu_video` VALUES ('609', '47', '70', '7-3 查看日志列表功能实现', '0', '0', '1', '092e0ade34fd4f0799fc2011625086df', '1246.56', '0', '', '102524692', '1', null, 'dde5787c20f55135a5946250f94299dc', '2021-02-06 10:55:56', '1', '2021-02-06 10:55:56', '1', null, '0');
INSERT INTO `edu_video` VALUES ('610', '47', '71', '8-5 完善登录功能实现', '5', '0', '1', 'acda526dcf104c0d9086266e25d57c98', '280.567', '0', '', '18452875', '1', null, '95f594288f1d6159fbcfdcfafb65f0c4', '2021-02-06 12:28:46', '1', '2021-02-06 12:31:18', '1', null, '0');
INSERT INTO `edu_video` VALUES ('611', '47', '71', '8-1 使用vue-ui工具创建一个vue项目', '1', '1', '1', '67030ea7095e4a669a1f330675f72c9f', '527.464', '0', '', '25534528', '1', null, '7711bffb694e67cc53d044fbe0f65b81', '2021-02-06 12:29:06', '1', '2021-02-10 16:31:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('612', '47', '71', '8-2 完善前端项目', '2', '0', '1', 'f687af4e488644b0a541f24700984398', '479.562', '0', '', '25896921', '1', null, '7652b957c913858363af7cb024d70d3f', '2021-02-06 12:29:15', '1', '2021-02-06 12:31:24', '1', null, '0');
INSERT INTO `edu_video` VALUES ('613', '47', '71', '8-3 配置前端项目', '3', '0', '1', '322f69a5fc9e4e5d9c9b4d4a76d3dfdf', '774.525', '0', '', '36829125', '1', null, '8e7bfbf883cfa3a83b01bbfc06ae227d', '2021-02-06 12:29:43', '1', '2021-02-06 12:31:28', '1', null, '0');
INSERT INTO `edu_video` VALUES ('614', '47', '71', '8-4登录功能实现', '4', '0', '1', '26a58af0175e4e6bbfdc8a163c32657f', '1000.04', '0', '', '54842563', '1', null, '51b2b023a948c0c45d9a19c74c6557d1', '2021-02-06 12:31:03', '1', '2021-02-06 12:31:32', '1', null, '0');
INSERT INTO `edu_video` VALUES ('615', '47', '72', '9-4 完善添加用户页面', '4', '0', '1', '979185ee31b54c8d96d7373010722807', '280.033', '0', '', '14509007', '1', null, 'a3d201f339967eb7515d6f7e2aa1602c', '2021-02-06 12:32:59', '1', '2021-02-06 12:37:59', '1', null, '0');
INSERT INTO `edu_video` VALUES ('616', '47', '72', '9-5 校验用户名是否存在', '5', '0', '1', '1c275f41101a4988aef3b98370895f07', '365.064', '0', '', '18360133', '1', null, 'd0822cf670e437b37b575a16be2cc734', '2021-02-06 12:33:21', '1', '2021-02-06 12:38:04', '1', null, '0');
INSERT INTO `edu_video` VALUES ('617', '47', '72', '9-6 添加用户功能实现', '6', '0', '1', 'a8b06a5b5c874f51b7d8a601aef18c9a', '493.563', '0', '', '25455338', '1', null, 'ca13180d47c026641d2937da7dde46af', '2021-02-06 12:33:40', '1', '2021-02-06 12:38:09', '1', null, '0');
INSERT INTO `edu_video` VALUES ('618', '47', '72', '9-7 编辑用户功能实现', '7', '0', '1', '72b2115532d4450ba636e0dacdf77192', '273.531', '0', '', '18391487', '1', null, 'b2e8751bb2aa3676171b51a94596635e', '2021-02-06 12:34:14', '1', '2021-02-06 12:38:13', '1', null, '0');
INSERT INTO `edu_video` VALUES ('619', '47', '72', '9- 1用户列表页面的实现', '1', '0', '1', '1b99f0f2ce3b42a099120226c7ffe514', '757.063', '0', '', '39979063', '1', null, '8cb4d741f2d9d221d328b4b04b8d5ee6', '2021-02-06 12:34:19', '1', '2021-02-06 12:38:16', '1', null, '0');
INSERT INTO `edu_video` VALUES ('620', '47', '72', '9-8 删除用户功能实现', '8', '0', '1', 'd377653b4aaf4ae49eb1c120250a8349', '388.029', '0', '', '24683625', '1', null, 'b6f6423613c20b5ca1d40626ec55dd7d', '2021-02-06 12:34:57', '1', '2021-02-06 12:38:21', '1', null, '0');
INSERT INTO `edu_video` VALUES ('621', '47', '72', '9-2查询用户列表功能实现', '2', '0', '1', '8c2111425ee247a3b1633e7908f4f0e3', '1042.53', '0', '', '55826927', '1', null, '8109a5267239e1869e6d25991c6e5ea5', '2021-02-06 12:35:27', '1', '2021-02-06 12:38:24', '1', null, '0');
INSERT INTO `edu_video` VALUES ('622', '47', '72', '9-3添加用户页面实现', '3', '0', '1', 'f5b2702299a6463e864f4ed1edc27656', '1210.53', '0', '', '64673909', '1', null, 'dfdf4e494314f4e21388997db1ffff5f', '2021-02-06 12:36:13', '1', '2021-02-06 12:38:28', '1', null, '0');
INSERT INTO `edu_video` VALUES ('623', '47', '72', '9-9 修改用户密码功能实现', '9', '0', '1', 'a712a28545dd4eea8041be2f088d611a', '863.062', '0', '', '46268671', '1', null, '8e3a0d34f50ff71bfd0e0a805025128f', '2021-02-06 12:36:42', '1', '2021-02-06 12:38:33', '1', null, '0');
INSERT INTO `edu_video` VALUES ('624', '47', '73', '10-3 图书管理页面实现', '3', '0', '1', '4d93bd6fcd50443eb25404e7f9eabc1d', '313.028', '0', '', '14785984', '1', null, 'cfa5d7af4eec74e69038d5acbaeaecd4', '2021-02-06 12:40:05', '1', '2021-02-06 12:43:09', '1', null, '0');
INSERT INTO `edu_video` VALUES ('625', '47', '73', '10-4获取图书列表功能实现', '4', '0', '1', 'acc9715f40e248f19fda1de0f8a2849b', '523.563', '0', '', '27004640', '1', null, '3ae8b989ba83e78ecf2cf91fb46fe598', '2021-02-06 12:40:50', '1', '2021-02-06 12:43:15', '1', null, '0');
INSERT INTO `edu_video` VALUES ('626', '47', '73', '10-6新增图书功能实现', '6', '0', '1', 'ee399f79ab1f4711aad9bdeeafb6cfb3', '404.492', '0', '', '27214414', '1', null, '2671fa87046403f449492ce32747dfc7', '2021-02-06 12:40:53', '1', '2021-02-06 12:43:20', '1', null, '0');
INSERT INTO `edu_video` VALUES ('627', '47', '73', '10- 1 添加图书管理路由', '1', '0', '1', '5572002baab441c8a063dff55e3c934f', '556.559', '0', '', '33804352', '1', null, 'f798d7cf149267920af7afd941735d30', '2021-02-06 12:41:09', '1', '2021-02-06 12:43:56', '1', null, '0');
INSERT INTO `edu_video` VALUES ('628', '47', '73', '10-7 编辑图书功能实现', '7', '0', '1', '7e892d459b9149a1ab6ede41e1842ee0', '166.998', '0', '', '15432411', '1', null, '340115deb8d460a87af51f6e782797e8', '2021-02-06 12:41:14', '1', '2021-02-06 12:43:29', '1', null, '0');
INSERT INTO `edu_video` VALUES ('629', '47', '73', '10-2 动态路由权限功能实现', '2', '0', '1', 'a52945124b234ecfa1215769c80ca26c', '651.529', '0', '', '39607214', '1', null, 'f80bd03a648181465ac5f837b2d904c7', '2021-02-06 12:41:14', '1', '2021-02-06 12:43:33', '1', null, '0');
INSERT INTO `edu_video` VALUES ('630', '47', '73', '10-10图书借阅列表页面的实现', '10', '0', '1', '60e134193394406f925fa6dcac44d76e', '210.025', '0', '', '8915167', '1', null, '5035b41029d07348051f047123c405fb', '2021-02-06 12:41:47', '1', '2021-02-06 12:43:38', '1', null, '0');
INSERT INTO `edu_video` VALUES ('631', '47', '73', '10-9添加图书借阅路由', '9', '0', '1', 'e9fee2265e3d4c4982028518ae504235', '329.561', '0', '', '14624732', '1', null, '1516216f5e88f5546c505b1595fdc4d5', '2021-02-06 12:41:50', '1', '2021-02-06 12:43:43', '1', null, '0');
INSERT INTO `edu_video` VALUES ('632', '47', '73', '10-5 新增图书页面的实现', '5', '0', '1', '31b169bf958549769f78fe90d60f88ce', '819.13', '0', '', '50814341', '1', null, 'ddde92b3c477f94d78ba8ca8ba0695bd', '2021-02-06 12:42:02', '1', '2021-02-06 12:43:48', '1', null, '0');
INSERT INTO `edu_video` VALUES ('633', '47', '73', '10-8删除图书功能实现', '8', '0', '1', '7840684bb39b49a7899a43646a90b855', '255.025', '0', '', '24640533', '1', null, '53c6321126dd3368dc88e0fd983a7592', '2021-02-06 12:42:20', '1', '2021-02-06 12:43:52', '1', null, '0');
INSERT INTO `edu_video` VALUES ('634', '47', '73', '10-15 图书归还页面功能实现', '15', '0', '1', '2dffaa1b86d54075a069a9e0637725f8', '339.569', '0', '', '18960943', '1', null, '5e081e5b7a149ee3305d91b449f801ac', '2021-02-06 12:45:49', '1', '2021-02-06 12:52:30', '1', null, '0');
INSERT INTO `edu_video` VALUES ('635', '47', '73', '10-11获取图书借阅列表数据功能实现', '11', '0', '1', '08ba572ff92446839cae229bf98a5083', '354.801', '0', '', '19344601', '1', null, 'd6510f623fff99d0fb61494aa0052f5c', '2021-02-06 12:45:59', '1', '2021-02-06 12:52:35', '1', null, '0');
INSERT INTO `edu_video` VALUES ('636', '47', '73', '10-13 打印功能实现', '13', '0', '1', 'f3e0fefb8fb44d6ab94621de6c9d99ae', '424.066', '0', '', '24040599', '1', null, '1403c39b1d20bb8d47f1ab19e6eb9d4d', '2021-02-06 12:46:01', '1', '2021-02-06 12:52:40', '1', null, '0');
INSERT INTO `edu_video` VALUES ('637', '47', '73', '10-14 查询和分页功能实现', '14', '0', '1', '42449aca25d44d079264a64e01c403e2', '405.56', '0', '', '21958990', '1', null, '92a20e19b29c7a883f4684e9f578f173', '2021-02-06 12:46:07', '1', '2021-02-06 12:52:44', '1', null, '0');
INSERT INTO `edu_video` VALUES ('638', '47', '73', '10-19 催还功能实现', '19', '0', '1', 'fccb9bbca7554630ba3ffb941b9a9601', '307.525', '0', '', '15397942', '1', null, '5144356a7c8b355df0903fd3dd800a81', '2021-02-06 12:46:57', '1', '2021-02-06 12:52:49', '1', null, '0');
INSERT INTO `edu_video` VALUES ('639', '47', '73', '10-16 图书归还列表功能实现', '16', '0', '1', 'a4c269e5f3d04205a3e167602d1820f2', '969.062', '0', '', '54397265', '1', null, 'a90d56b57f526b377a3c93dee24345fb', '2021-02-06 12:47:42', '1', '2021-02-06 12:52:55', '1', null, '0');
INSERT INTO `edu_video` VALUES ('640', '47', '73', '10-12图书借阅功能实现', '12', '0', '1', 'cd4511687a3b41b394d78a497db21348', '854.03', '0', '', '44287906', '1', null, '39aef55ab97e9d82252efe2e75274bcf', '2021-02-06 12:47:45', '1', '2021-02-06 12:53:00', '1', null, '0');
INSERT INTO `edu_video` VALUES ('641', '47', '73', '10-18 借阅用户列表功能实现', '18', '0', '1', '297196e003634a5597111bc105c66b3a', '876.066', '0', '', '46623437', '1', null, '6723598246fec78395fcbc60c1c5239a', '2021-02-06 12:48:32', '1', '2021-02-06 12:53:06', '1', null, '0');
INSERT INTO `edu_video` VALUES ('642', '47', '73', '10-17 归还图书功能实现', '17', '0', '1', '81fe99c032e94b1297d0a203aba5131e', '697.063', '0', '', '42385113', '1', null, 'a6d6dd3dab2da306b83c1aeb414eacbd', '2021-02-06 12:48:39', '1', '2021-02-06 12:53:10', '1', null, '0');
INSERT INTO `edu_video` VALUES ('643', '47', '74', '11-2获取日志列表功能实现', '2', '0', '1', '155414fc04fa45519a04bb069571ac8f', '422', '0', '', '21280084', '1', null, '6534ba6bac618fdfd3e12e875d5b115f', '2021-02-06 12:54:59', '1', '2021-02-06 12:57:17', '1', null, '0');
INSERT INTO `edu_video` VALUES ('644', '47', '74', '11- 1日志列表页面的实现', '1', '0', '1', 'c3f2ec31475f4865b4491faf9ae43a5f', '423.996', '0', '', '28674720', '1', null, '09c79467c86bda6f77eb56c50021ab48', '2021-02-06 12:55:14', '1', '2021-02-06 12:57:13', '1', null, '0');
INSERT INTO `edu_video` VALUES ('645', '48', '75', '1-2 准备工作', '2', '0', '0', '4e39562bd9c84dc3b86848936291b4d4', '82.5237', '0', '', '3597608', '1', null, '205f4593efb9e6e6e457f9034f293724', '2021-02-06 12:58:21', '1', '2021-02-06 13:01:23', '1', null, '0');
INSERT INTO `edu_video` VALUES ('646', '48', '75', '1-4 把数据库脚本导入本地mysql', '4', '0', '0', 'd6e16392ff564ef1b313606128918f45', '93.0656', '0', '', '6166497', '1', null, 'a8ca40a2f04a798a050abf77b082cebe', '2021-02-06 12:58:32', '1', '2021-02-06 13:01:29', '1', null, '0');
INSERT INTO `edu_video` VALUES ('647', '48', '75', '1-3 把源码导入到IntelliJ IDEA', '3', '0', '0', '9e289c89d3fa40de968568b59d984f90', '116.564', '0', '', '6920199', '1', null, '025030549131c1475219b40f282e7e89', '2021-02-06 12:58:35', '1', '2021-02-06 13:01:26', '1', null, '0');
INSERT INTO `edu_video` VALUES ('648', '48', '75', '1-5 部署及运行项目', '5', '0', '0', 'f4ce665b151c4015b171455a83c3d86d', '131.959', '0', '', '9373854', '1', null, '09c5d60151d7426eba68dd53729a2b68', '2021-02-06 12:58:45', '1', '2021-02-06 13:01:33', '1', null, '0');
INSERT INTO `edu_video` VALUES ('649', '48', '75', '1-1 课程介绍', '1', '0', '0', 'aea73276fa43439db6de6efdf89fa4b9', '262.06', '0', '', '16234337', '1', null, 'aa319270760323627ec661ba72eff5a7', '2021-02-06 12:59:13', '1', '2021-02-06 13:01:19', '1', null, '0');
INSERT INTO `edu_video` VALUES ('650', '48', '76', '2-5 整合log4j', '5', '0', '1', 'a922ce0b45424546be2231bac83a76f3', '67.0592', '0', '', '3693071', '1', null, 'd90284c5b2ae5f8f29514f58cd8d4593', '2021-02-06 13:02:38', '1', '2021-02-06 13:06:11', '1', null, '0');
INSERT INTO `edu_video` VALUES ('651', '48', '76', '2-6 编写系统用户实体类', '6', '0', '1', '62957777e0ec4ad3af24a2c118f534b4', '131.03', '0', '', '7801055', '1', null, '2d5b86233d018ce97cd26b38c6408b9e', '2021-02-06 13:02:52', '1', '2021-02-06 13:06:16', '1', null, '0');
INSERT INTO `edu_video` VALUES ('652', '48', '76', '2-2 整合Spring', '2', '0', '1', '75f8df2552594caf902302e70c5b518b', '205.566', '0', '', '13502727', '1', null, '76787441eca982a571430d4aa2c6862e', '2021-02-06 13:03:18', '1', '2021-02-06 13:06:19', '1', null, '0');
INSERT INTO `edu_video` VALUES ('653', '48', '76', '2-8 编写学生实体类', '8', '0', '1', 'c99e0550a25d445f9808f89fa200af0b', '160.566', '0', '', '10756691', '1', null, 'ebb268c052643f571e95ae037eca64eb', '2021-02-06 13:03:36', '1', '2021-02-06 13:06:24', '1', null, '0');
INSERT INTO `edu_video` VALUES ('654', '48', '76', '2-3 整合SpringMVC', '3', '0', '1', '30236d2c33e24a1790650fd6df0d1b14', '335.528', '0', '', '26089779', '1', null, '5c4504e81fdd8cbe9f9cf067bd4c31d9', '2021-02-06 13:03:59', '1', '2021-02-06 13:06:28', '1', null, '0');
INSERT INTO `edu_video` VALUES ('655', '48', '76', '2-7 编写课程实体类', '7', '1', '1', 'a274b075f0af4cd2b561f969bc2a1c58', '297.564', '0', '', '20675917', '1', null, '87e26671434639798bcbb1113c54eb59', '2021-02-06 13:04:09', '1', '2021-02-11 10:54:58', '1', null, '0');
INSERT INTO `edu_video` VALUES ('656', '48', '76', '2-9 选课详情实体类', '9', '0', '1', '1f8688050d0c4645baac42754bd9f80d', '228.066', '0', '', '14580902', '1', null, '298383372bf03685c413824ffa621c5b', '2021-02-06 13:04:15', '1', '2021-02-06 13:06:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('657', '48', '76', '2-1 新建一个maven项目', '1', '0', '1', '6136da105f524516868f903358afcc99', '518.525', '0', '', '31026372', '1', null, 'c27a95ea0e53a418eb1e10555945dcf9', '2021-02-06 13:04:17', '1', '2021-02-06 13:06:48', '1', null, '0');
INSERT INTO `edu_video` VALUES ('658', '48', '76', '2-4 整合mybatis', '4', '0', '1', '0fc61da2b6df46d4aac869c9a166e089', '541.559', '0', '', '41141375', '1', null, '634756d56dbabd860834b1a010a50c66', '2021-02-06 13:05:10', '1', '2021-02-06 13:06:45', '1', null, '0');
INSERT INTO `edu_video` VALUES ('659', '48', '77', '3-6 拦截器功能实现', '6', '0', '1', '4b000754da3745fb87a13e6a3474d740', '111.502', '0', '', '7192529', '1', null, '690a2ace669775f01aaac7bd775240b3', '2021-02-06 13:07:45', '1', '2021-02-06 13:09:57', '1', null, '0');
INSERT INTO `edu_video` VALUES ('660', '48', '77', '3-2 dao层功能实现（二）', '2', '0', '1', '509617a526d14c37adb72f4bef146556', '283.028', '0', '', '18206766', '1', null, 'd9724d5b0e48233ddcb8881e27fd3ed9', '2021-02-06 13:08:24', '1', '2021-02-06 13:10:01', '1', null, '0');
INSERT INTO `edu_video` VALUES ('661', '48', '77', '3-4 controller层功能实现', '4', '0', '1', 'a3bc7a190efe46afa91abb023e70ecb3', '349.53', '0', '', '22861889', '1', null, '6079c23539fc07bfdd48d3d2e5793b6f', '2021-02-06 13:08:32', '1', '2021-02-06 13:10:05', '1', null, '0');
INSERT INTO `edu_video` VALUES ('662', '48', '77', '3-3 service层功能实现', '3', '0', '1', 'd026c7ffd3914476b1078e4f437b2a79', '280.033', '0', '', '18258016', '1', null, '233365c548ced1ed800b69e7aaaca2d0', '2021-02-06 13:08:32', '1', '2021-02-06 13:10:09', '1', null, '0');
INSERT INTO `edu_video` VALUES ('663', '48', '77', '3-1 dao层功能实现（一）', '1', '0', '1', '87eef781a77441ae8ac180e8acb21319', '364.53', '0', '', '21564366', '1', null, 'ca61f09d3e4fce197086b66c7d51af65', '2021-02-06 13:08:41', '1', '2021-02-06 13:10:26', '1', null, '0');
INSERT INTO `edu_video` VALUES ('664', '48', '77', '3-7 完善后台首页', '7', '0', '1', 'd6a7df8f7bc64c97afc62ff18023ec24', '254.398', '0', '', '17273233', '1', null, '97aca4caa820324a5564be2e6e75d0d2', '2021-02-06 13:08:56', '1', '2021-02-06 13:10:18', '1', null, '0');
INSERT INTO `edu_video` VALUES ('665', '48', '77', '3-5 登录页面功能实现', '5', '0', '1', 'd9878316ceb94e27b9d4c44a14fdad97', '443.524', '0', '', '32231028', '1', null, 'd6ab9564d88fb1b0fe6cf2fccc53b444', '2021-02-06 13:09:22', '1', '2021-02-06 13:10:23', '1', null, '0');
INSERT INTO `edu_video` VALUES ('666', '48', '78', '4-2 新增课程页面功能实现', '2', '0', '1', '204d56d046264158b6a55b5fe25c5b38', '429.058', '0', '', '29488762', '1', null, 'c333bbff6e8e32b245d2f661d805b972', '2021-02-06 13:12:58', '1', '2021-02-06 13:20:39', '1', null, '0');
INSERT INTO `edu_video` VALUES ('667', '48', '78', '4-6 课程列表页面功能实现', '6', '0', '1', '0419067f5d83431fa9647d0fd4cc89a9', '393.462', '0', '', '33073406', '1', null, 'a63565a111ed70495b4584473fe01ed3', '2021-02-06 13:13:06', '1', '2021-02-06 13:20:44', '1', null, '0');
INSERT INTO `edu_video` VALUES ('668', '48', '78', '4-4 编辑课程页面功能实现', '4', '0', '1', '21dacfdf65ca45f0b7fb0143560de53e', '647.442', '0', '', '54146599', '1', null, '2a1fbb456a23aaee685bc83bca589846', '2021-02-06 13:14:03', '1', '2021-02-06 13:20:48', '1', null, '0');
INSERT INTO `edu_video` VALUES ('669', '48', '78', '4-8 删除课程功能实现', '8', '0', '1', '1ba515749efe4cec88d2b2baa21d86b5', '579.524', '0', '', '42575275', '1', null, 'a49cbb7617c85c004804a8c77af9462a', '2021-02-06 13:15:59', '1', '2021-02-06 13:20:54', '1', null, '0');
INSERT INTO `edu_video` VALUES ('670', '48', '78', '4-5 课程列表功能实现', '5', '0', '1', 'e8363df0da3f48f1baf86c7e541b81d3', '1226.52', '0', '', '93196265', '1', null, '6b628e289f2a3b763be09451d514f486', '2021-02-06 13:17:24', '1', '2021-02-06 13:20:59', '1', null, '0');
INSERT INTO `edu_video` VALUES ('671', '48', '78', '4-7 课程列表页面分页功能实现', '7', '0', '1', 'f25ed6e825bd42cc9b4a4e52abf3d0c3', '967.065', '0', '', '76620131', '1', null, '509caaa6eea7ffb15a9985fc24ee8adc', '2021-02-06 13:18:07', '1', '2021-02-06 13:21:05', '1', null, '0');
INSERT INTO `edu_video` VALUES ('672', '48', '78', '4-1 新增课程功能实现', '1', '0', '1', '8e793a8904e14b77bc13ca25c1a89a5e', '1731.02', '0', '', '124207521', '1', null, '63f8ab8e9b4944c2d048efa6aaf38f25', '2021-02-06 13:18:36', '1', '2021-02-06 13:21:14', '1', null, '0');
INSERT INTO `edu_video` VALUES ('673', '48', '78', '4-3 编辑课程功能实现', '3', '0', '1', '37fb666a4dd24e2fbd796c43faae6b20', '1708.64', '0', '', '136076229', '1', null, 'cde060f3f417c84046829d7782be0152', '2021-02-06 13:20:24', '1', '2021-02-06 13:21:12', '1', null, '0');
INSERT INTO `edu_video` VALUES ('674', '48', '79', '5-2 获取学生列表页面功能实现', '2', '0', '1', 'acba5b801dc64e91b8c2613596eeb8dc', '374.027', '0', '', '30666064', '1', null, 'c991cf27ebc1db89ce3eeb41c79501cc', '2021-02-06 13:23:45', '1', '2021-02-06 13:28:26', '1', null, '0');
INSERT INTO `edu_video` VALUES ('675', '48', '79', '5-4 新增学生页面功能实现', '4', '0', '1', 'a7d31ea73f9746b7ba4d910d16f04fd4', '447.565', '0', '', '35396417', '1', null, '371e4042514182e39e78f63c31de338e', '2021-02-06 13:24:08', '1', '2021-02-06 13:28:30', '1', null, '0');
INSERT INTO `edu_video` VALUES ('676', '48', '79', '5-6 编辑学生信息页面功能实现（上）', '6', '0', '1', 'd00b7b4fab3d46d3bf59b13243dafc5f', '722.558', '0', '', '55604091', '1', null, '76d60eee05955cef3431579bd1ed297a', '2021-02-06 13:25:24', '1', '2021-02-06 13:28:35', '1', null, '0');
INSERT INTO `edu_video` VALUES ('677', '48', '79', '5-5 编辑学生信息功能实现', '5', '0', '1', '87b02cbe2dfe456982faf44b0f4e8d74', '899.03', '0', '', '62857827', '1', null, '6d0a9815cf70e810752a809fc83c061b', '2021-02-06 13:25:40', '1', '2021-02-06 13:28:39', '1', null, '0');
INSERT INTO `edu_video` VALUES ('678', '48', '79', '5-3 新增学生功能实现', '3', '0', '1', '2ad885d3ac254cadb8304a274fd545f2', '809.564', '0', '', '64136199', '1', null, '282abb0bc54a9a6edee703356c12f013', '2021-02-06 13:25:55', '1', '2021-02-06 13:28:43', '1', null, '0');
INSERT INTO `edu_video` VALUES ('679', '48', '79', '5-7 编辑学生信息页面功能实现（下）', '7', '0', '1', '2cb6d3c8c0ae4f34b2d84d8b53f61f29', '553.541', '0', '', '36259838', '1', null, '468fb5d5f1173c524c0237ed7a7ed805', '2021-02-06 13:26:01', '1', '2021-02-06 13:28:48', '1', null, '0');
INSERT INTO `edu_video` VALUES ('680', '48', '79', '5-1 获取学生列表功能实现', '1', '0', '1', 'f8b485434e424f5fbda08f049e1ba24d', '1065.03', '0', '', '81575608', '1', null, 'c1e967c974328097f4bf237af8adde20', '2021-02-06 13:26:56', '1', '2021-02-06 13:29:00', '1', null, '0');
INSERT INTO `edu_video` VALUES ('681', '48', '79', '5-8 删除学生信息功能实现', '8', '0', '1', 'ad388340bef6475db58296e5b6c50705', '884.03', '0', '', '60655767', '1', null, 'c32fb35ea792ad2ba24d11194dab457a', '2021-02-06 13:28:05', '1', '2021-02-06 13:28:57', '1', null, '0');
INSERT INTO `edu_video` VALUES ('682', '48', '80', '6-3 退出登录功能实现', '3', '0', '1', 'b44cb8498b3a4f58917c9476c15bf959', '252.563', '0', '', '19616815', '1', null, '44316228ce553496d52ad4caa244fc99', '2021-02-06 13:31:07', '1', '2021-02-06 13:37:43', '1', null, '0');
INSERT INTO `edu_video` VALUES ('683', '48', '80', '6-5 获取所有课程页面功能实现', '5', '0', '1', '041dc29a94d6451bb521be91af956c46', '317.533', '0', '', '26231753', '1', null, '7214a9ac5463527747d078b899381126', '2021-02-06 13:31:33', '1', '2021-02-06 13:37:48', '1', null, '0');
INSERT INTO `edu_video` VALUES ('684', '48', '80', '6-4 获取所有课程功能实现', '4', '0', '1', 'e518c6b7bf2a43c29a2c6a17db95c4d7', '951.809', '0', '', '70337348', '1', null, '6004772a028d0ff3889e327b8ac70e06', '2021-02-06 13:33:36', '1', '2021-02-06 13:37:52', '1', null, '0');
INSERT INTO `edu_video` VALUES ('685', '48', '80', '6-1 前端首页功能实现', '1', '0', '1', 'ff55a2a8906a46b89c39f8b85831dcff', '1424.06', '0', '', '108682469', '1', null, 'b8e3cb177fe3b7a98bc024d551c8f473', '2021-02-06 13:36:27', '1', '2021-02-06 13:37:54', '1', null, '0');
INSERT INTO `edu_video` VALUES ('686', '48', '80', '6-2 学生登录功能实现', '2', '0', '1', 'beaa97b100344df2a6a2e5da56d0397a', '1496.53', '0', '', '114964814', '1', null, '53f1ce91bb6441b06526343df133085d', '2021-02-06 13:37:31', '1', '2021-02-06 13:37:58', '1', null, '0');
INSERT INTO `edu_video` VALUES ('687', '48', '80', '6-8 查看课程详情页面功能实现', '8', '0', '1', '91bb3b39cc90416bb80c4cbe01d04b73', '289.53', '0', '', '22491786', '1', null, 'b64a5e657da1b36005ef13269484d235', '2021-02-06 13:39:46', '1', '2021-02-06 13:48:14', '1', null, '0');
INSERT INTO `edu_video` VALUES ('688', '48', '80', '6-6 自定义分页标签功能实现', '6', '0', '1', 'bb66551e693c474887cc9e6346d11deb', '256.023', '0', '', '25634801', '1', null, '4568a88b7b8a836315f492740f24e97b', '2021-02-06 13:39:58', '1', '2021-02-06 13:48:19', '1', null, '0');
INSERT INTO `edu_video` VALUES ('689', '48', '80', '6-7 查看课程详情功能实现', '7', '0', '1', '8bee052b0592498e8c7272fa96764679', '327.03', '0', '', '22831524', '1', null, '04eaeda7cedba2876ca737e9fab62ed8', '2021-02-06 13:40:01', '1', '2021-02-06 13:48:24', '1', null, '0');
INSERT INTO `edu_video` VALUES ('690', '48', '80', '6-11 查看已选名单页面功能实现', '11', '0', '1', '2065dd7fea434b41a86029e7ffccd7c3', '364.507', '0', '', '31475929', '1', null, 'cd30bfdb37765006699554ba1b5e96cd', '2021-02-06 13:40:36', '1', '2021-02-06 13:48:28', '1', null, '0');
INSERT INTO `edu_video` VALUES ('691', '48', '80', '6-13 我的课程页面功能实现', '13', '0', '1', 'b394f236595e4275af27660439b8b6b0', '257.533', '0', '', '22015029', '1', null, 'e30370a7fad34092d98cd99fb057ea24', '2021-02-06 13:41:28', '1', '2021-02-06 13:48:32', '1', null, '0');
INSERT INTO `edu_video` VALUES ('692', '48', '80', '6-12 我的课程功能实现', '12', '0', '1', '9fc9ffed8fbd438596d3d856b9c56b59', '778.96', '0', '', '63361328', '1', null, '6dc89e6791f4a9ddd41cde66e4638221', '2021-02-06 13:43:51', '1', '2021-02-06 13:48:38', '1', null, '0');
INSERT INTO `edu_video` VALUES ('693', '48', '80', '6-10 查看已选名单功能实现', '10', '0', '1', '8a850e9959c8413d8bc9e45d1b0ca00d', '1215.56', '0', '', '89693765', '1', null, 'a22dbd28c18cc1be256f671e3ead63e7', '2021-02-06 13:43:56', '1', '2021-02-06 13:48:42', '1', null, '0');
INSERT INTO `edu_video` VALUES ('694', '48', '80', '6-14 删除我的课程功能实现', '14', '0', '1', '7e8e4e826ebc476d812557253e8cc624', '971.569', '0', '', '77870355', '1', null, '7f4752f97006d6c5e6f324396423d1fd', '2021-02-06 13:44:36', '1', '2021-02-06 13:48:46', '1', null, '0');
INSERT INTO `edu_video` VALUES ('695', '48', '80', '6-9 学生选课功能实现', '9', '0', '1', '2cd70ee9960849b09e9651f6e30b52ae', '2281.94', '0', '', '164936185', '1', null, '43492bf557a00d83a024bd83bc76cc98', '2021-02-06 13:47:40', '1', '2021-02-06 13:48:51', '1', null, '0');
INSERT INTO `edu_video` VALUES ('696', '48', '81', '7-2 选课列表页面功能实现', '2', '0', '1', '484ab03d230642369144f3f95a83fe66', '283.028', '0', '', '24692050', '1', null, 'ae407ea74d7be081c4dc30245280bb60', '2021-02-06 13:50:55', '1', '2021-02-06 15:27:43', '1', null, '0');
INSERT INTO `edu_video` VALUES ('697', '48', '81', '7-1 获取选课列表功能实现', '1', '0', '1', 'f83428721125469f987a5d6398ebbe29', '959.565', '0', '', '71895452', '1', null, 'a40cd0b3ba308b3a09183ad057174b5f', '2021-02-06 13:54:08', '1', '2021-02-06 15:27:39', '1', null, '0');
INSERT INTO `edu_video` VALUES ('698', '48', '81', '7-3 删除选课记录功能实现', '3', '0', '1', '8b3d1c8f1ab44261bad21dbe0e01d32b', '1166.52', '0', '', '87574300', '1', null, '65f5cac7095276cfb0132d801a99783e', '2021-02-06 13:54:43', '1', '2021-02-06 15:27:47', '1', null, '0');
INSERT INTO `edu_video` VALUES ('699', '48', '82', '8-1 选课统计功能实现', '1', '0', '1', '09b2ca49a78a47ada9b91166c56cbfb4', '552.031', '0', '', '50131504', '1', null, '1cebc9dc8d8df1ff00172b7f1c5e29b8', '2021-02-06 15:31:17', '1', '2021-02-06 15:34:46', '1', null, '0');
INSERT INTO `edu_video` VALUES ('700', '48', '82', '8-2 选课统计页面功能实现', '2', '0', '1', '2f91dc83f22b4ad29c4d07b218e000bf', '885.029', '0', '', '67570971', '1', null, '9ff405583d26b0c56486884b5db07955', '2021-02-06 15:32:18', '1', '2021-02-06 15:34:51', '1', null, '0');
INSERT INTO `edu_video` VALUES ('701', '49', '83', '1-4 把数据库脚本导入本地mysql', '4', '0', '0', 'c654c4eadbf14065b601eae6b51d1573', '106.533', '0', '', '5705801', '1', null, 'e8dfb98e46897a935d601bf2da098061', '2021-02-06 15:36:31', '1', '2021-02-06 15:39:47', '1', null, '0');
INSERT INTO `edu_video` VALUES ('702', '49', '83', '1-5 部署及运行后端项目', '5', '0', '0', 'f8757023b348432495ef3115d9c7ec33', '68.0577', '0', '', '6953643', '1', null, 'a01f87c4722261ea98dcd7ff71807b7f', '2021-02-06 15:36:36', '1', '2021-02-06 15:39:52', '1', null, '0');
INSERT INTO `edu_video` VALUES ('703', '49', '83', '1-1 课程介绍', '1', '1', '0', '97f6745b7cef41b590459fe557216604', '180.558', '0', '', '10705009', '1', null, '8040d7e5c103160eccd780be559ee687', '2021-02-06 15:36:41', '1', '2021-02-09 13:55:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('704', '49', '83', '1-6 把前台源码导入到WebStorm', '6', '0', '0', 'fd43bf5cd5eb4e37bc92598c5050a208', '110.063', '0', '', '9286049', '1', null, '2b2c08fe319ed1940a3e3016de6914f7', '2021-02-06 15:36:42', '1', '2021-02-06 15:39:56', '1', null, '0');
INSERT INTO `edu_video` VALUES ('705', '49', '83', '1-3 把源码导入到IntelliJ IDEA', '3', '0', '0', 'e69c4adf5cd9478c9816cdb1ea5a6f55', '207.029', '0', '', '13436277', '1', null, '770e0bfed586a6d5989ed92c00b7d1a3', '2021-02-06 15:36:56', '1', '2021-02-06 15:39:41', '1', null, '0');
INSERT INTO `edu_video` VALUES ('706', '49', '83', '1-2 准备工作', '2', '0', '0', '3e97337923bb48adaa135a75c36e07bb', '240.559', '0', '', '16305786', '1', null, '53ea62e7b767ede9f21c8812372a0212', '2021-02-06 15:37:07', '1', '2021-02-06 15:39:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('707', '49', '83', '1-7 系统功能展示', '7', '0', '0', 'a94ff0d2e6234d94ac6ec5b3c39b7253', '559.531', '0', '', '37302333', '1', null, '97f5c21501fb364674308898cdc0f624', '2021-02-06 15:38:49', '1', '2021-02-06 15:39:28', '1', null, '0');
INSERT INTO `edu_video` VALUES ('708', '49', '84', '2-4 编写日志实体类', '4', '0', '1', '092512f38e5c4a01943cf253e03b2b71', '399.058', '0', '', '25011374', '1', null, '2cfcc6e249c64670462d9958404f11f8', '2021-02-06 15:41:56', '1', '2021-02-06 15:48:05', '1', null, '0');
INSERT INTO `edu_video` VALUES ('709', '49', '84', '2-6 编写角色和用户实体类', '6', '0', '1', '2edcddf65b444082af6906602b796af7', '397.526', '0', '', '26379440', '1', null, 'c1f2080d077d2997733e6067a7da97ac', '2021-02-06 15:42:16', '1', '2021-02-06 15:48:11', '1', null, '0');
INSERT INTO `edu_video` VALUES ('710', '49', '84', '2-2 编写基础类', '2', '0', '1', '45953e28b173460d8ca9f0922c8b2671', '658.007', '0', '', '40599177', '1', null, '382d2eba13a5facb36648b549bc3cd2c', '2021-02-06 15:42:54', '1', '2021-02-06 15:48:15', '1', null, '0');
INSERT INTO `edu_video` VALUES ('711', '49', '84', '2-5 编写菜单实体类', '5', '0', '1', 'acb9898a128e4ca9872fd56efd4b5fef', '641.567', '0', '', '39905355', '1', null, '851371a0408c859e7dab8df8f0e641be', '2021-02-06 15:43:02', '1', '2021-02-06 15:48:20', '1', null, '0');
INSERT INTO `edu_video` VALUES ('712', '49', '84', '2-3 统一异常处理', '3', '0', '1', 'ec8e7be3f2bb49a8ad443d086864e98b', '659.679', '0', '', '43464306', '1', null, '18dd8b255080d1d44740b421bd9aa3a0', '2021-02-06 15:43:03', '1', '2021-02-06 15:48:25', '1', null, '0');
INSERT INTO `edu_video` VALUES ('713', '49', '84', '2-7 编写辅助类', '7', '0', '1', '8094217d80cc4537836458ec3429c12e', '467.557', '0', '', '33542860', '1', null, '11a3d2e5b07723edf64d668846203cf9', '2021-02-06 15:43:58', '1', '2021-02-06 15:48:30', '1', null, '0');
INSERT INTO `edu_video` VALUES ('714', '49', '84', '2-1 新建一个maven工程', '1', '0', '1', '00b2bbb1623f4439ab14c151445cf4e0', '1104.5', '0', '', '80279657', '1', null, '54ba8a3c908a410d6c92dcbc6ea514cf', '2021-02-06 15:45:54', '1', '2021-02-06 15:48:42', '1', null, '0');
INSERT INTO `edu_video` VALUES ('715', '49', '84', '2-8 编写工具类', '8', '0', '1', '0bf44cab3ff846449c638e13b352dcd6', '1141.03', '0', '', '83204969', '1', null, 'b6fb2eef81610fd442316044069f19a0', '2021-02-06 15:47:34', '1', '2021-02-06 15:48:38', '1', null, '0');
INSERT INTO `edu_video` VALUES ('716', '49', '85', '3-3 修改首页顶部菜单', '3', '0', '1', 'd8900b6bf5044f9981fff25b1d328a8f', '78.0655', '0', '', '6870539', '1', null, '54742fdd6bfd0383026cc4285c60a86f', '2021-02-06 15:49:34', '1', '2021-02-06 15:52:00', '1', null, '0');
INSERT INTO `edu_video` VALUES ('717', '49', '85', '3-4修改欢迎页面', '4', '0', '1', '1cf78f91cc0143b88d8c90f9a77eed90', '114.567', '0', '', '9068636', '1', null, '22e98322a6696396723fce9973f67776', '2021-02-06 15:49:42', '1', '2021-02-06 15:52:04', '1', null, '0');
INSERT INTO `edu_video` VALUES ('718', '49', '85', '3-2 完善前端项目', '2', '0', '1', 'bd432e2b396948aea1ef58925bd403f8', '216.062', '0', '', '18081723', '1', null, '9365b1891b2c9c45ccc5765d72d14575', '2021-02-06 15:50:10', '1', '2021-02-06 15:52:08', '1', null, '0');
INSERT INTO `edu_video` VALUES ('719', '49', '85', '3-1 使用webstorm工具创建一个项目', '1', '0', '1', 'f3d8084810d84252a4832f8c0c6f1120', '435.026', '0', '', '40248465', '1', null, '6e0dcf3c5e6815b89d03add32bc323d5', '2021-02-06 15:51:31', '1', '2021-02-06 15:52:10', '1', null, '0');
INSERT INTO `edu_video` VALUES ('720', '49', '86', '4-3 配置MybatisPlus', '3', '0', '1', '165c1d29453d471ba79c0db72044450b', '231.062', '0', '', '14809832', '1', null, 'd94d9cebe3318ddacacbec5efeb339ee', '2021-02-06 15:53:26', '1', '2021-02-06 16:16:58', '1', null, '0');
INSERT INTO `edu_video` VALUES ('721', '49', '86', '4-5 自定义mybatisplus填充公共字段', '5', '0', '1', 'b95469ee61944f81894de841aa2939a8', '226.07', '0', '', '18100832', '1', null, 'c66d032641c4807954afb72edc55727e', '2021-02-06 15:53:46', '1', '2021-02-06 16:17:03', '1', null, '0');
INSERT INTO `edu_video` VALUES ('722', '49', '86', '4-4 配置springMVC', '4', '0', '1', 'df10cbc504614f5e9e17435ea74ac8f1', '570.027', '0', '', '48696726', '1', null, 'a71e89c2d4990849225105b44a7ad371', '2021-02-06 15:55:31', '1', '2021-02-06 16:17:08', '1', null, '0');
INSERT INTO `edu_video` VALUES ('723', '49', '86', '4-1 整合redis', '1', '0', '1', '1241de4dd63543c189b015e31b724f14', '918.024', '0', '', '66852960', '1', null, 'a13dc7243c6f89f39ff58972070cc36e', '2021-02-06 15:56:31', '1', '2021-02-06 16:17:13', '1', null, '0');
INSERT INTO `edu_video` VALUES ('724', '49', '86', '4-2 整合shiro', '2', '0', '1', '3d77b334d4684d1f96da218259a0f36b', '2154.67', '0', '', '175376597', '1', null, '1ca382dadbae9b21d365a68a21b7cb52', '2021-02-06 16:04:05', '1', '2021-02-06 16:17:16', '1', null, '0');
INSERT INTO `edu_video` VALUES ('725', '49', '87', '5-4 实现验证码语音提示（二）', '4', '0', '1', '6c47fa264ee94908bc916694b3ca0bba', '164.49', '0', '', '17767326', '1', null, '768cec813e0e6c7e3236ac86a3c640f1', '2021-02-06 16:18:53', '1', '2021-02-06 16:43:43', '1', null, '0');
INSERT INTO `edu_video` VALUES ('726', '49', '87', '5-2 验证码功能实现（二）', '2', '0', '1', '1e2f12b5a18541eda156a3d80da0dbfe', '453.068', '0', '', '48892995', '1', null, '5912f68e6e86abde875c3099942b5e57', '2021-02-06 16:21:09', '1', '2021-02-06 16:43:47', '1', null, '0');
INSERT INTO `edu_video` VALUES ('727', '49', '87', '5-6 通过账号和密码登录系统前台功能实现', '6', '0', '1', '83766c24c2ac432887d887c327e7ffa3', '617.024', '0', '', '53857869', '1', null, '9b3cf683ca384123139d4e39e4d178e5', '2021-02-06 16:21:17', '1', '2021-02-06 16:43:52', '1', null, '0');
INSERT INTO `edu_video` VALUES ('728', '49', '87', '5-7 通过账号和密码登录系统语音提示功能实现', '7', '0', '1', 'd6a3385ee99648888507abfe7601d576', '562.062', '0', '', '49607862', '1', null, '8e24bd9c1971ec83cd6b89e584a43fc4', '2021-02-06 16:22:02', '1', '2021-02-06 16:43:57', '1', null, '0');
INSERT INTO `edu_video` VALUES ('729', '49', '87', '5-5 通过账号和密码登录系统后台功能实现', '5', '0', '1', 'edd5d38a1309460780d9707fe51ba697', '1320.57', '0', '', '101739804', '1', null, 'f01ee19cce4bbe4e8cd05f932558902a', '2021-02-06 16:24:10', '1', '2021-02-06 16:44:01', '1', null, '0');
INSERT INTO `edu_video` VALUES ('730', '49', '87', '5-8 退出系统功能实现', '8', '0', '1', 'cb8b90876bb34ec9a23ef521d2490355', '612.032', '0', '', '47833620', '1', null, '91e6fcf42dabcd42dd0cf87e20e4eb90', '2021-02-06 16:24:13', '1', '2021-02-06 16:44:06', '1', null, '0');
INSERT INTO `edu_video` VALUES ('731', '49', '87', '5-3 实现验证码语音提示（一）', '3', '0', '1', 'd95ccb82d40943ae9c49d10cd991c019', '1880.91', '0', '', '164926568', '1', null, 'b69756f39a27a15377504d9aafa16b6e', '2021-02-06 16:28:10', '1', '2021-02-06 16:44:10', '1', null, '0');
INSERT INTO `edu_video` VALUES ('732', '49', '87', '5-1 验证码功能实现（一）', '1', '0', '1', '73c181d322a3436090219e809dbd9025', '2029.56', '0', '', '168864755', '1', null, 'c24ee4d88705b846af03cb7dc87689b1', '2021-02-06 16:28:38', '1', '2021-02-06 16:44:13', '1', null, '0');
INSERT INTO `edu_video` VALUES ('733', '49', '88', '6-5 删除菜单功能实现', '5', '0', '1', 'bfbd805faa3647aabc6c05d6bb9a3e0b', '231.526', '0', '', '16105190', '1', null, 'fac0f03cd3e97597890101fee1b39c98', '2021-02-06 16:45:35', '1', '2021-02-06 16:52:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('734', '49', '88', '6-2 获取菜单列表功能实现', '2', '0', '1', '6b315fe9a6aa4987898f536299e6811b', '437.51', '0', '', '31762552', '1', null, '59654cb1647a6518cd062e8ba822f420', '2021-02-06 16:46:44', '1', '2021-02-06 16:52:42', '1', null, '0');
INSERT INTO `edu_video` VALUES ('735', '49', '88', '6-4 编辑菜单功能实现', '4', '0', '1', 'e28141103301491e832de52d6d75528c', '524.028', '0', '', '39633511', '1', null, '339818c9e2cd41cca9901ab11cb09dc9', '2021-02-06 16:47:08', '1', '2021-02-06 16:52:48', '1', null, '0');
INSERT INTO `edu_video` VALUES ('736', '49', '88', '6-3 新增菜单功能实现', '3', '0', '1', '8fcc960aaa444ae5bde4b476e19d38d5', '1100.53', '0', '', '78532902', '1', null, '27810472876b84cfe30861fae102b9a5', '2021-02-06 16:49:30', '1', '2021-02-06 16:52:52', '1', null, '0');
INSERT INTO `edu_video` VALUES ('737', '49', '88', '6-1 获取左边菜单功能实现', '1', '0', '1', '30cb6ad140db4136acc47b61c3de9721', '1591.57', '0', '', '110302597', '1', null, '9cb89e6d278213a4eec9ef2af2165a92', '2021-02-06 16:51:26', '1', '2021-02-06 16:52:55', '1', null, '0');
INSERT INTO `edu_video` VALUES ('738', '49', '89', '7-6 删除菜单功能实现', '6', '0', '1', '4fd4b1065bed43458536f49cafcc673f', '363.532', '0', '', '22233543', '1', null, 'c8818c1758dc7830d415377a1c2a8949', '2021-02-06 16:54:40', '1', '2021-02-06 17:08:57', '1', null, '0');
INSERT INTO `edu_video` VALUES ('739', '49', '89', '7-5 前端编辑菜单功能实现', '5', '0', '1', 'b426ea0212814b149a0738c00b18d683', '543.997', '0', '', '36532179', '1', null, '62ba66dc9c8b28bc4ae8b53346122008', '2021-02-06 16:55:38', '1', '2021-02-06 17:09:02', '1', null, '0');
INSERT INTO `edu_video` VALUES ('740', '49', '89', '7-4 添加子菜单功能实现', '4', '0', '1', '8586a0ebb4dc4b32982b0389ab999e0c', '1298.07', '0', '', '81853399', '1', null, '14bc9a9a66d4cedd62274c445298765c', '2021-02-06 16:58:16', '1', '2021-02-06 17:09:06', '1', null, '0');
INSERT INTO `edu_video` VALUES ('741', '49', '89', '7-3 添加父级菜单功能实现', '3', '0', '1', '0bbcdd179b894560832ce9bf5ebb1b57', '1468.57', '0', '', '98935078', '1', null, '1e7e454b94efb87354a968cf51686342', '2021-02-06 16:59:35', '1', '2021-02-06 17:09:11', '1', null, '0');
INSERT INTO `edu_video` VALUES ('742', '49', '89', '7-1 前端左边菜单功能实现', '1', '0', '1', 'cc6dc8307e1b42c991205975f722bf1e', '1496.06', '0', '', '106802270', '1', null, '9340f7f7b05e42443bbd93c4dc6a60af', '2021-02-06 17:00:09', '1', '2021-02-06 17:09:14', '1', null, '0');
INSERT INTO `edu_video` VALUES ('743', '49', '89', '7-2 前端菜单列表功能实现', '2', '0', '1', '6de110abdb7f4830b5fa6001bfce2a8b', '1740.57', '0', '', '116165179', '1', null, 'eff42e25c76926ef620cd8955e08d022', '2021-02-06 17:00:28', '1', '2021-02-06 17:09:17', '1', null, '0');
INSERT INTO `edu_video` VALUES ('744', '49', '90', '8-5批量删除角色功能实现', '5', '0', '1', '0920e25a4d4f499abf42c596f0c400f9', '264.499', '0', '', '20307349', '1', null, '2a7c2892ce3096eba6f452b868310a56', '2021-02-06 17:10:55', '1', '2021-02-06 17:18:14', '1', null, '0');
INSERT INTO `edu_video` VALUES ('745', '49', '90', '8-4删除角色功能实现', '4', '0', '1', '586eb398e37a4776933f74d8a988dbab', '982.065', '0', '', '76297069', '1', null, '7112f961d7ab18c8921ae8e3503c7f68', '2021-02-06 17:14:44', '1', '2021-02-06 17:18:18', '1', null, '0');
INSERT INTO `edu_video` VALUES ('746', '49', '90', '8-2添加角色功能实现', '2', '0', '1', '0826f5f985f548338e9ca48513b98c20', '1223.53', '0', '', '92071566', '1', null, '49eea32cae6d66bcfdcb5c2c13efc627', '2021-02-06 17:15:31', '1', '2021-02-06 17:18:21', '1', null, '0');
INSERT INTO `edu_video` VALUES ('747', '49', '90', '8-3 编辑角色功能实现', '3', '0', '1', '56e5909c28c8465a9934f2b172ed7d78', '1203.98', '0', '', '91007616', '1', null, '429c6c7896c71c2b3e6aa83641784812', '2021-02-06 17:15:56', '1', '2021-02-06 17:18:26', '1', null, '0');
INSERT INTO `edu_video` VALUES ('748', '49', '90', '8-1 角色列表功能实现', '1', '0', '1', '9c5f2adcd6484d22b62a6c70e34f8221', '1477.07', '0', '', '114350021', '1', null, '0eef2fd8b8ea31707db3ee2e1f3b71f8', '2021-02-06 17:17:05', '1', '2021-02-06 17:18:29', '1', null, '0');
INSERT INTO `edu_video` VALUES ('749', '49', '91', '9-6 前端批量删除角色功能实现', '6', '0', '1', 'e27aa1988e294527976a80169b18d73f', '422.557', '0', '', '24259010', '1', null, 'ecc1f0107821fb18d5dd8a60ac623463', '2021-02-06 17:20:14', '1', '2021-02-06 17:26:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('750', '49', '91', '9-5 前端删除角色功能实现', '5', '0', '1', '90e3ac95fa0f416ba9ffe691d3d8df44', '494.562', '0', '', '38737557', '1', null, '4c45120737b4b32d97cdcfeeb95070fa', '2021-02-06 17:21:37', '1', '2021-02-06 17:26:44', '1', null, '0');
INSERT INTO `edu_video` VALUES ('751', '49', '91', '9-1 前端角色列表功能实现', '1', '0', '1', '31e91c125d984344a288784671e8e610', '910.524', '0', '', '53043376', '1', null, '637da721ff8a270652a06634575993f2', '2021-02-06 17:22:22', '1', '2021-02-06 17:27:01', '1', null, '0');
INSERT INTO `edu_video` VALUES ('752', '49', '91', '9-3 前端添加角色功能实现（二）', '3', '0', '1', '04f18c4e76b9444fb5da2cbf4a37455d', '900.029', '0', '', '69928154', '1', null, '3eef9bfa993aa5061024ab880e0672b8', '2021-02-06 17:23:45', '1', '2021-02-06 17:26:50', '1', null, '0');
INSERT INTO `edu_video` VALUES ('753', '49', '91', '9-2 前端添加角色功能实现（一）', '2', '0', '1', '5b4d49da277848248cd2e08368f890d9', '1554.53', '0', '', '93574116', '1', null, '17b0d9a95423af62d40ddc5a598f1251', '2021-02-06 17:24:03', '1', '2021-02-06 17:26:54', '1', null, '0');
INSERT INTO `edu_video` VALUES ('754', '49', '91', '9-4 前端编辑角色功能实现', '4', '0', '1', 'eff5202ce4cc4f09a5f471df978eafd1', '1582.07', '0', '', '109479661', '1', null, 'c21e2c78fc1915a9eba38580eb64ab50', '2021-02-06 17:26:24', '1', '2021-02-06 17:26:59', '1', null, '0');
INSERT INTO `edu_video` VALUES ('755', '49', '92', '10-5 批量删除用户功能实现', '5', '0', '1', '71340499a80c4878b39c16bd89be9968', '236.565', '0', '', '17398424', '1', null, '94bcdf6353b5fc075710c5c6c617e35b', '2021-02-06 17:28:39', '1', '2021-02-06 17:33:56', '1', null, '0');
INSERT INTO `edu_video` VALUES ('756', '49', '92', '10-4删除用户功能实现', '4', '0', '1', 'd067a38168794d8193f4dd5c3b1ffc2c', '356.96', '0', '', '26854440', '1', null, '4d255e24d3fc6eb67fe1050ba1e99dd4', '2021-02-06 17:29:05', '1', '2021-02-06 17:34:04', '1', null, '0');
INSERT INTO `edu_video` VALUES ('757', '49', '92', '10-8 清理用户缓存功能实现', '8', '0', '1', '6b003dc2850046c0b95d60b5ad30f1cd', '164.908', '0', '', '10429117', '1', null, '669b015ac1e102d2a9917f66b269fe54', '2021-02-06 17:29:50', '1', '2021-02-06 17:34:12', '1', null, '0');
INSERT INTO `edu_video` VALUES ('758', '49', '92', '10-6 修改用户密码功能实现', '6', '0', '1', '66a0b1510724494cbf4f37b94417438f', '603.905', '0', '', '41337857', '1', null, 'e6c75f74a6514bb3c8d8d57f343f5f02', '2021-02-06 17:30:12', '1', '2021-02-06 17:34:19', '1', null, '0');
INSERT INTO `edu_video` VALUES ('759', '49', '92', '10-1 获取用户列表功能实现', '1', '0', '1', 'ba45507bac9841149d3dd95d09cfae20', '564.059', '0', '', '44765033', '1', null, '7a5ab99305dc6619c4b82318d1e9ee2a', '2021-02-06 17:30:23', '1', '2021-02-06 17:34:59', '1', null, '0');
INSERT INTO `edu_video` VALUES ('760', '49', '92', '10-7 修改用户个人信息功能实现', '7', '0', '1', '3504c598d23e455196eea08803962c6f', '421.558', '0', '', '29249976', '1', null, '27b87d1ed4069b635f8ce3488eed251c', '2021-02-06 17:30:29', '1', '2021-02-06 17:34:32', '1', null, '0');
INSERT INTO `edu_video` VALUES ('761', '49', '92', '10-3编辑用户功能实现', '3', '0', '1', '7f3c37a24d5d4710b6a96d5b40b8267b', '709.532', '0', '', '54810823', '1', null, '3693119963a5f09639a33387a2ae1e0d', '2021-02-06 17:30:29', '1', '2021-02-06 17:34:47', '1', null, '0');
INSERT INTO `edu_video` VALUES ('762', '49', '92', '10-2新增用户功能实现', '2', '0', '1', 'f3a42d6143f141999d6d6647ccbb6e5d', '1313.07', '0', '', '99038672', '1', null, 'd2ad016e2bd37be36300c8d5b66c2ece', '2021-02-06 17:33:26', '1', '2021-02-06 17:34:56', '1', null, '0');
INSERT INTO `edu_video` VALUES ('763', '49', '93', '11-5前端批量删除用户功能实现', '5', '0', '1', 'a1df1f6b41494587be8d5c99ab7b95dd', '156.526', '0', '', '9465101', '1', null, '90f4e3a05fabb61feea102545587e35c', '2021-02-06 17:36:20', '1', '2021-02-06 17:41:35', '1', null, '0');
INSERT INTO `edu_video` VALUES ('764', '49', '93', '11-6前端修改用户密码功能实现', '6', '0', '1', 'be0b702e7d73432a9ceb4a2806b68a22', '282.564', '0', '', '22882047', '1', null, '494e2cef8918b377c9daa4d355382ed3', '2021-02-06 17:37:08', '1', '2021-02-06 17:41:46', '1', null, '0');
INSERT INTO `edu_video` VALUES ('765', '49', '93', '11-4前端删除用户功能实现', '4', '0', '1', 'f37de36f3cec4b38b74e5ab317695f3b', '279.94', '0', '', '20976241', '1', null, '64684739fe0c952aa2b99981a4eb7c61', '2021-02-06 17:37:12', '1', '2021-02-06 17:41:55', '1', null, '0');
INSERT INTO `edu_video` VALUES ('766', '49', '93', '11-1前端用户列表功能实现', '1', '0', '1', 'b8ebd21643f8452a92e81aedd5cd21c4', '587.558', '0', '', '42325472', '1', null, '83a16f6f7ed52b715449e91cba811f5d', '2021-02-06 17:38:22', '1', '2021-02-06 17:42:01', '1', null, '0');
INSERT INTO `edu_video` VALUES ('767', '49', '93', '11-2前端添加用户功能实现', '2', '0', '1', '9d67d8241fdb4c5ba5d5b605bd676bbd', '796.026', '0', '', '55063105', '1', null, 'b2f9d89f59035514c1d09e12589725f5', '2021-02-06 17:39:04', '1', '2021-02-06 17:42:05', '1', null, '0');
INSERT INTO `edu_video` VALUES ('768', '49', '93', '11-8前端清除缓存功能实现', '8', '0', '1', '2272360897e54f72936b7040d8b415cd', '650.53', '0', '', '39425088', '1', null, '88a4394889750ca9f06c26deaf552b41', '2021-02-06 17:39:27', '1', '2021-02-06 17:40:53', '1', null, '0');
INSERT INTO `edu_video` VALUES ('769', '49', '93', '11-3 前端编辑用户功能实现', '3', '0', '1', 'a7d75497907a4e909a2a5e01f1e9bc68', '998.063', '0', '', '72889521', '1', null, 'ac058f89b901e68272b89e8dcddf95a7', '2021-02-06 17:40:27', '1', '2021-02-06 17:41:13', '1', null, '0');
INSERT INTO `edu_video` VALUES ('770', '49', '93', '11-7前端修改用户个人信息功能实现', '7', '0', '1', 'b5eacb66a51144a1a0a53643d97a2e20', '859.069', '0', '', '61282170', '1', null, '1aefa3b1bef51905035466184dcd1f51', '2021-02-06 17:40:41', '1', '2021-02-06 17:41:21', '1', null, '0');
INSERT INTO `edu_video` VALUES ('771', '49', '94', '12-3 删除日志列表功能实现', '3', '0', '1', '740c44d72bfe47caba38dfa8408a7a55', '280.358', '0', '', '21408546', '1', null, '88d280532ff9403185c1e1434c20b9ed', '2021-02-06 17:44:01', '1', '2021-02-06 17:49:56', '1', null, '0');
INSERT INTO `edu_video` VALUES ('772', '49', '94', '12-1 获取日志列表功能实现', '1', '0', '1', '3a70b261082b4cec87c93bbc0352e0e6', '1120.53', '0', '', '87599590', '1', null, 'ca725075764b0883917e465ccc965783', '2021-02-06 17:47:51', '1', '2021-02-06 17:49:58', '1', null, '0');
INSERT INTO `edu_video` VALUES ('773', '49', '94', '12-2 新增日志功能实现', '2', '0', '1', '52bb8e562bd24537991c178da65bacb0', '1587.53', '0', '', '119477167', '1', null, 'c221ac9c31344e751d0d1f9136345d3a', '2021-02-06 17:49:14', '1', '2021-02-06 17:50:10', '1', null, '0');
INSERT INTO `edu_video` VALUES ('774', '49', '95', '13-2 前端删除单条日志功能实现', '2', '0', '1', '7ff0321cfc94431f996516fc0a8e9ba8', '167.532', '0', '', '9329368', '1', null, '279bff32a6ba16c654cf8b7ace830c55', '2021-02-06 17:51:03', '1', '2021-02-06 17:55:41', '1', null, '0');
INSERT INTO `edu_video` VALUES ('775', '49', '95', '13-3 前端批量删除日志功能实现', '3', '0', '1', '16fd6a231a574cc2a6115ff8ed219103', '344.932', '0', '', '19666939', '1', null, '06461d8284ca950c555f025b14a77ff3', '2021-02-06 17:51:41', '1', '2021-02-06 17:55:46', '1', null, '0');
INSERT INTO `edu_video` VALUES ('776', '49', '95', '13-1 前端日志列表功能实现', '1', '0', '1', 'd643b640364043f29a798f3714c1b502', '911.337', '0', '', '66970842', '1', null, '7dc824d506c816bb361cb655c919fbe7', '2021-02-06 17:54:35', '1', '2021-02-06 17:55:49', '1', null, '0');
INSERT INTO `edu_video` VALUES ('777', '49', '97', '14-2 安装Vagrant', '2', '0', '1', '1ed7fb8853254f4bb4054071142d07bc', '111.525', '0', '', '7474327', '1', null, 'c5aceed60ae9b8ccf7870d9dc2c5c8ff', '2021-02-06 17:57:09', '1', '2021-02-06 18:47:40', '1', null, '0');
INSERT INTO `edu_video` VALUES ('778', '49', '97', '14-4 虚拟机网络设置', '4', '0', '1', 'd861414e008c42ce9eac2983ed20ceff', '207.029', '0', '', '16218985', '1', null, '18310fafefe35f5d49234870807dce3d', '2021-02-06 17:57:42', '1', '2021-02-06 18:47:54', '1', null, '0');
INSERT INTO `edu_video` VALUES ('779', '49', '97', '14-1 安装 VirtualBox', '1', '0', '1', '5e5a73fb58fb47999f84a4b8d2db28d7', '166.069', '0', '', '17380976', '1', null, 'c3a7b1c92143e981622f09f22cc19638', '2021-02-06 17:57:52', '1', '2021-02-06 18:47:34', '1', null, '0');
INSERT INTO `edu_video` VALUES ('780', '49', '97', '14-3 使用vagrant安装centos7', '3', '0', '1', '578a8f15c0d240e78e50d33d6fa06e5e', '256.906', '0', '', '17879482', '1', null, 'e584d521fa11d9497447ca25c0b5bb25', '2021-02-06 17:57:54', '1', '2021-02-06 18:47:46', '1', null, '0');
INSERT INTO `edu_video` VALUES ('781', '49', '97', '14-5 开启远程登陆', '5', '0', '1', '478942fbc51843b7abb979ed29225e59', '544.067', '0', '', '29505096', '1', null, '1810d0e5720cf4eb145a67c10a5e4072', '2021-02-06 17:58:22', '1', '2021-02-06 18:48:01', '1', null, '0');
INSERT INTO `edu_video` VALUES ('782', '49', '97', '14-6 安装docker', '6', '0', '1', '65e68447b5164d7393d6d22d8509868c', '471.528', '0', '', '38482901', '1', null, 'e2e13063b5032299512df9e3e8e1d417', '2021-02-06 17:58:55', '1', '2021-02-06 18:48:08', '1', null, '0');
INSERT INTO `edu_video` VALUES ('783', '49', '97', '14-7 Docker开启远程访问', '7', '0', '1', '08e90434e02749da823c899d395de334', '425.529', '0', '', '31110138', '1', null, 'dd0de8f9e9647e0f016efcf9fb6d277f', '2021-02-06 17:59:06', '1', '2021-02-06 18:48:14', '1', null, '0');
INSERT INTO `edu_video` VALUES ('784', '49', '97', '14-10 配置mysql', '10', '0', '1', '86a56d61306d4afdacd2c5187f94dd93', '241.557', '0', '', '17692323', '1', null, '8e4685b3ee476c11e9f78ee8f7e8d69a', '2021-02-06 17:59:06', '1', '2021-02-06 18:48:33', '1', null, '0');
INSERT INTO `edu_video` VALUES ('785', '49', '97', '14-11 安装redis', '11', '0', '1', '0579b607da6b476588777cb06d69ad5e', '450.56', '0', '', '32956992', '1', null, '0bfb74a456dfe107190178cc540a4c10', '2021-02-06 18:00:35', '1', '2021-02-06 18:48:40', '1', null, '0');
INSERT INTO `edu_video` VALUES ('786', '49', '97', '14-9 安装mysql5.7', '9', '0', '1', 'ee5fe67c957c4e9a97fd9d9d2242f25a', '561.528', '0', '', '56647852', '1', null, '1b94c8f5f15f6b38d4e1dc3a9f9671c3', '2021-02-06 18:01:15', '1', '2021-02-06 18:48:28', '1', null, '0');
INSERT INTO `edu_video` VALUES ('787', '49', '97', '14-13 部署前端项目', '13', '0', '1', 'd7c73e78adbe41a0b8036b5a60fec2ec', '456.527', '0', '', '38665439', '1', null, '8b45fd9c036c5afed8f89d1a5f578350', '2021-02-06 18:01:20', '1', '2021-02-06 18:48:52', '1', null, '0');
INSERT INTO `edu_video` VALUES ('788', '49', '97', '14-12 安装nginx', '12', '0', '1', '7385b039a2694542a5f743aec189a5ef', '557.302', '0', '', '38423680', '1', null, '09d971e2145cb9e0838e57ba9fc8f141', '2021-02-06 18:01:25', '1', '2021-02-06 18:48:46', '1', null, '0');
INSERT INTO `edu_video` VALUES ('789', '49', '97', '14-8 IDEA使用Docker插件', '8', '0', '1', '89139db3962742ba8c8f86ae332737e3', '633.533', '0', '', '53799223', '1', null, '60986337df3fe28a0999d085f52fc207', '2021-02-06 18:01:34', '1', '2021-02-06 18:48:21', '1', null, '0');
INSERT INTO `edu_video` VALUES ('790', '50', '98', '1-1 课程概述', '1', '2', '0', '25529a5d360d4a8c8b396fb05a4e113e', '233.593', '0', '', '14584471', '1', null, '599ae0be3affcddf9a528100f1374e6f', '2021-02-06 18:52:11', '1', '2021-02-10 12:45:30', '1', null, '0');
INSERT INTO `edu_video` VALUES ('791', '50', '99', '2-2 安装Vagrant', '2', '1', '0', 'ef4ce5c73c4f422e90b17039634a5dc0', '111.525', '0', '', '7474327', '1', null, 'b9e75dc94be2068409562ff11104a171', '2021-02-06 18:54:11', '1', '2021-02-10 12:45:34', '1', null, '0');
INSERT INTO `edu_video` VALUES ('792', '50', '99', '2-1 安装 VirtualBox', '1', '1', '0', '8ba49a5c6efa4047812986c430181fb2', '137.973', '0', '', '10153686', '1', null, '45a9557d30c429a1ce7f05794fac1a97', '2021-02-06 18:54:19', '1', '2021-02-10 12:45:32', '1', null, '0');
INSERT INTO `edu_video` VALUES ('793', '50', '99', '2-4 虚拟机网络设置', '4', '0', '1', '4e45de040f354a8bbb9b8314234d3dda', '207.029', '0', '', '16218985', '1', null, '7b1fbce2748c98d5064c535dcaf93a56', '2021-02-06 18:54:43', '1', '2021-02-06 18:58:29', '1', null, '0');
INSERT INTO `edu_video` VALUES ('794', '50', '99', '2-3 使用vagrant安装centos7', '3', '2', '0', '5e030630454147819a7ccfa2aa41289d', '256.906', '0', '', '17879482', '1', null, '288ecf44c4e3bd3d043ad2817d31b50c', '2021-02-06 18:54:43', '1', '2021-02-10 12:45:38', '1', null, '0');
INSERT INTO `edu_video` VALUES ('795', '50', '99', '2-5 开启远程登陆', '5', '0', '1', '3bc14473ca824bed9870bc91b72e455e', '544.067', '0', '', '29505096', '1', null, 'b8a86780f9ec916635d655b12ec4e068', '2021-02-06 18:55:23', '1', '2021-02-06 18:58:39', '1', null, '0');
INSERT INTO `edu_video` VALUES ('796', '50', '99', '2-8 配置mysql', '8', '0', '1', '59469b889ac24c0496dd7d6972ca9ad4', '241.557', '0', '', '17692323', '1', null, 'e21be214a76a9ce555294695048c12f1', '2021-02-06 18:55:32', '1', '2021-02-06 18:58:47', '1', null, '0');
INSERT INTO `edu_video` VALUES ('797', '50', '99', '2-6 安装docker', '6', '0', '1', 'f623b7b0e3f74d9ab29beb86072875f8', '471.528', '0', '', '38482901', '1', null, '5209c8a867b1a3b8940c084c3b7832c9', '2021-02-06 18:56:02', '1', '2021-02-06 18:58:54', '1', null, '0');
INSERT INTO `edu_video` VALUES ('798', '50', '99', '2-9 安装redis', '9', '0', '1', '1807d5ce12ca4b4580c7d7b174895684', '450.56', '0', '', '32956992', '1', null, 'f21ce5f71ccb8be1f1f1ea93c4e458fe', '2021-02-06 18:56:48', '1', '2021-02-06 18:59:02', '1', null, '0');
INSERT INTO `edu_video` VALUES ('799', '50', '99', '2-7 安装mysql5.7', '7', '0', '1', '487f0cfae8b74855a1d95a28c8a96aa5', '561.528', '0', '', '56647852', '1', null, '94b2355c592f5c5a305bf8e5e9379fad', '2021-02-06 18:57:49', '1', '2021-02-06 18:59:08', '1', null, '0');
INSERT INTO `edu_video` VALUES ('800', '50', '99', '2-10  把源码导入到IntelliJ IDEA', '10', '0', '1', 'bf9ac7bfea104e318627ab25722e0d6f', '72.5624', '0', '', '5186510', '1', null, '1e9840f7f69c9c7fff6a20c3f18be99f', '2021-02-06 19:00:28', '1', '2021-02-06 19:02:32', '1', null, '0');
INSERT INTO `edu_video` VALUES ('801', '50', '99', '2-11 把数据库脚本导入本地mysql', '11', '0', '1', 'cde79c2b19a44650a6324cc378b98db3', '104.025', '0', '', '7248662', '1', null, 'a4c38c95fc099cdf24f425c0b834a4d9', '2021-02-06 19:00:34', '1', '2021-02-06 19:02:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('802', '50', '99', '2-13 把前台源码导入到WebStorm', '13', '0', '1', 'c800a5fb2d56427b928f2b1a86f5c18b', '212.068', '0', '', '13144415', '1', null, '663c01fbce8630ae404c8818f9d14fb0', '2021-02-06 19:01:00', '1', '2021-02-06 19:02:41', '1', null, '0');
INSERT INTO `edu_video` VALUES ('803', '50', '99', '2-12 部署及运行后端项目', '12', '0', '1', '063f8e95803c4a609481e940f1756d92', '200.063', '0', '', '22131777', '1', null, 'a32aefa8a717842b015c49551ba9feda', '2021-02-06 19:01:39', '1', '2021-02-06 19:02:45', '1', null, '0');
INSERT INTO `edu_video` VALUES ('804', '50', '100', '3-5编写DTO类', '5', '0', '1', 'eeb7e1d51b83446aa3a161f9135bb351', '158.105', '0', '', '9508890', '1', null, '8d1b1cb030dec522580a4003e4521580', '2021-02-06 19:03:57', '1', '2021-02-06 19:09:24', '1', null, '0');
INSERT INTO `edu_video` VALUES ('805', '50', '100', '3-4 编写实体类', '4', '0', '1', 'f81c314b3b784832b40f01929c08cef9', '197.811', '0', '', '15495135', '1', null, 'a4199c0598d9d220ed4edb00bbf739e5', '2021-02-06 19:04:22', '1', '2021-02-06 19:09:28', '1', null, '0');
INSERT INTO `edu_video` VALUES ('806', '50', '100', '3-6 编写VO类', '6', '0', '1', '9dd5736b00994e5ba5b7a31a58c79173', '434.794', '0', '', '27065082', '1', null, '5b533020adb670c9f16c512ea73d1201', '2021-02-06 19:05:08', '1', '2021-02-06 19:09:33', '1', null, '0');
INSERT INTO `edu_video` VALUES ('807', '50', '100', '3-8 自定义注解', '8', '0', '1', 'fd6786612b5340728c745188aaba9a58', '331.209', '0', '', '22729422', '1', null, 'b501add08563cac9999ca20915b6746d', '2021-02-06 19:06:01', '1', '2021-02-06 19:09:38', '1', null, '0');
INSERT INTO `edu_video` VALUES ('808', '50', '100', '3-2 编写基础类', '2', '0', '1', '9c2ae4182c114393b974e95a6e0a2849', '767.234', '0', '', '48603074', '1', null, '32ea43a795adaa01612e24bf77311fe9', '2021-02-06 19:06:26', '1', '2021-02-06 19:09:41', '1', null, '0');
INSERT INTO `edu_video` VALUES ('809', '50', '100', '3-7 编写工具类', '7', '0', '1', '18b27b4a83d346bd94a9f858178cef18', '324.661', '0', '', '36130195', '1', null, '37834a09cc2b3aca3e37679642709cc5', '2021-02-06 19:06:33', '1', '2021-02-06 19:09:46', '1', null, '0');
INSERT INTO `edu_video` VALUES ('810', '50', '100', '3-3 统一异常处理', '3', '0', '1', '08c68020f9924b2d8ba35cfc7b657dd8', '743.294', '0', '', '57559411', '1', null, '4f3be0ceec89e35dbe26bc06449e2e3c', '2021-02-06 19:07:21', '1', '2021-02-06 19:09:52', '1', null, '0');
INSERT INTO `edu_video` VALUES ('811', '50', '100', '3-9 编写切面类', '9', '0', '1', '574ceb01c7694ed3bccde5cc307a6ada', '458.71', '0', '', '33166005', '1', null, '25740ec43a0b1caba0c2f93fe1919e64', '2021-02-06 19:07:27', '1', '2021-02-06 19:09:59', '1', null, '0');
INSERT INTO `edu_video` VALUES ('812', '50', '100', '3-1 新建一个maven工程', '1', '2', '1', '79bf29f808e84aa49011d5fd855cfaaf', '1429.75', '0', '', '86515198', '1', null, '94c97c496ac8ee87be5097b9d01f7e10', '2021-02-06 19:08:56', '1', '2021-02-10 10:27:27', '1', null, '0');
INSERT INTO `edu_video` VALUES ('813', '50', '101', '4-1 使用webstorm工具创建一个项目', '0', '2', '1', '1167f65f966b4a3f9e65f487f8e2c7ec', '229.39', '0', '', '12603213', '1', null, '56c98642bdf3c086b693d43a5cfb1ec0', '2021-02-06 19:11:32', '1', '2021-02-10 10:28:03', '1', null, '0');
INSERT INTO `edu_video` VALUES ('814', '50', '101', '4-2 完善前端项目', '0', '1', '1', '03dd9007c8f4412aae62cc90f98cc271', '292.827', '0', '', '18157760', '1', null, '514a69bccbca9dd08df142688f65591a', '2021-02-06 19:11:48', '1', '2021-02-10 10:28:12', '1', null, '0');
INSERT INTO `edu_video` VALUES ('815', '50', '102', '5-2 整合jpa', '2', '0', '1', '3cf9fa4b67724fb6a9f8e11e88852314', '91.7653', '0', '', '7358342', '1', null, 'f82acc55f17860a6d19d3c5d652e9a2d', '2021-02-06 19:14:24', '1', '2021-02-06 19:19:33', '1', null, '0');
INSERT INTO `edu_video` VALUES ('816', '50', '102', '5-8 整合logback', '8', '0', '1', '219e6b3fd5c54468a3b4243a25a6fbc0', '294.313', '0', '', '15836128', '1', null, '06f42bfac1646aeec2a3309882c8d97f', '2021-02-06 19:15:28', '1', '2021-02-06 19:19:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('817', '50', '102', '5-5 整合spring security和jwt（三）', '5', '0', '1', 'db45f479bd114038aa2050a4b6c04bcd', '327.007', '0', '', '23310177', '1', null, '77c0a1d55a4471d473be6d9ffb3d5114', '2021-02-06 19:15:31', '1', '2021-02-06 19:19:42', '1', null, '0');
INSERT INTO `edu_video` VALUES ('818', '50', '102', '5-9 整合log4jdbc', '9', '0', '1', '1d3ff26334414629901cfe56955f7e54', '196.371', '0', '', '14533488', '1', null, 'b37a4f666bd9a48f4141eb0cc8a31163', '2021-02-06 19:16:26', '1', '2021-02-06 19:19:47', '1', null, '0');
INSERT INTO `edu_video` VALUES ('819', '50', '102', '5-1 整合redis', '1', '0', '1', '36e8102bd4ee478fbc1558d0998cc235', '516.435', '0', '', '39650429', '1', null, '4b3b0458cc8bd87e41e5b4cb9ac2dfc9', '2021-02-06 19:16:28', '1', '2021-02-06 19:20:15', '1', null, '0');
INSERT INTO `edu_video` VALUES ('820', '50', '102', '5-7 跨域配置', '7', '0', '1', 'c5e38c86439c4b998eb6bafe2c32037e', '424.368', '0', '', '30622343', '1', null, 'c73b7c97550027c90d0e7de11280c94a', '2021-02-06 19:17:21', '1', '2021-02-06 19:19:54', '1', null, '0');
INSERT INTO `edu_video` VALUES ('821', '50', '102', '5-4 整合spring security和jwt（二）', '4', '0', '1', '365d9f5805ee490f9a96a7e3a919afe1', '888.303', '0', '', '66271532', '1', null, 'd86ee6e7e95f96d4a85e8afe63fe2e5b', '2021-02-06 19:17:51', '1', '2021-02-06 19:19:59', '1', null, '0');
INSERT INTO `edu_video` VALUES ('822', '50', '102', '5-3 整合spring security和jwt（一）', '3', '0', '1', '545bc21e7ebe4d9695ea3aa1030dd370', '971.941', '0', '', '67902372', '1', null, 'b507a717912571771fe344a0f0c444e6', '2021-02-06 19:18:28', '1', '2021-02-06 19:20:06', '1', null, '0');
INSERT INTO `edu_video` VALUES ('823', '50', '102', '5-6 整合spring security和jwt（四）', '6', '0', '1', 'd8b8b718a4cd4060a024508b3262e5ec', '1132.14', '0', '', '84270303', '1', null, 'c70d2ba7e9571c2ab9e6766b5145e4ea', '2021-02-06 19:19:14', '1', '2021-02-06 19:20:11', '1', null, '0');
INSERT INTO `edu_video` VALUES ('824', '50', '103', '6-3 登录页面功能实现（二）', '3', '0', '1', '2e8a20f52be94ba5a22fc35f0987223f', '307.711', '0', '', '21285168', '1', null, '8493e27f56f3d996bb342c3fafd7baa1', '2021-02-06 19:22:22', '1', '2021-02-06 19:34:51', '1', null, '0');
INSERT INTO `edu_video` VALUES ('825', '50', '103', '6-5 编写实体转换映射类', '5', '0', '1', '7664414f98cd46a6ad9779742b85f513', '601.908', '0', '', '44484274', '1', null, '5c4b2ad65559d10b6b2e9fc05b226be2', '2021-02-06 19:23:32', '1', '2021-02-06 19:34:55', '1', null, '0');
INSERT INTO `edu_video` VALUES ('826', '50', '103', '6-7 通过账号和密码登录系统功能实现（二）', '7', '0', '1', '37538433b21f41f2a1821ee568976a64', '221.96', '0', '', '19202828', '1', null, 'f8c278ff5ee7c43202c73433b3f9551b', '2021-02-06 19:23:40', '1', '2021-02-06 19:35:00', '1', null, '0');
INSERT INTO `edu_video` VALUES ('827', '50', '103', '6-1 验证码功能实现', '1', '0', '1', '7e4d4aafbae04bcfae4b6651b86fdeb5', '812.907', '0', '', '58859217', '1', null, '663eb2c6669141bd4d12b155a0047a71', '2021-02-06 19:24:50', '1', '2021-02-06 19:36:13', '1', null, '0');
INSERT INTO `edu_video` VALUES ('828', '50', '103', '6-4 自定义获取用户信息接口实现类', '4', '0', '1', '6129911099ae4a168b8eddda33d6af32', '1206.69', '0', '', '80240743', '1', null, '1f1dc83b397fcd11d8a45c5edbc4d2db', '2021-02-06 19:25:18', '1', '2021-02-06 19:35:14', '1', null, '0');
INSERT INTO `edu_video` VALUES ('829', '50', '103', '6-2 登录页面功能实现（一）', '2', '0', '1', '8328e81d85f945bfb29c3744e5696ce9', '1548.72', '0', '', '80377385', '1', null, 'be21dbad6c0c00c021557995b56467c6', '2021-02-06 19:26:17', '1', '2021-02-06 19:35:17', '1', null, '0');
INSERT INTO `edu_video` VALUES ('830', '50', '103', '6-10 获取用户信息功能实现', '10', '0', '1', '5090ec9707c64d6cb94676cddc50974b', '355.66', '0', '', '31345190', '1', null, '649dde11a363cbb0391a8776712a647b', '2021-02-06 19:26:45', '1', '2021-02-06 19:35:22', '1', null, '0');
INSERT INTO `edu_video` VALUES ('831', '50', '103', '6-6 通过账号和密码登录系统功能实现（一）', '6', '0', '1', '2bd92caff5da439d940af9aae6a60bb2', '1279.98', '0', '', '105455828', '1', null, '61f89471aff3d7fc45010533c795d461', '2021-02-06 19:27:11', '1', '2021-02-06 19:35:27', '1', null, '0');
INSERT INTO `edu_video` VALUES ('832', '50', '103', '6-13 退出系统功能实现', '13', '0', '1', 'c1e767f06ca74f75902f0ca5b37dd9fc', '223.469', '0', '', '17573193', '1', null, '6d0fbb95a13def94696857afe2ecb74b', '2021-02-06 19:27:57', '1', '2021-02-06 19:35:31', '1', null, '0');
INSERT INTO `edu_video` VALUES ('833', '50', '103', '6-11 保存在线用户信息功能实现', '11', '0', '1', '4eac10dd207b4431b8ba7e9c93843251', '614.609', '0', '', '50946946', '1', null, '0968bf4120fceb2b184423310295b123', '2021-02-06 19:28:22', '1', '2021-02-06 19:35:35', '1', null, '0');
INSERT INTO `edu_video` VALUES ('834', '50', '103', '6-8 通过账号和密码登录系统功能实现（三）', '8', '0', '1', '75975c72a7494249ad5672888f175a72', '1577.7', '0', '', '96022985', '1', null, '2d5ef87ef93cdf9381302e5897b0fafb', '2021-02-06 19:29:49', '1', '2021-02-06 19:35:40', '1', null, '0');
INSERT INTO `edu_video` VALUES ('835', '50', '103', '6-12 踢掉在线用户功能实现', '12', '0', '1', 'eb990f9c41054b069f0ab5c6aafd1ee8', '1064.03', '0', '', '83554288', '1', null, 'b04b72574eb60b401a373965cae7057d', '2021-02-06 19:31:18', '1', '2021-02-06 19:35:45', '1', null, '0');
INSERT INTO `edu_video` VALUES ('836', '50', '103', '6-9 通过账号和密码登录系统功能实现（四）', '9', '0', '1', '67405e6993534ec89c48dae0b3371db6', '1915.9', '0', '', '158824555', '1', null, 'f20e178ed65616c236fffbaafb63db8d', '2021-02-06 19:33:02', '1', '2021-02-06 19:35:50', '1', null, '0');
INSERT INTO `edu_video` VALUES ('837', '50', '104', '7-6 菜单列表页面功能实现（二）', '7', '0', '1', '455651a40dc940e4919f633ee85de0dd', '295.869', '0', '', '17677730', '1', null, '8a5b705b4ae48d2c58c9ab1fb9d083c3', '2021-02-06 19:38:15', '1', '2021-02-06 19:49:19', '1', null, '0');
INSERT INTO `edu_video` VALUES ('838', '50', '104', '7-3 左边菜单功能实现（三）', '3', '0', '1', '72788ed887654e0195911ceea7c1a2aa', '613.332', '0', '', '43711902', '1', null, '3277f5b4d5117a1362aa1d5e37926ebe', '2021-02-06 19:39:55', '1', '2021-02-06 19:49:23', '1', null, '0');
INSERT INTO `edu_video` VALUES ('839', '50', '104', '7-4 获取菜单列表功能实现', '4', '0', '1', 'b64f1646a22d41ecb41b5d1ab2c98f48', '733.936', '0', '', '55591722', '1', null, 'a587b9f39f2018c8c091ec2657ef3262', '2021-02-06 19:40:34', '1', '2021-02-06 19:49:27', '1', null, '0');
INSERT INTO `edu_video` VALUES ('840', '50', '104', '7-7 新增菜单功能实现', '7', '0', '1', 'c5e09ea3e4d3493183bbed7d2e2578ff', '917.56', '0', '', '67031931', '1', null, '19dedfadc00ebd061e77c58db7647a20', '2021-02-06 19:42:57', '1', '2021-02-06 19:49:32', '1', null, '0');
INSERT INTO `edu_video` VALUES ('841', '50', '104', '7-5 菜单列表页面功能实现（一）', '5', '0', '1', 'f1370a3fe3eb4c14a0f84e58d19b400d', '1623.45', '0', '', '89191002', '1', null, 'e0ec0ab3c4274657566682f5254d1b7a', '2021-02-06 19:43:10', '1', '2021-02-06 19:49:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('842', '50', '104', '7-11 编辑菜单页面功能实现', '11', '0', '1', '36b03e5d0f5641b6af86c305806c5653', '103.213', '0', '', '6058593', '1', null, 'c3fbb045d81a095714718538a60123c6', '2021-02-06 19:43:38', '1', '2021-02-06 19:49:41', '1', null, '0');
INSERT INTO `edu_video` VALUES ('843', '50', '104', '7-2 左边菜单功能实现（二）', '2', '0', '1', '9f6d84aca3cc43d599a885a8d3fd66e9', '1548.86', '0', '', '114488313', '1', null, '17c4c3e319b578850b603bd2408fc8db', '2021-02-06 19:44:01', '1', '2021-02-06 19:49:45', '1', null, '0');
INSERT INTO `edu_video` VALUES ('844', '50', '104', '7-1 左边菜单功能实现（一）', '1', '0', '1', '5b44bcb6737f4640977ec04b320e2b1a', '1789.72', '0', '', '134651510', '1', null, '498ec7edbc8fc3ad8bd7e3f8c7435527', '2021-02-06 19:44:54', '1', '2021-02-06 19:50:23', '1', null, '0');
INSERT INTO `edu_video` VALUES ('845', '50', '104', '7-9 新增菜单页面功能实现（二）', '9', '0', '1', 'e924abc40cb242fe99e8400a4f929d58', '1093.08', '0', '', '74216879', '1', null, '9d3b1a023f508035ed5e29e3feee7326', '2021-02-06 19:45:05', '1', '2021-02-06 19:49:59', '1', null, '0');
INSERT INTO `edu_video` VALUES ('846', '50', '104', '7-13 导出菜单数据功能实现', '13', '0', '1', 'a036bcb2cc834023b559c16d3a582d3b', '614.957', '0', '', '43768025', '1', null, '5580aaa390282e20d4b8c77a8c905063', '2021-02-06 19:46:55', '1', '2021-02-06 19:50:04', '1', null, '0');
INSERT INTO `edu_video` VALUES ('847', '50', '104', '7-8 新增菜单页面功能实现（一）', '8', '0', '1', '8800b2ef50c94398b75575adb5382b19', '1610.79', '0', '', '102826662', '1', null, '08ded9406833233424c1ac48a20d9dd9', '2021-02-06 19:47:06', '1', '2021-02-06 19:50:10', '1', null, '0');
INSERT INTO `edu_video` VALUES ('848', '50', '104', '7-10 编辑菜单功能实现', '10', '0', '1', '091e89b864664407b8b4b68c468bbe6f', '986.244', '0', '', '72841542', '1', null, 'a26962e589820c4b89123b45e6418137', '2021-02-06 19:48:04', '1', '2021-02-06 19:50:15', '1', null, '0');
INSERT INTO `edu_video` VALUES ('849', '50', '104', '7-12 删除菜单功能实现', '12', '0', '1', 'e712bcd0ed884191a56f75e34d208726', '1338.24', '0', '', '95823079', '1', null, '3022ec46d993d6a7626bc84d860a64f3', '2021-02-06 19:49:01', '1', '2021-02-06 19:50:20', '1', null, '0');
INSERT INTO `edu_video` VALUES ('850', '50', '105', '8-5 新增角色页面功能实现', '5', '0', '1', 'c3706358d528427cb5ea343b0031455a', '557.232', '0', '', '35067552', '1', null, '6f4b053444a1cd5d58bb2466cd920147', '2021-02-06 19:53:27', '1', '2021-02-06 20:01:28', '1', null, '0');
INSERT INTO `edu_video` VALUES ('851', '50', '105', '8-4 新增角色功能实现', '4', '0', '1', '402131e9faec478baaec8f9ded9e9e5d', '539.33', '0', '', '43233878', '1', null, '56adcd3c6de0afc362171ce7938346ec', '2021-02-06 19:53:54', '1', '2021-02-06 20:01:33', '1', null, '0');
INSERT INTO `edu_video` VALUES ('852', '50', '105', '8-3 获取用户级别功能实现', '3', '0', '1', '0a3d4f65af914e8f85be10fe5e8d98db', '729.826', '0', '', '55686795', '1', null, '9073a483d1816aca84d33589a741aba0', '2021-02-06 19:54:43', '1', '2021-02-06 20:01:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('853', '50', '105', '8-2 角色列表页面功能实现', '2', '0', '1', '97b72bdd7b0040b09d4baddf0de7bb76', '1153.13', '0', '', '59679572', '1', null, '472b41e3ade4cf09de48bf75c885e60f', '2021-02-06 19:55:11', '1', '2021-02-06 20:01:41', '1', null, '0');
INSERT INTO `edu_video` VALUES ('854', '50', '105', '8-1 角色列表功能实现', '1', '0', '1', '9e4d0a468fe04a8cb854cdaf46229b25', '822.567', '0', '', '64580602', '1', null, '15f5e604cdfede1a4e23cec308e75033', '2021-02-06 19:55:24', '1', '2021-02-06 20:02:21', '1', null, '0');
INSERT INTO `edu_video` VALUES ('855', '50', '105', '8-6 编辑角色功能实现', '6', '0', '1', '12facc4338d2489789c796564886e085', '870.539', '0', '', '69290121', '1', null, '6decc3129d87cb6feda367a942fce4d2', '2021-02-06 19:55:35', '1', '2021-02-06 20:01:49', '1', null, '0');
INSERT INTO `edu_video` VALUES ('856', '50', '105', '8-9 获取单个角色功能实现', '9', '0', '1', 'd4e3697bac1d476b9a64e328cac24dfa', '234.591', '0', '', '17021361', '1', null, '4bf6b8a525029703e0212f29e023a7b5', '2021-02-06 19:55:58', '1', '2021-02-06 20:01:55', '1', null, '0');
INSERT INTO `edu_video` VALUES ('857', '50', '105', '8-8 导出角色功能实现', '8', '0', '1', '60c19c151e06470ca1343bba7151cb90', '713.201', '0', '', '55379523', '1', null, '1ecb2ac47f4452a1ba2b2da2782bb3f4', '2021-02-06 19:57:22', '1', '2021-02-06 20:02:00', '1', null, '0');
INSERT INTO `edu_video` VALUES ('858', '50', '105', '8-11 获取所有角色列表功能实现', '11', '0', '1', '8814d2e69a644826886ce97f715d3542', '367.525', '0', '', '33860117', '1', null, '286660892596736298b1d87a0c2022c2', '2021-02-06 19:57:23', '1', '2021-02-06 20:02:04', '1', null, '0');
INSERT INTO `edu_video` VALUES ('859', '50', '105', '8-7 删除角色功能实现', '7', '0', '1', '45aa7c12b8614efbbcf58eca5ec597f7', '781.793', '0', '', '58733785', '1', null, '275cc05796d4f3bbb7d4a1092fd47a24', '2021-02-06 19:57:31', '1', '2021-02-06 20:02:09', '1', null, '0');
INSERT INTO `edu_video` VALUES ('860', '50', '105', '8-12 自定义权限配置功能实现', '12', '0', '1', 'ed807651341346cb938ab38b9fe7bdbb', '768.279', '0', '', '58337207', '1', null, 'b1e26f406ff4f3bdc5bd8f1296fcf4ff', '2021-02-06 19:59:11', '1', '2021-02-06 20:02:13', '1', null, '0');
INSERT INTO `edu_video` VALUES ('861', '50', '105', '8-10 给角色分配菜单权限功能实现', '10', '0', '1', '40eecc0397ab482f834a807c0636cf6e', '1779.53', '0', '', '106526013', '1', null, 'f69ec2a47962f58fd7a1c9b7bc331e2d', '2021-02-06 20:01:14', '1', '2021-02-06 20:02:18', '1', null, '0');
INSERT INTO `edu_video` VALUES ('862', '50', '106', '9-3 分页获取字典列表页面功能实现（二）', '3', '0', '1', 'f578e8cbbe0c4487b89f271663a5a612', '150.535', '0', '', '7921459', '1', null, 'ae6567607d86b61b96c95f3d56f8c1cb', '2021-02-06 20:03:32', '1', '2021-02-06 20:12:31', '1', null, '0');
INSERT INTO `edu_video` VALUES ('863', '50', '106', '9-5 新增字典页面功能实现', '5', '0', '1', '3ddb7598d3f6474b92f039c19d768797', '216.99', '0', '', '11334088', '1', null, 'a6d85aecca482532910a8eceb855572b', '2021-02-06 20:03:43', '1', '2021-02-06 20:12:41', '1', null, '0');
INSERT INTO `edu_video` VALUES ('864', '50', '106', '9-4 新增字典功能实现', '4', '0', '1', '019743629edc4efb882bc69a558ef76d', '435.606', '0', '', '30633211', '1', null, '5b95e7a13b1fb2d8a6f3a637eee7db8d', '2021-02-06 20:04:56', '1', '2021-02-06 20:12:48', '1', null, '0');
INSERT INTO `edu_video` VALUES ('865', '50', '106', '9-6 编辑字典功能实现', '6', '0', '1', '00a256cfe4ad4af2bf4f9eb08138cb9f', '612.078', '0', '', '43957856', '1', null, 'f6586075ca0546530654aaaeee088da5', '2021-02-06 20:05:59', '1', '2021-02-06 20:12:53', '1', null, '0');
INSERT INTO `edu_video` VALUES ('866', '50', '106', '9-7 删除字典功能实现', '7', '0', '1', 'f5cb10a0c8ac489db980d83bc5b59e05', '534.129', '0', '', '38404494', '1', null, '6aec97d9450b9c69551a121d7d00248b', '2021-02-06 20:06:09', '1', '2021-02-06 20:12:59', '1', null, '0');
INSERT INTO `edu_video` VALUES ('867', '50', '106', '9-1 分页获取字典列表功能实现', '1', '0', '1', '74bdfb27bdf841069162ad7564e6d952', '1088.76', '0', '', '77526191', '1', null, '45f59725800ef27b4fd93b1465336e8c', '2021-02-06 20:07:58', '1', '2021-02-06 20:13:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('868', '50', '106', '9-10 分页获取字典详情页面功能实现', '10', '0', '1', 'eda1759e39524256bd375bc3ca64ce42', '622.179', '0', '', '34551691', '1', null, '829a1a20212aa0b10cb7603a95a989d5', '2021-02-06 20:08:09', '1', '2021-02-06 20:13:06', '1', null, '0');
INSERT INTO `edu_video` VALUES ('869', '50', '106', '9-2 分页获取字典列表页面功能实现（一）', '2', '0', '1', '21363b98f73c4595ad12f9eb1405390a', '1568.04', '0', '', '86523167', '1', null, '6452cd684c7d438f6632f3f21d165e97', '2021-02-06 20:08:33', '1', '2021-02-06 20:13:10', '1', null, '0');
INSERT INTO `edu_video` VALUES ('870', '50', '106', '9-8 导出字典数据功能实现', '8', '0', '1', '02a9ff5287f34a329f636c146723fec2', '1047.03', '0', '', '76321927', '1', null, '78df41de5d36992056425bb941be04af', '2021-02-06 20:08:36', '1', '2021-02-06 20:13:15', '1', null, '0');
INSERT INTO `edu_video` VALUES ('871', '50', '106', '9-11 添加字典详情功能实现', '11', '0', '1', '2bfe8b09eb3b4e6aa22ef9d913b7a300', '744.292', '0', '', '50786010', '1', null, 'c4a330948bedf999a8fe32fe28de5fde', '2021-02-06 20:09:17', '1', '2021-02-06 20:13:19', '1', null, '0');
INSERT INTO `edu_video` VALUES ('872', '50', '106', '9-13 删除字典详情功能实现', '13', '0', '1', 'e62763b2236342778e5aec0b53b4da4d', '425.065', '0', '', '29528851', '1', null, '8855c8e51ec9660c04c7a38763b1f6a7', '2021-02-06 20:10:03', '1', '2021-02-06 20:13:24', '1', null, '0');
INSERT INTO `edu_video` VALUES ('873', '50', '106', '9-12 编辑字典详情功能实现', '12', '0', '1', '20a2b0bbe7fc4f15b7a9e9709c169991', '641.242', '0', '', '44854502', '1', null, '9d0b0b4848d9d434265c2028d7580400', '2021-02-06 20:10:49', '1', '2021-02-06 20:13:29', '1', null, '0');
INSERT INTO `edu_video` VALUES ('874', '50', '106', '9-9 分页获取字典详情功能实现', '9', '0', '1', '736cd276774e4fe2883d20a894b9eda4', '1491.86', '0', '', '104710011', '1', null, '07bde954a71aae549e8a438e1dd3f2d1', '2021-02-06 20:12:12', '1', '2021-02-06 20:13:34', '1', null, '0');
INSERT INTO `edu_video` VALUES ('875', '50', '107', '10-6 导出部门数据功能实现', '6', '0', '1', 'ffd4171b2d114a68973213da5a501976', '571.698', '0', '', '41426428', '1', null, 'd8641c8db077dcb8b4e5af1e3a3454f3', '2021-02-06 20:16:52', '1', '2021-02-06 20:27:09', '1', null, '0');
INSERT INTO `edu_video` VALUES ('876', '50', '107', '10-4 编辑部门功能实现', '4', '0', '1', 'a72343f459144985bee054052cbb2579', '600.793', '0', '', '43348871', '1', null, '20669f58664a846f093c99cafde2c950', '2021-02-06 20:17:06', '1', '2021-02-06 20:27:15', '1', null, '0');
INSERT INTO `edu_video` VALUES ('877', '50', '107', '10-3 新增部门功能实现', '3', '0', '1', '896f85484b2947849912058f1301adc0', '1235.7', '0', '', '77098965', '1', null, '413b927fcf605ae7d5292adfdd50b7f9', '2021-02-06 20:19:02', '1', '2021-02-06 20:27:19', '1', null, '0');
INSERT INTO `edu_video` VALUES ('878', '50', '107', '10-2 获取部门列表页面功能实现', '2', '0', '1', 'e13a8988e66947509f2c71d7cb58592d', '1468.66', '0', '', '88577215', '1', null, '6a3653ded0b1572e2d3ae1e1c059f3bd', '2021-02-06 20:19:59', '1', '2021-02-06 20:27:23', '1', null, '0');
INSERT INTO `edu_video` VALUES ('879', '50', '107', '10-5 删除部门功能实现', '5', '0', '1', 'e7b15ba6402743448387b1c17a664a99', '1586.04', '0', '', '112619402', '1', null, '97ee7ac4b895218c0398695c88c5ab68', '2021-02-06 20:20:34', '1', '2021-02-06 20:27:29', '1', null, '0');
INSERT INTO `edu_video` VALUES ('880', '50', '107', '10-1 获取部门列表功能实现', '1', '0', '1', 'af83049a4f734b1695ecd6d84bf24460', '2328.47', '0', '', '172042919', '1', null, '7303eb11ea630e4e9d1d7bbd43c27bcb', '2021-02-06 20:25:00', '1', '2021-02-06 20:27:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('881', '50', '108', '11-6 导出岗位数据功能实现', '6', '0', '1', '3c72f581a09148168ba6161b065b2c52', '492.124', '0', '', '37199817', '1', null, '09d60b6f70519adc77b122a53e774b5a', '2021-02-06 20:30:33', '1', '2021-02-06 20:35:08', '1', null, '0');
INSERT INTO `edu_video` VALUES ('882', '50', '108', '11-5 删除岗位功能实现', '5', '0', '1', 'b061f5ee3afe430a8b48ec9a6aded43c', '547.503', '0', '', '39262591', '1', null, 'a4185bf891aa6497aa8a089223cd714d', '2021-02-06 20:30:34', '1', '2021-02-06 20:35:12', '1', null, '0');
INSERT INTO `edu_video` VALUES ('883', '50', '108', '11-4 编辑岗位功能实现', '4', '0', '1', '71df70e596ce49048c42b90ad4ec112d', '587.302', '0', '', '42418885', '1', null, '24ee41abb64e491e6ebe7219c624caa6', '2021-02-06 20:30:47', '1', '2021-02-06 20:35:17', '1', null, '0');
INSERT INTO `edu_video` VALUES ('884', '50', '108', '11-2 分页获取岗位列表页面功能实现', '2', '0', '1', '8256f660092e40a0873174b57e90bced', '799.602', '0', '', '44520066', '1', null, '876b85bf8cc4167b9bd8b5f75612a1e1', '2021-02-06 20:30:49', '1', '2021-02-06 20:35:20', '1', null, '0');
INSERT INTO `edu_video` VALUES ('885', '50', '108', '11-7 修改岗位状态功能实现', '7', '0', '1', '35f9feacef5542eb98e1f0036aa85b0c', '380.343', '0', '', '19524054', '1', null, '776f057b98f40876880d77851c33ac43', '2021-02-06 20:31:57', '1', '2021-02-06 20:35:25', '1', null, '0');
INSERT INTO `edu_video` VALUES ('886', '50', '108', '11-3 新增岗位功能实现', '3', '0', '1', '3db4e069ae494abfa3053915b3a44a87', '1327.6', '0', '', '89665633', '1', null, '0454929f6bf0714d469cff6ce15e7f96', '2021-02-06 20:33:36', '1', '2021-02-06 20:35:28', '1', null, '0');
INSERT INTO `edu_video` VALUES ('887', '50', '108', '11-1 分页获取岗位列表功能实现', '1', '0', '1', 'acff7b3f47624a4fa90d62aa59dba0e8', '1448.88', '0', '', '103050727', '1', null, '0495215f2f71dce370fe2b87b48426da', '2021-02-06 20:34:07', '1', '2021-02-06 20:35:33', '1', null, '0');
INSERT INTO `edu_video` VALUES ('888', '50', '109', '12-2 分页获取用户列表功能实现（二）', '2', '0', '1', '2450e784a08a458daa58d8159ca4fab1', '248.5', '0', '', '20749667', '1', null, '9974c9b3cae36b2fbb4546ba3d30e90e', '2021-02-06 20:37:37', '1', '2021-02-06 20:50:29', '1', null, '0');
INSERT INTO `edu_video` VALUES ('889', '50', '109', '12-6 删除用户功能实现', '6', '0', '1', '84b97b2619ae4326814fee62069a30a0', '641.312', '0', '', '53557656', '1', null, '076c28cc677c12634375ac62c5ae01cc', '2021-02-06 20:39:27', '1', '2021-02-06 20:50:33', '1', null, '0');
INSERT INTO `edu_video` VALUES ('890', '50', '109', '12-3 分页获取用户列表功能实现（三）', '3', '0', '1', '6b188fc011144334b8451f62aa23bc1a', '1049.84', '0', '', '58477242', '1', null, '799d44be4190b0cacd36508a7927c97f', '2021-02-06 20:40:08', '1', '2021-02-06 20:50:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('891', '50', '109', '12-5 编辑用户功能实现', '5', '0', '1', 'c1aacc3f99ab486ab5d5c9d2e0d7c7c9', '866.569', '0', '', '67630045', '1', null, '0346462d69e27c9736db87477174342f', '2021-02-06 20:40:55', '1', '2021-02-06 20:50:43', '1', null, '0');
INSERT INTO `edu_video` VALUES ('892', '50', '109', '12-7 导出用户数据功能实现', '7', '0', '1', '510f70264e7440a89f8658b7245e4e64', '843.697', '0', '', '68865129', '1', null, 'e014f13c46e2c7af3e4b1441e9928ff7', '2021-02-06 20:41:48', '1', '2021-02-06 20:50:47', '1', null, '0');
INSERT INTO `edu_video` VALUES ('893', '50', '109', '12-4 新增用户功能实现', '4', '0', '1', '49d9627ca9f64e8c9856c3e49278c792', '1477.62', '0', '', '100595813', '1', null, '0d963799d3298b158dcdc32826f9a370', '2021-02-06 20:42:20', '1', '2021-02-06 20:50:52', '1', null, '0');
INSERT INTO `edu_video` VALUES ('894', '50', '109', '12-8 展示用户个人中心功能实现', '8', '0', '1', 'd9bb4eda54a9433ca9e7693f1ec8f866', '887.629', '0', '', '45912652', '1', null, '8f4667d0e6e401dc5f0073a5142e95e8', '2021-02-06 20:42:46', '1', '2021-02-06 20:50:57', '1', null, '0');
INSERT INTO `edu_video` VALUES ('895', '50', '109', '12-9 修改用户个人信息功能实现', '9', '0', '1', '9511b15bdb0941a188c0edb595efd37c', '974.379', '0', '', '66770580', '1', null, 'e83925238f8bdd236cd6da110e3726d7', '2021-02-06 20:44:00', '1', '2021-02-06 20:51:01', '1', null, '0');
INSERT INTO `edu_video` VALUES ('896', '50', '109', '12-1 分页获取用户列表功能实现（一）', '1', '0', '1', '95e7b56085c842fc985a23b96420c81b', '2462.89', '0', '', '171942144', '1', null, '852133d4aa0ba8bc9b42d4e0b96a2f64', '2021-02-06 20:46:02', '1', '2021-02-06 20:51:04', '1', null, '0');
INSERT INTO `edu_video` VALUES ('897', '50', '109', '12-10 修改用户个人密码功能实现', '10', '0', '1', '0ce1610a77ae41f1a1bb93fd4bfc1480', '2053.11', '0', '', '131450357', '1', null, '3942ff26e04ec21229607b92a0cfea26', '2021-02-06 20:49:20', '1', '2021-02-06 20:51:08', '1', null, '0');
INSERT INTO `edu_video` VALUES ('898', '50', '109', '12-13 分页获取在线用户列表功能实现（二）', '13', '0', '1', '3692566526084392be035ed0f69383b6', '540.56', '0', '', '32531413', '1', null, 'd2bd06a2ae6abb923eb807b24d273579', '2021-02-06 20:53:53', '1', '2021-02-06 20:59:30', '1', null, '0');
INSERT INTO `edu_video` VALUES ('899', '50', '109', '12-12 分页获取在线用户列表功能实现（一）', '12', '0', '1', '4428cfb207944542958687b4a2a4bf57', '528.858', '0', '', '37587095', '1', null, 'a9124387835c7250a7412cc32b9e0a2f', '2021-02-06 20:54:12', '1', '2021-02-06 20:59:35', '1', null, '0');
INSERT INTO `edu_video` VALUES ('900', '50', '109', '12-15 导出在线用户数据功能实现', '15', '0', '1', '93cd8b59b0c84697811b42ddda17828d', '574.903', '0', '', '41813625', '1', null, '20c22aafa72e90461272dca77b261e8c', '2021-02-06 20:54:29', '1', '2021-02-06 20:59:40', '1', null, '0');
INSERT INTO `edu_video` VALUES ('901', '50', '109', '12-14 强退在线用户功能实现', '14', '0', '1', '31c0bfca2f014e908d4e1a54232d6e0a', '1009.05', '0', '', '59099836', '1', null, '46bcf37ee528d876c6e11ec8a10844a0', '2021-02-06 20:55:17', '1', '2021-02-06 20:59:45', '1', null, '0');
INSERT INTO `edu_video` VALUES ('902', '50', '109', '12-11 修改用户个人头像功能实现', '11', '0', '1', 'a33c382aa0fa489d8a2bd03a49472b8d', '1334.24', '0', '', '99676066', '1', null, '271b45bae35a378c1ddbf7746af65ed9', '2021-02-06 20:57:54', '1', '2021-02-06 20:59:49', '1', null, '0');
INSERT INTO `edu_video` VALUES ('903', '50', '110', '13-6 重置邮箱功能实现（三）', '6', '0', '1', 'b5ac28dda14c40718bd5d2f62499b5bf', '385.939', '0', '', '31752237', '1', null, '1d3c173b28f42656eb2daf4d4f3c5a32', '2021-02-06 21:02:18', '1', '2021-02-06 21:14:57', '1', null, '0');
INSERT INTO `edu_video` VALUES ('904', '50', '110', '13-2 配置邮箱功能实现', '2', '0', '1', 'dd9f1a29e5d441b18c10943705965184', '778.704', '0', '', '49058576', '1', null, '8463efa40e58e38e690d8181af795bfc', '2021-02-06 21:03:12', '1', '2021-02-06 21:15:00', '1', null, '0');
INSERT INTO `edu_video` VALUES ('905', '50', '110', '13-3 发送邮件功能实现', '3', '0', '1', 'b2e9df44b9824348a2a62947ea9b47fd', '1418.3', '0', '', '88781421', '1', null, 'c64d5010470fe445cc6e642013adf229', '2021-02-06 21:05:22', '1', '2021-02-06 21:15:03', '1', null, '0');
INSERT INTO `edu_video` VALUES ('906', '50', '110', '13-1 查询邮箱配置功能实现', '1', '0', '1', '1dbd25b7520544c1adf16d5354f58f7f', '1449.69', '0', '', '95470510', '1', null, '8b0af69c1362a469926a8ca1b8d83610', '2021-02-06 21:06:29', '1', '2021-02-06 21:15:06', '1', null, '0');
INSERT INTO `edu_video` VALUES ('907', '50', '110', '13-4 重置邮箱功能实现（一）', '4', '0', '1', '75bf908d69ca4fdca1c1c887afb490e1', '2390.1', '0', '', '149016923', '1', null, '926ec5bd039dce881cba5e51f2c7d47c', '2021-02-06 21:08:49', '1', '2021-02-06 21:15:11', '1', null, '0');
INSERT INTO `edu_video` VALUES ('908', '50', '110', '13-5 重置邮箱功能实现（二）', '5', '0', '1', '5f3e89feaeb544068b1d8201996c87c8', '2643.64', '0', '', '228445508', '1', null, '51d715c299e27fe0168a420656408a89', '2021-02-06 21:14:08', '1', '2021-02-06 21:15:15', '1', null, '0');
INSERT INTO `edu_video` VALUES ('909', '50', '111', '14-4 新增错误日志功能实现', '4', '0', '1', '1744254f303843a1bc4d1ac435955222', '233.825', '0', '', '17899603', '1', null, '060b2782fbd227e89b659aa8d12fd1d7', '2021-02-06 21:17:03', '1', '2021-02-06 21:22:32', '1', null, '0');
INSERT INTO `edu_video` VALUES ('910', '50', '111', '14-2 分页获取操作日志列表功能实现（二）', '2', '0', '1', '1c52fe9e5d85483da5ac720d02bc7ab4', '461.311', '0', '', '25622798', '1', null, '893d91984718dfb818aba0136c2eab9f', '2021-02-06 21:17:29', '1', '2021-02-06 21:22:37', '1', null, '0');
INSERT INTO `edu_video` VALUES ('911', '50', '111', '14-6 清空操作日志功能实现', '6', '0', '1', '0fe708c1e5fd4a2986169b1dc2bae5e8', '803.178', '0', '', '48060811', '1', null, '8a6c5f247604b32e3fff62e4b65e7606', '2021-02-06 21:18:55', '1', '2021-02-06 21:22:41', '1', null, '0');
INSERT INTO `edu_video` VALUES ('912', '50', '111', '14-7 分页获取错误日志列表功能实现', '7', '0', '1', '3bb58eae34b34b3a8f3ca31b16539bbd', '550.174', '0', '', '34440858', '1', null, 'b867e03d64fcf36e59c8851304f9cf85', '2021-02-06 21:19:08', '1', '2021-02-06 21:22:45', '1', null, '0');
INSERT INTO `edu_video` VALUES ('913', '50', '111', '14-5 导出操作日志功能实现', '5', '0', '1', 'b65e8a6038b2470d9dc4b8c5b9e07767', '757.365', '0', '', '57037537', '1', null, '5b93c321e259d9d88636c75edab216d6', '2021-02-06 21:19:14', '1', '2021-02-06 21:22:50', '1', null, '0');
INSERT INTO `edu_video` VALUES ('914', '50', '111', '14-8 查看错误日志功能实现', '8', '0', '1', 'e6b5bb79e7074148962f8f324fed6e97', '638.804', '0', '', '45090348', '1', null, '15bd12875db6828c5c1ae0dd64fd30b8', '2021-02-06 21:20:15', '1', '2021-02-06 21:22:55', '1', null, '0');
INSERT INTO `edu_video` VALUES ('915', '50', '111', '14-9 导出错误日志功能实现', '9', '0', '1', '1b56a006527c42498f1dd9f2786c5f3d', '313.376', '0', '', '26988922', '1', null, '60741d8cfb55ca2f4819474d46cf5afd', '2021-02-06 21:20:31', '1', '2021-02-06 21:22:59', '1', null, '0');
INSERT INTO `edu_video` VALUES ('916', '50', '111', '14-11 个人日志列表功能实现', '11', '0', '1', '0af9abb062f441c081e312a44a42c884', '468.393', '0', '', '31596771', '1', null, 'a7df9f3ba0956ac1531b5ae346062d23', '2021-02-06 21:21:18', '1', '2021-02-06 21:23:04', '1', null, '0');
INSERT INTO `edu_video` VALUES ('917', '50', '111', '14-10 清空错误日志功能实现', '10', '0', '1', '96f58d293816443e88ce5e45e41eaa2c', '502.062', '0', '', '37060475', '1', null, 'ffdb3bb833907339a67ed48e2dda0771', '2021-02-06 21:21:38', '1', '2021-02-06 21:23:08', '1', null, '0');
INSERT INTO `edu_video` VALUES ('918', '50', '111', '14-1 分页获取操作日志列表功能实现', '1', '0', '1', 'e83b7acd45334ccead95ad2bfeaafa76', '1217.38', '0', '', '85735808', '1', null, '2d2940a012069ece19fb10057d43b863', '2021-02-06 21:21:38', '1', '2021-02-06 21:23:21', '1', null, '0');
INSERT INTO `edu_video` VALUES ('919', '50', '111', '14-3 新增日志功能实现', '3', '0', '1', '99b3e8cf0e8647f892440595870371aa', '1296.76', '0', '', '91974003', '1', null, 'e5f54ac02f3ba77cd4d1a9ee16801898', '2021-02-06 21:22:08', '1', '2021-02-06 21:23:17', '1', null, '0');
INSERT INTO `edu_video` VALUES ('920', '50', '112', '15-5 定时统计流量功能实现', '5', '0', '1', '61a4f2df35a64a81a91c2fde75aa9d16', '270.257', '0', '', '17090141', '1', null, 'd095fc84ee11fe787c0ea40c11cb047c', '2021-02-06 21:24:56', '1', '2021-02-06 21:28:36', '1', null, '0');
INSERT INTO `edu_video` VALUES ('921', '50', '112', '15-3 初始化站点统计功能实现', '3', '0', '1', '32585dd1b8e84d87a9afba3089f52160', '473.246', '0', '', '33266112', '1', null, '657a4fdcd2934bf2a47dc11e15e5b800', '2021-02-06 21:26:05', '1', '2021-02-06 21:28:40', '1', null, '0');
INSERT INTO `edu_video` VALUES ('922', '50', '112', '15-4 使用图表展示数据功能实现', '4', '0', '1', 'd8a7a833df4741a09db121b0527024ea', '902.769', '0', '', '55708035', '1', null, '8aade87d5aece3c6335f4643017a401d', '2021-02-06 21:26:52', '1', '2021-02-06 21:28:43', '1', null, '0');
INSERT INTO `edu_video` VALUES ('923', '50', '112', '15-2 获取统计数据（二）', '2', '0', '1', '2127fd01de8945fa8a76034ea1716c1d', '1005.96', '0', '', '69213392', '1', null, '4718827009c620ce1f2721a8d67a16ed', '2021-02-06 21:27:36', '1', '2021-02-06 21:28:46', '1', null, '0');
INSERT INTO `edu_video` VALUES ('924', '50', '112', '15-6 地图流量统计功能实现', '6', '0', '1', '32a91abaff7e4d21b579ccea3e7c2b9a', '955.292', '0', '', '58408037', '1', null, '3c0c9c791146b54f4afb961b54ff050d', '2021-02-06 21:27:40', '1', '2021-02-06 21:28:51', '1', null, '0');
INSERT INTO `edu_video` VALUES ('925', '50', '112', '15-1 获取统计数据', '1', '0', '1', '4c0bef17bddd4e8f89d10e12c589c31f', '1105.22', '0', '', '64238883', '1', null, 'fba7f9d459c2e7b6e525d41ce91ff90b', '2021-02-06 21:28:04', '1', '2021-02-06 21:28:53', '1', null, '0');
INSERT INTO `edu_video` VALUES ('926', '59', '136', '1-1 课程介绍', '1', '0', '0', 'faa7ad6f7ad0486fb0e30eb98d2135fa', '844.463', '0', '', '53279786', '1', null, '8342fcdd1d70eb40565ac6dc538d396e', '2021-05-25 20:02:31', '2', '2021-05-26 09:25:07', '2', null, '0');

-- ----------------------------
-- Table structure for edu_video_member
-- ----------------------------
DROP TABLE IF EXISTS `edu_video_member`;
CREATE TABLE `edu_video_member` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `video_id` bigint(20) NOT NULL COMMENT '视频ID',
  `member_id` bigint(20) NOT NULL COMMENT '会员ID',
  `play_count` bigint(20) NOT NULL COMMENT '播放次数',
  `duration` float DEFAULT NULL COMMENT '已播放时长',
  `ip` varchar(255) DEFAULT NULL COMMENT '操作者ip',
  `country` varchar(255) DEFAULT NULL COMMENT '国家或地区',
  `area` varchar(255) DEFAULT NULL COMMENT '区域',
  `province` varchar(255) DEFAULT NULL COMMENT '所属省份',
  `city` varchar(255) DEFAULT NULL COMMENT '城市',
  `isp` varchar(255) DEFAULT NULL COMMENT '网络服务提供商',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `create_by` bigint(20) DEFAULT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL COMMENT '最后一次播放时间',
  `del_flag` tinyint(1) DEFAULT '0' COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=515 DEFAULT CHARSET=utf8mb4 COMMENT='会员视频播放记录表';

-- ----------------------------
-- Records of edu_video_member
-- ----------------------------
INSERT INTO `edu_video_member` VALUES ('498', '812', '26', '1', '0', '内网IP|0|0|内网IP|内网IP', '内网IP', '0', '0', '内网IP', '内网IP', '2021-02-10 10:27:27', '23', '23', '2021-02-10 10:27:27', '0', null);
INSERT INTO `edu_video_member` VALUES ('499', '790', '26', '1', '0', '内网IP|0|0|内网IP|内网IP', '内网IP', '0', '0', '内网IP', '内网IP', '2021-02-10 10:27:32', '23', '23', '2021-02-10 10:27:32', '0', null);
INSERT INTO `edu_video_member` VALUES ('500', '813', '26', '1', '0', '内网IP|0|0|内网IP|内网IP', '内网IP', '0', '0', '内网IP', '内网IP', '2021-02-10 10:27:45', '23', '23', '2021-02-10 10:27:45', '0', null);
INSERT INTO `edu_video_member` VALUES ('501', '813', '26', '1', '0', '内网IP|0|0|内网IP|内网IP', '内网IP', '0', '0', '内网IP', '内网IP', '2021-02-10 10:28:03', '23', '23', '2021-02-10 10:28:03', '0', null);
INSERT INTO `edu_video_member` VALUES ('502', '814', '26', '1', '0', '内网IP|0|0|内网IP|内网IP', '内网IP', '0', '0', '内网IP', '内网IP', '2021-02-10 10:28:12', '23', '23', '2021-02-10 10:28:12', '0', null);
INSERT INTO `edu_video_member` VALUES ('503', '794', '26', '1', '0', '内网IP|0|0|内网IP|内网IP', '内网IP', '0', '0', '内网IP', '内网IP', '2021-02-10 12:36:49', '23', '23', '2021-02-10 12:36:49', '0', null);
INSERT INTO `edu_video_member` VALUES ('504', '790', '26', '1', '0', '内网IP|0|0|内网IP|内网IP', '内网IP', '0', '0', '内网IP', '内网IP', '2021-02-10 12:45:30', '23', '23', '2021-02-10 12:45:30', '0', null);
INSERT INTO `edu_video_member` VALUES ('505', '792', '26', '1', '0', '内网IP|0|0|内网IP|内网IP', '内网IP', '0', '0', '内网IP', '内网IP', '2021-02-10 12:45:32', '23', '23', '2021-02-10 12:45:32', '0', null);
INSERT INTO `edu_video_member` VALUES ('506', '791', '26', '1', '0', '内网IP|0|0|内网IP|内网IP', '内网IP', '0', '0', '内网IP', '内网IP', '2021-02-10 12:45:34', '23', '23', '2021-02-10 12:45:34', '0', null);
INSERT INTO `edu_video_member` VALUES ('507', '794', '26', '1', '0', '内网IP|0|0|内网IP|内网IP', '内网IP', '0', '0', '内网IP', '内网IP', '2021-02-10 12:45:38', '23', '23', '2021-02-10 12:45:38', '0', null);
INSERT INTO `edu_video_member` VALUES ('508', '611', '26', '1', '0', '内网IP|0|0|内网IP|内网IP', '内网IP', '0', '0', '内网IP', '内网IP', '2021-02-10 16:31:37', '23', '23', '2021-02-10 16:31:37', '0', null);
INSERT INTO `edu_video_member` VALUES ('509', '606', '26', '1', '0', '内网IP|0|0|内网IP|内网IP', '内网IP', '0', '0', '内网IP', '内网IP', '2021-02-10 17:23:06', '23', '23', '2021-02-10 17:23:06', '0', null);
INSERT INTO `edu_video_member` VALUES ('510', '606', '26', '1', '0', '内网IP|0|0|内网IP|内网IP', '内网IP', '0', '0', '内网IP', '内网IP', '2021-02-10 17:25:14', '23', '23', '2021-02-10 17:25:14', '0', null);
INSERT INTO `edu_video_member` VALUES ('511', '7', '26', '1', '0', '内网IP|0|0|内网IP|内网IP', '内网IP', '0', '0', '内网IP', '内网IP', '2021-02-10 21:24:39', '23', '23', '2021-02-10 21:24:39', '0', null);
INSERT INTO `edu_video_member` VALUES ('512', '7', '26', '1', '0', '内网IP|0|0|内网IP|内网IP', '内网IP', '0', '0', '内网IP', '内网IP', '2021-02-10 21:24:50', '23', '23', '2021-02-10 21:24:50', '0', null);
INSERT INTO `edu_video_member` VALUES ('513', '6', '26', '1', '0', '内网IP|0|0|内网IP|内网IP', '内网IP', '0', '0', '内网IP', '内网IP', '2021-02-10 21:24:55', '23', '23', '2021-02-10 21:24:55', '0', null);
INSERT INTO `edu_video_member` VALUES ('514', '655', '26', '1', '0', '内网IP|0|0|内网IP|内网IP', '内网IP', '0', '0', '内网IP', '内网IP', '2021-02-11 10:54:58', '23', '23', '2021-02-11 10:54:58', '0', null);

-- ----------------------------
-- Table structure for edu_vip_type
-- ----------------------------
DROP TABLE IF EXISTS `edu_vip_type`;
CREATE TABLE `edu_vip_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '会员名称',
  `vip_money` double(10,0) NOT NULL DEFAULT '0' COMMENT '会员价格',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `create_by` bigint(20) NOT NULL,
  `update_by` bigint(20) NOT NULL,
  `update_date` datetime NOT NULL COMMENT '修改时间',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COMMENT='VIP会员类型表';

-- ----------------------------
-- Records of edu_vip_type
-- ----------------------------
INSERT INTO `edu_vip_type` VALUES ('1', '注册会员', '0', '2020-09-07 21:50:22', '1', '1', '2020-09-07 21:50:24', '0', null);
INSERT INTO `edu_vip_type` VALUES ('2', '铜牌会员', '1', '2020-09-07 21:50:35', '1', '1', '2020-09-07 21:50:37', '0', null);
INSERT INTO `edu_vip_type` VALUES ('3', '银牌会员', '2', '2020-09-07 21:50:52', '1', '1', '2020-09-07 21:50:55', '0', null);
INSERT INTO `edu_vip_type` VALUES ('4', '金牌会员', '3', '2020-09-07 21:51:24', '1', '1', '2020-09-07 21:51:27', '0', null);
INSERT INTO `edu_vip_type` VALUES ('5', '钻石会员', '4', '2020-09-07 21:51:36', '1', '1', '2020-09-07 21:51:38', '0', null);
INSERT INTO `edu_vip_type` VALUES ('9', '测试会员', '1', '2021-02-01 11:09:50', '1', '1', '2021-02-01 11:09:50', '1', null);
INSERT INTO `edu_vip_type` VALUES ('10', '测试会员2', '2', '2021-02-01 21:09:48', '1', '1', '2021-02-01 21:10:53', '1', null);

-- ----------------------------
-- Table structure for edu_vip_type_subject
-- ----------------------------
DROP TABLE IF EXISTS `edu_vip_type_subject`;
CREATE TABLE `edu_vip_type_subject` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `vip_id` bigint(20) NOT NULL COMMENT 'vip会员类别ID',
  `subject_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '课程分类ID',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `create_by` bigint(20) DEFAULT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime NOT NULL COMMENT '修改时间',
  `remarks` varchar(255) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT '0' COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COMMENT='会员类型和课程类别关系表';

-- ----------------------------
-- Records of edu_vip_type_subject
-- ----------------------------
INSERT INTO `edu_vip_type_subject` VALUES ('1', '5', '8', '2021-02-02 20:16:15', '1', '1', '2021-02-02 20:16:15', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('2', '5', '9', '2021-02-02 20:16:15', '1', '1', '2021-02-02 20:16:15', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('3', '5', '11', '2021-02-02 20:16:15', '1', '1', '2021-02-02 20:16:15', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('4', '5', '12', '2021-02-02 20:16:15', '1', '1', '2021-02-02 20:16:15', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('5', '5', '13', '2021-02-02 20:16:15', '1', '1', '2021-02-02 20:16:15', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('6', '5', '14', '2021-02-02 20:16:15', '1', '1', '2021-02-02 20:16:15', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('7', '5', '15', '2021-02-02 20:16:15', '1', '1', '2021-02-02 20:16:15', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('8', '5', '16', '2021-02-02 20:16:15', '1', '1', '2021-02-02 20:16:15', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('9', '5', '17', '2021-02-02 20:16:15', '1', '1', '2021-02-02 20:16:15', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('10', '5', '18', '2021-02-02 20:16:15', '1', '1', '2021-02-02 20:16:15', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('11', '5', '19', '2021-02-02 20:16:15', '1', '1', '2021-02-02 20:16:15', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('12', '5', '20', '2021-02-02 20:16:15', '1', '1', '2021-02-02 20:16:15', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('13', '5', '21', '2021-02-02 20:16:15', '1', '1', '2021-02-02 20:16:15', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('14', '5', '22', '2021-02-02 20:16:15', '1', '1', '2021-02-02 20:16:15', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('15', '5', '23', '2021-02-02 20:16:15', '1', '1', '2021-02-02 20:16:15', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('16', '5', '24', '2021-02-02 20:16:15', '1', '1', '2021-02-02 20:16:15', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('17', '5', '25', '2021-02-02 20:16:15', '1', '1', '2021-02-02 20:16:15', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('18', '5', '26', '2021-02-02 20:16:15', '1', '1', '2021-02-02 20:16:15', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('19', '5', '27', '2021-02-02 20:16:16', '1', '1', '2021-02-02 20:16:16', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('20', '5', '28', '2021-02-02 20:16:16', '1', '1', '2021-02-02 20:16:16', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('21', '4', '8', '2021-02-02 20:33:49', '1', '1', '2021-02-02 20:33:49', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('22', '4', '9', '2021-02-02 20:33:49', '1', '1', '2021-02-02 20:33:49', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('23', '4', '11', '2021-02-02 20:33:49', '1', '1', '2021-02-02 20:33:49', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('24', '4', '8', '2021-02-02 20:34:00', '1', '1', '2021-02-02 20:34:00', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('25', '4', '9', '2021-02-02 20:34:00', '1', '1', '2021-02-02 20:34:00', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('26', '4', '11', '2021-02-02 20:34:00', '1', '1', '2021-02-02 20:34:00', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('27', '4', '27', '2021-02-02 20:34:00', '1', '1', '2021-02-02 20:34:00', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('28', '4', '28', '2021-02-02 20:34:00', '1', '1', '2021-02-02 20:34:00', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('29', '2', '19', '2021-02-02 20:35:44', '1', '1', '2021-02-02 20:35:44', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('30', '2', '20', '2021-02-02 20:35:44', '1', '1', '2021-02-02 20:35:44', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('31', '2', '21', '2021-02-02 20:35:44', '1', '1', '2021-02-02 20:35:44', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('32', '2', '22', '2021-02-02 20:35:44', '1', '1', '2021-02-02 20:35:44', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('33', '2', '23', '2021-02-02 20:35:44', '1', '1', '2021-02-02 20:35:44', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('34', '2', '24', '2021-02-02 20:35:44', '1', '1', '2021-02-02 20:35:44', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('35', '2', '25', '2021-02-02 20:35:44', '1', '1', '2021-02-02 20:35:44', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('36', '2', '26', '2021-02-02 20:35:44', '1', '1', '2021-02-02 20:35:44', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('37', '2', '27', '2021-02-02 20:35:44', '1', '1', '2021-02-02 20:35:44', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('38', '3', '8', '2021-02-02 20:36:57', '1', '1', '2021-02-02 20:36:57', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('39', '3', '14', '2021-02-02 20:36:57', '1', '1', '2021-02-02 20:36:57', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('40', '3', '15', '2021-02-02 20:36:57', '1', '1', '2021-02-02 20:36:57', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('41', '3', '16', '2021-02-02 20:36:57', '1', '1', '2021-02-02 20:36:57', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('42', '3', '17', '2021-02-02 20:36:57', '1', '1', '2021-02-02 20:36:57', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('43', '3', '18', '2021-02-02 20:36:57', '1', '1', '2021-02-02 20:36:57', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('44', '3', '19', '2021-02-02 20:36:57', '1', '1', '2021-02-02 20:36:57', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('45', '3', '20', '2021-02-02 20:36:57', '1', '1', '2021-02-02 20:36:57', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('46', '3', '21', '2021-02-02 20:36:57', '1', '1', '2021-02-02 20:36:57', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('47', '3', '22', '2021-02-02 20:36:57', '1', '1', '2021-02-02 20:36:57', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('48', '3', '23', '2021-02-02 20:36:57', '1', '1', '2021-02-02 20:36:57', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('49', '3', '24', '2021-02-02 20:36:57', '1', '1', '2021-02-02 20:36:57', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('50', '3', '25', '2021-02-02 20:36:57', '1', '1', '2021-02-02 20:36:57', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('51', '3', '26', '2021-02-02 20:36:57', '1', '1', '2021-02-02 20:36:57', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('52', '3', '27', '2021-02-02 20:36:57', '1', '1', '2021-02-02 20:36:57', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('53', '3', '28', '2021-02-02 20:36:57', '1', '1', '2021-02-02 20:36:57', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('54', '4', '8', '2021-02-02 20:37:33', '1', '1', '2021-02-02 20:37:33', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('55', '4', '9', '2021-02-02 20:37:33', '1', '1', '2021-02-02 20:37:33', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('56', '4', '11', '2021-02-02 20:37:33', '1', '1', '2021-02-02 20:37:33', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('57', '4', '14', '2021-02-02 20:37:33', '1', '1', '2021-02-02 20:37:33', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('58', '4', '15', '2021-02-02 20:37:33', '1', '1', '2021-02-02 20:37:33', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('59', '4', '18', '2021-02-02 20:37:33', '1', '1', '2021-02-02 20:37:33', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('60', '4', '19', '2021-02-02 20:37:33', '1', '1', '2021-02-02 20:37:33', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('61', '4', '20', '2021-02-02 20:37:33', '1', '1', '2021-02-02 20:37:33', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('62', '4', '21', '2021-02-02 20:37:33', '1', '1', '2021-02-02 20:37:33', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('63', '4', '22', '2021-02-02 20:37:33', '1', '1', '2021-02-02 20:37:33', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('64', '4', '23', '2021-02-02 20:37:33', '1', '1', '2021-02-02 20:37:33', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('65', '4', '24', '2021-02-02 20:37:33', '1', '1', '2021-02-02 20:37:33', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('66', '4', '25', '2021-02-02 20:37:33', '1', '1', '2021-02-02 20:37:33', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('67', '4', '26', '2021-02-02 20:37:33', '1', '1', '2021-02-02 20:37:33', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('68', '4', '27', '2021-02-02 20:37:33', '1', '1', '2021-02-02 20:37:33', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('69', '4', '28', '2021-02-02 20:37:33', '1', '1', '2021-02-02 20:37:33', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('70', '3', '8', '2021-02-02 20:38:04', '1', '1', '2021-02-02 20:38:04', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('71', '3', '14', '2021-02-02 20:38:04', '1', '1', '2021-02-02 20:38:04', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('72', '3', '15', '2021-02-02 20:38:04', '1', '1', '2021-02-02 20:38:04', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('73', '3', '18', '2021-02-02 20:38:04', '1', '1', '2021-02-02 20:38:04', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('74', '3', '19', '2021-02-02 20:38:04', '1', '1', '2021-02-02 20:38:04', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('75', '3', '20', '2021-02-02 20:38:04', '1', '1', '2021-02-02 20:38:04', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('76', '3', '21', '2021-02-02 20:38:04', '1', '1', '2021-02-02 20:38:04', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('77', '3', '22', '2021-02-02 20:38:04', '1', '1', '2021-02-02 20:38:04', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('78', '3', '23', '2021-02-02 20:38:04', '1', '1', '2021-02-02 20:38:04', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('79', '3', '24', '2021-02-02 20:38:04', '1', '1', '2021-02-02 20:38:04', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('80', '3', '25', '2021-02-02 20:38:04', '1', '1', '2021-02-02 20:38:04', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('81', '3', '26', '2021-02-02 20:38:04', '1', '1', '2021-02-02 20:38:04', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('82', '3', '27', '2021-02-02 20:38:04', '1', '1', '2021-02-02 20:38:04', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('83', '3', '28', '2021-02-02 20:38:04', '1', '1', '2021-02-02 20:38:04', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('84', '2', '19', '2021-02-02 20:38:27', '1', '1', '2021-02-02 20:38:27', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('85', '2', '20', '2021-02-02 20:38:27', '1', '1', '2021-02-02 20:38:27', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('86', '2', '21', '2021-02-02 20:38:27', '1', '1', '2021-02-02 20:38:27', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('87', '2', '22', '2021-02-02 20:38:27', '1', '1', '2021-02-02 20:38:27', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('88', '2', '23', '2021-02-02 20:38:27', '1', '1', '2021-02-02 20:38:27', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('89', '2', '24', '2021-02-02 20:38:27', '1', '1', '2021-02-02 20:38:27', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('90', '2', '8', '2021-02-02 20:38:27', '1', '1', '2021-02-02 20:38:27', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('91', '2', '25', '2021-02-02 20:38:27', '1', '1', '2021-02-02 20:38:27', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('92', '2', '26', '2021-02-02 20:38:27', '1', '1', '2021-02-02 20:38:27', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('93', '2', '27', '2021-02-02 20:38:27', '1', '1', '2021-02-02 20:38:27', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('94', '1', '23', '2021-02-02 20:39:01', '1', '1', '2021-02-02 20:39:01', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('95', '1', '24', '2021-02-02 20:39:01', '1', '1', '2021-02-02 20:39:01', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('96', '1', '25', '2021-02-02 20:39:01', '1', '1', '2021-02-02 20:39:01', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('97', '1', '26', '2021-02-02 20:39:01', '1', '1', '2021-02-02 20:39:01', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('98', '1', '27', '2021-02-02 20:39:01', '1', '1', '2021-02-02 20:39:01', null, '1');
INSERT INTO `edu_vip_type_subject` VALUES ('99', '1', '23', '2021-02-02 20:39:24', '1', '1', '2021-02-02 20:39:24', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('100', '1', '24', '2021-02-02 20:39:24', '1', '1', '2021-02-02 20:39:24', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('101', '1', '8', '2021-02-02 20:39:24', '1', '1', '2021-02-02 20:39:24', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('102', '1', '25', '2021-02-02 20:39:24', '1', '1', '2021-02-02 20:39:24', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('103', '1', '26', '2021-02-02 20:39:24', '1', '1', '2021-02-02 20:39:24', null, '0');
INSERT INTO `edu_vip_type_subject` VALUES ('104', '1', '27', '2021-02-02 20:39:24', '1', '1', '2021-02-02 20:39:24', null, '0');
