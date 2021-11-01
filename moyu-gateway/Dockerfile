#获取base image
FROM adoptopenjdk/openjdk8:latest 
MAINTAINER goodym 11184629@qq.com

#类似于linux copy指令
COPY moyu-gateway-1.0.0.jar /opt/app/layuicloud/       
#对外端口
EXPOSE 7000
#执行命令 java -jar /opt/app/layuicloud/moyu-gateway-1.0.0.jar
ENTRYPOINT ["java","-Xmx256m", "-jar", "/opt/app/layuicloud/moyu-gateway-1.0.0.jar","--spring.profiles.active=dev","-c"]
