#  xueden-cloud-edu 在线教育平台


# 项目介绍

xueden-cloud-edu（学灯网）是基于springcloud alibaba+vue3.0整合开发的在线教育平台 ,架构思想来源于( [RuoYi-Cloud](https://gitee.com/y_project/RuoYi-Cloud))。
- 以Spring Framework为核心容器；
- Spring MVC为模型视图控制器；
- Mybatis Plus为数据访问层；
- spring security为权限授权层；
- Redis为分布式缓存；
- 注册中心、配置中心选型Nacos；
- 流量控制框架选型Sentinel；
- vue3.0+element plus作为前端框架并进行前后端分离的开源框架。

# 前端项目

前端项目地址( [xueden-cloud-edu-vue3-admin](https://github.com/seasonl2014/xueden-cloud-edu-vue3-admin))

# 技术文档
- 讨论加群：qq群①：601212472   
- 演示地址：[http://www.xueden.cn/](http://www.xueden.cn/ "http://www.xueden.cn/")




# 项目特点
- 开箱即用，节省开发时间，提高开发效率
- 代码全部开源，持续更新，共同维护
- 基于springcloud alibaba，简化了大量项目配置和maven依赖，让您更专注于业务开发
- 友好的代码结构及注释，便于阅读及二次开发
- 使用分包分层设计，工程拆分，分为dao，service，Controller，view层，层次清楚，低耦合，高内聚。
- 灵活的权限控制, 整合spring security，可控制到页面或按钮，满足绝大部分的权限需求,优化权限注解方便权限配置
- 日志记录采用aop方式，可对用户所有操作进行记录
- 引入swagger文档支持，方便编写API接口文档
- 项目采用前后端分离架构，提升效率
- 前端组件丰富，集成element-plus，基本涵盖了所有前端开发需求
- 支持多种浏览器: Google, 火狐, IE,360等

# 系统模块

~~~
cn.moyu     
├── moyu-gateway         // 网关模块 [7000]
├── moyu-auth            // 认证中心 [8000]
├── moyu-api             // 接口模块
│       └── moyu-api-system                          // 系统接口
├── moyu-common          // 通用模块
│		└── moyu-common-alivod                       // 阿里云视频点播 
│       └── moyu-common-core                         // 核心模块
│       └── moyu-common-elasticsearch                // 搜索模块
│       └── moyu-common-log                          // 日志记录
│       └── moyu-common-redis                        // 缓存服务
│       └── moyu-common-security                     // 安全模块
│       └── moyu-common-swagger                      // 系统接口
│       └── moyu-common-mybatis-plus                 // 持久层模块
│       └── moyu-common-wechatpay                    // 微信支付模块
├── moyu-modules         // 业务模块
│       └── moyu-edu                                 // 教育模块 [6000]
│       └── moyu-system                              // 系统模块 [9000]
├──pom.xml                // 公共依赖
~~~


# 技术选型
### 服务端
| 技术 | 说明 | 官网  |
| ------------ | ------------ | ------------ |
|spring-cloud-alibaba|核心框架|[https://spring.io/projects/spring-cloud-alibaba/](https://spring.io/projects/spring-cloud-alibaba/ "https://spring.io/projects/spring-cloud-alibaba/")|
|Spring MVC|视图框架|[http://docs.spring.io/spring/docs/current/spring-framework-reference/htmlsingle/#mvc](http://docs.spring.io/spring/docs/current/spring-framework-reference/htmlsingle/#mvc "http://docs.spring.io/spring/docs/current/spring-framework-reference/htmlsingle/#mvc")|
|Spring Cloud Security|权限框架|[https://spring.io/projects/spring-cloud-security/](https://spring.io/projects/spring-cloud-security/ "https://spring.io/projects/spring-cloud-security/")|
|MyBatis|持久层框架|[http://www.mybatis.org/mybatis-3/zh/index.html](http://www.mybatis.org/mybatis-3/zh/index.html "http://www.mybatis.org/mybatis-3/zh/index.html")|
|MyBatis-Plus|MyBatis增强工具|[https://mp.baomidou.com/](https://mp.baomidou.com/ "https://mp.baomidou.com/")|
|Alibaba nacos|注册和配置中心|[https://github.com/alibaba/nacos/](https://github.com/alibaba/nacos/ "https://github.com/alibaba/nacos/")|
|Redis|分布式缓存数据库|[https://redis.io/](https://redis.io/ "https://redis.io/")|
|Spring Cloud OpenFeign|服务调用|[https://spring.io/projects/spring-cloud-openfeign/](https://spring.io/projects/spring-cloud-openfeign/ "https://spring.io/projects/spring-cloud-openfeign/")|
|Spring Cloud Gateway|服务网关|[https://spring.io/projects/spring-cloud-gateway/](https://spring.io/projects/spring-cloud-gateway/ "https://spring.io/projects/spring-cloud-gateway/")|
|SLF4J|日志组件|[http://www.slf4j.org/](http://www.slf4j.org/ "http://www.slf4j.org/")|
|alibaba Sentinel|限流熔断|[https://github.com/alibaba/Sentinel/](https://github.com/alibaba/Sentinel/ "https://github.com/alibaba/Sentinel/")|
|Maven|项目构建管理|[http://maven.apache.org/](http://maven.apache.org/ "http://maven.apache.org/")|
|swagger2|文档生成工具|[https://swagger.io/](https://swagger.io/ "https://swagger.io/")|
|Apache Commons|工具类|[http://commons.apache.org/](http://commons.apache.org/ "http://commons.apache.org/")|
|fastjson|JSON解析库|[https://github.com/alibaba/fastjson](https://github.com/alibaba/fastjson "https://github.com/alibaba/fastjson")|
### 前端
|技术|名称|官网|
| ------------ | ------------ | ------------ |
|vue3.x|vue|[https://github.com/vuejs/vue-next](https://github.com/vuejs/vue-next"https://github.com/vuejs/vue-next")|
|element-plus|组件库|[https://github.com/element-plus/element-plus](https://github.com/element-plus/element-plus "https://github.com/element-plus/element-plus")|
|admin-element-vue|后台管理模板|[http://admin-element-vue.liqingsong.cc/tsv2/](http://admin-element-vue.liqingsong.cc/tsv2/"http://admin-element-vue.liqingsong.cc/tsv2/")|
|vuex4.x|状态管理模式|[https://github.com/vuejs/vuex](https://github.com/vuejs/vuex "https://github.com/vuejs/vuex")|
|vue-router4.x|路由组件|[https://github.com/vuejs/vue-router-next](https://github.com/vuejs/vue-router-next "https://github.com/vuejs/vue-router-next")|
|TypeScript4.x|js超集|[https://github.com/Microsoft/TypeScript](https://github.com/Microsoft/TypeScript "https://github.com/Microsoft/TypeScript")|

# 功能列表
```html
- 系统管理
    ○ 用户管理：用于管理后台系统的用户，可进行增删改查等操作
    ○ 菜单管理：维护系统菜单，操作权限，按钮权限
    ○ 角色管理：维护系统角色信息，以角色为单位分配系统权限
    ○ 日志管理：系统正常操作日志记录和查询；系统异常信息日志记录和查询
- 教育管理
    ○ 会员管理：用于管理后台系统的注册会员，可进行删、查等操作
    ○ 会员分类：维护会员类别，可进行增删改查以及分配权益
    ○ 课程管理：维护系统课程信息，可进行增删改查以及编写章节上传视频和课程资料
    ○ 课程分类管理：维护系统课程类别信息，可进行增删改查等操作
    ○ 讲师管理：用于管理讲师信息，可进行增删改查等操作
- 教育平台门户
    ○ 注册和登录：用户通过手机号进行注册和登录
    ○ 课程展示：首页分类展示课程信息
    ○ 列表展示：通过列表的形式展示课程
    ○ 加入VIP：用户可以通过微信支付购买VIP
    ○ 购买课程：用户可以通过微信支付购买所有课程
    ○ 个人中心：展示我的课程，个人信息，购买记录等
    ○ 在线播放课程视频：用户通过点播的方式学习购买过的课程
    ○ 广告展示：免费的课程将会自动出现广告，购买后广告自动关闭

```

# 更新日志
## 2020-2-21 xueden-cloud-edu版本发布
# 版权声明
xueden-cloud-edu使用 Apache-2.0 License 协议.

商业使用请联系作者授权QQ：11184629 ，授权费用：1999元，授权后可以二次开发、销售，无需再交钱，也可以闭源。

# 演示地址

后台演示地址：http://cms.xueden.cn/  测试账号： test02  测试密码：123456



前台演示地址：http://www.xueden.cn/  测试请自行注册账号即可









