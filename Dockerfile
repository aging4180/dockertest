FROM python:3.11.6
WORKDIR /
COPY . .

# RUN apt-get install libstdc++6

RUN pip install -r requirements.txt -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com

EXPOSE 3000

LABEL author="f"
LABEL email="f@gmail.com"

ENTRYPOINT ["python", "/main.py"]
