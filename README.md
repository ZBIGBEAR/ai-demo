# docker运行
```azure
# 构建Docker镜像
docker build -t ai.1.0

# 后台运行Docker镜像
docker run -itd -p 8080:8080 ai.1.0
```

# docker compose运行
```azure
# 后台启动
docker-compose up -d

# 停止
docker-compose down
```