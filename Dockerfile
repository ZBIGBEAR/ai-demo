# 使用官方的 Python 3.12 基础镜像
#FROM python:3.12-slim
FROM --platform=linux/amd64 python:3.12-slim

# 设置工作目录
WORKDIR /app

# 将所有文件都复制到工作目录
COPY . .

# 安装 Python 依赖
# COPY requirements.txt .
# RUN pip3 install --no-cache-dir -r requirements.txt
RUN pip3 install -r requirements.txt
# 确保 Langchain 被安装
# RUN pip install langchain

# 复制 Python 脚本并运行它
#COPY your_script.py .
#RUN python your_script.py

# 修改镜像源(如果访问不了http://deb.debian.org/debian，可以修改镜像源)
#RUN sed -i 's/http:\/\/deb.debian.org/http:\/\/mirrors.aliyun.com/g' /etc/apt/sources.list && \
#    sed -i 's/http:\/\/security.debian.org/http:\/\/mirrors.aliyun.com/g' /etc/apt/sources.list

# 更新包列表并安装 curl 和其他依赖
#RUN apt-get update && apt-get install -y \
#    curl \
#    gnupg \
#    lsb-release \
#    build-essential

# 设置 NodeSource 存储库并安装 Node.js 和 npm
#RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
#    apt-get install -y nodejs


# 安装 Node.js 和 npm，因为 PM2 需要它们
#RUN apt-get update && apt-get install -y nodejs npm

# 全局安装 PM2
#RUN npm install -g pm2

# 安装 Go
# RUN curl -LO https://dl.google.com/go/go1.20.3.linux-amd64.tar.gz && \
#    tar -xvf go1.20.3.linux-amd64.tar.gz && \
#    sudo mv go /usr/local && \
#    export PATH=$PATH:/usr/local/go/bin && \
#    rm go1.20.3.linux-amd64.tar.gz

# 安装 Go 1.20.3
#RUN curl -LO https://golang.org/dl/go1.22.1.linux-amd64.tar.gz && \
#    tar -C /usr/local -xzf go1.20.3.linux-amd64.tar.gz && \
#    rm go1.20.3.linux-amd64.tar.gz
#
## 设置 Go 环境变量
#ENV GOPATH=/go
#ENV PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

# 安装 Go 1.20.3
#RUN curl -LO https://golang.org/dl/go1.22.1.linux-arm64.tar.gz && \
#    tar -C /usr/local -xzf go1.22.1.linux-arm64.tar.gz && \
#    rm go1.22.1.linux-arm64.tar.gz

RUN tar -C /usr/local -xzf go1.22.1.linux-amd64.tar.gz

# 设置 Go 环境变量
ENV GOPATH=/go
ENV PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

# 设置 GOPATH 和 GOROOT（可选）
ENV GOPATH /go
ENV GOROOT /usr/local/go
ENV PATH $PATH:$GOPATH/bin:/usr/local/go/bin

# 复制 Go 程序源代码
#COPY main.go .

# 编译 Go 程序
# RUN go build -o main main.go

# 假设你有一个方式将 Go 程序与 PM2 集成（例如，通过一个 Node.js 脚本来启动 Go 程序）
# 创建一个示例的 Node.js 脚本来启动 Go 程序（这是一个假设的例子）
#COPY start_go_with_pm2.js .

EXPOSE 8080
# 使用 PM2 启动 Node.js 脚本（这间接启动了 Go 程序）
#CMD ["pm2-runtime", "start", "socket.json"]

# 如果你不需要 PM2，只需运行编译后的 Go 程序
CMD ["go run main.go"]