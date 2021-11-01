# 第1章 自定义网络

## 1.1 创建自定义网络

创建自定义网络命令：docker network create

```shell
docker network create --driver bridge xueden
```

> 解析
>
>  --driver bridge 表示使用桥接模式 
>
>  xueden 表示网络名 

## 1.2 查看所有的docker网络

如下命令：

```shell
docker network ls
```



## 1.3 查看自己定义的网络相关信息

如下命令：

```shell
docker network inspect xueden
```



# 第2章 安装mysql5.7

## 2.1 拉取mysql镜像

```shell
docker pull mysql:5.7
```



## 2.2 运行mysql容器

```shell
docker run -p 3306:3306 --name mysql \
-v /data/mysql/log:/var/log/mysql \
-v /data/mysql/data:/var/lib/mysql \
-v /data/mysql/conf:/etc/mysql \
-e MYSQL_ROOT_PASSWORD=root \
--net xueden \
--restart always \
-d mysql:5.7
```

>注意，如果有端口被占用，如下操作
>
>查看端口号： netstat -tanlp 
>
> 杀死进程(注意不是杀死端口，而是pid的端口) ： kill 1785进程 (自己的pid端口) 
>
>

## 2.3 配置mysql

先创建  my.cnf 文件，输入命令：

```shell
cd /data/mysql/conf
```

```shell
vi my.cnf
```

复制以下内容：

```shell
[client]
default-character-set=utf8
[mysql]
default-character-set=utf8
[mysqld]
init_connect='SET collation_connection = utf8_unicode_ci'
init_connect='SET NAMES utf8'
character-set-server=utf8
collation-server=utf8_unicode_ci
skip-character-set-client-handshake
skip-name-resolve
```



保存退出，重启mysql容器即可：

```shell
docker restart mysql
```



# 第3章 安装nacos

## 3.1 拉取nacos镜像

```shell
docker pull nacos/nacos-server
```

## 3.2 运行nacos容器

```shell
docker run  -d \
--network xueden \
-e MODE=standalone \
-e SPRING_DATASOURCE_PLATFORM=mysql \
-e MYSQL_SERVICE_HOST=192.168.56.12 \
-e MYSQL_SERVICE_PORT=3306 \
-e MYSQL_SERVICE_USER=root \
-e MYSQL_SERVICE_PASSWORD=root \
-e MYSQL_SERVICE_DB_NAME=nacos_xueden \
-p 8848:8848 \
--name nacos \
--restart=always \
nacos/nacos-server
```



# 第4章 安装redis

## 4.1 拉取redis镜像

```shell
docker pull redis
```



## 4.2 运行redis容器

```shell
docker run -p 6379:6379 --name redis -v /data/redis/data:/data \
-v /data/redis/conf/redis.conf:/etc/redis/redis.conf \
-d redis redis-server /etc/redis/redis.conf 
```



# 第5章 安装 sentinel-dashboard 



 Sentinel 控制台是流量控制、熔断降级规则统一配置和管理的入口，它为用户提供了机器自发现、簇点链路自发现、监控、规则配置等功能。在 Sentinel 控制台上，我们可以配置规则并实时查看流量控制效果。 

## 5.1 sentinel-dashboard 

使用如下命令拉取镜像

```shell
docker pull bladex/sentinel-dashboard
```



## 5.2 启动sentinel-dashboard 



```shell
docker run --name sentinel --network xueden  -d -p 8858:8858 -d  bladex/sentinel-dashboard
```

默认账号和密码都是：sentinel

sentinel官方文档：

 [https://github.com/alibaba/Sentinel/wiki/%E4%B8%BB%E9%A1%B5](https://github.com/alibaba/Sentinel/wiki/主页) 



# 第6章 安装网关微服务moyu-gateway



## 6.1 拉取网关微服务moyu-gateway镜像

```shell
docker pull goodym/moyu-gateway:1.0
```



## 6.2 运行网关微服务

```shell
docker run --network xueden --restart always --name gateway -it -p 7000:7000 goodym/moyu-gateway:1.0
```

