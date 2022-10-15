FROM alpine
MAINTAINER ffy professor-fu@139.com

# add 清华源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories

# install git && ssh
RUN apk update && apk add git && apk add openssh

# init ssh
RUN mkdir ~/.ssh \
    && touch ~/.ssh/id_rsa \
    && chmod 600 ~/.ssh/id_rsa \
    && touch ~/.ssh/id_rsa.pub \
    && chmod 644 ~/.ssh/id_rsa.pub

# sert timezone
RUN apk add tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' > /etc/timezone \
    && apk del tzdata

# 将这两个密钥文件映射到host主机上的匿名卷, 以确保数据不会丢失; 密钥文件在clone私有仓库使使用
VOLUME ["~/.ssh/id_rsa","~/.ssh/id_rsa.pub"]

# set git clone default dir 确保pull下来的文件持久保存
WORKDIR /git/repo
VOLUME ["/git/repo"]

