FROM python:3.12-alpine

WORKDIR /

# 安装 opencc 所需依赖
RUN apk add --no-cache cmake 
# 拷贝项目文件
COPY . .

# 安装 Python 依赖（含 opencc），使用阿里云镜像源
RUN pip install --no-cache-dir -r requirements.txt

RUN python -c "from opencc import OpenCC; print(OpenCC('s2t').convert('测试'))"

EXPOSE 3000

LABEL author="f"
LABEL email="f@gmail.com"

ENTRYPOINT ["python", "/main.py"]
