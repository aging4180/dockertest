# 构建阶段：只构建依赖
FROM python:3.12-alpine as builder
WORKDIR /build
RUN apk add --no-cache build-base cmake git opencc opencc-dev zlib-dev
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# 运行阶段：复制代码 & 依赖

FROM python:3.12-alpine
WORKDIR /
COPY --from=builder /usr/lib/python3.12/site-packages /usr/lib/python3.12/site-packages
# 拷贝项目文件
COPY . .

RUN python -c "from opencc import OpenCC; print(OpenCC('s2t').convert('测试'))"

EXPOSE 3000

LABEL author="f"
LABEL email="f@gmail.com"

ENTRYPOINT ["python", "/main.py"]
