# cloud_layui 权限管理系统


# 项目介绍

cloud_layui是基于springcloud alibaba+layui整合开发前后端分离权限管理系统,架构思想来源于( [RuoYi-Cloud](https://gitee.com/y_project/RuoYi-Cloud))。
- 以Spring Framework为核心容器；
- Spring MVC为模型视图控制器；
- Mybatis Plus为数据访问层；
- spring security为权限授权层；
- Redis为分布式缓存；
- 注册中心、配置中心选型Nacos；
- 流量控制框架选型Sentinel；
- layui+layuimini作为前端框架并进行前后端分离的开源框架。

# 前端项目

前端项目地址( [xueden_cloud_layuimini](https://github.com/seasonl2014/xueden_cloud_layuimini))

# 技术文档
- 讨论加群：qq群①：601212472   
- 演示地址：[http://money.goodym.cn/layuidemo/page/login.html](http://money.goodym.cn/layuidemo/page/login.html "http://money.goodym.cn/layuidemo/page/login.html")

# 配套详细视频教程
- 视频教程地址：[http://java.goodym.cn/html/1571623967758.html](http://java.goodym.cn/html/1571623967758.html "http://java.goodym.cn/html/1571623967758.html")


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
- 前端组件丰富，集成layuimini，基本涵盖了所有前端开发需求
- 支持多种浏览器: Google, 火狐, IE,360等

# 系统模块

~~~
cn.moyu     
├── moyu-gateway         // 网关模块 [7000]
├── moyu-auth            // 认证中心 [8000]
├── moyu-api             // 接口模块
│       └── moyu-api-system                          // 系统接口
├── moyu-common          // 通用模块
│       └── moyu-common-core                         // 核心模块
│       └── moyu-common-log                          // 日志记录
│       └── moyu-common-redis                        // 缓存服务
│       └── moyu-common-security                     // 安全模块
│       └── moyu-common-swagger                      // 系统接口
│       └── moyu-common-mybatis-plus                 // 持久层模块
├── moyu-modules         // 业务模块
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
|jQuery|js库|[http://jquery.com/](http://jquery.com/ "http://jquery.com/")|
|layui.table|数据表格|[https://www.layui.com/doc/modules/table.html](https://www.layui.com/doc/modules/table.html "https://www.layui.com/doc/modules/table.html")|
|layuimini|后台管理模板|[http://layuimini.99php.cn/](http://layuimini.99php.cn/ "http://layuimini.99php.cn/")|
|layui|前端框架|[https://www.layui.com/](https://www.layui.com/ "https://www.layui.com/")|
|layui.layer|弹出组件|[https://www.layui.com/doc/modules/layer.html](https://www.layui.com/doc/modules/layer.html "https://www.layui.com/doc/modules/layer.html")|
|layui.treeTable|树形表格|[https://fly.layui.com/jie/30625/](https://fly.layui.com/jie/30625/ "https://fly.layui.com/jie/30625/")|

# 功能列表
```html
- 系统管理
    ○ 用户管理：用于管理后台系统的用户，可进行增删改查等操作
    ○ 菜单管理：维护系统菜单，操作权限，按钮权限
    ○ 角色管理：维护系统角色信息，以角色为单位分配系统权限
    ○ 日志管理：系统正常操作日志记录和查询；系统异常信息日志记录和查询
- 前端实例组件
    ○ 格栅
    ○ 按钮
    ○ 表单
    ○ 导航
    ○ 选项卡
    ○ 进度条
    ○ 面板
    ○ 通用弹出层
    ○ 时间日期
    ○ 数据表格
    ○ 分页

```

# 更新日志
## 2020-9-28 cloud_layui版本发布
# 版权声明
cloud_layui使用 Apache-2.0 License 协议.

# 演示截图

![菜单管理](https://img-blog.csdnimg.cn/20200928083219672.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2h1aXRpYW93dWRleXU=,size_16,color_FFFFFF,t_70#pic_center)

![日志管理](https://img-blog.csdnimg.cn/20200928083219676.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2h1aXRpYW93dWRleXU=,size_16,color_FFFFFF,t_70#pic_center)

![用户管理](https://img-blog.csdnimg.cn/20200928083219633.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2h1aXRpYW93dWRleXU=,size_16,color_FFFFFF,t_70#pic_center)

![登录页面](https://img-blog.csdnimg.cn/20200928083219276.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2h1aXRpYW93dWRleXU=,size_16,color_FFFFFF,t_70#pic_center)



