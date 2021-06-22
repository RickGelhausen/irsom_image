# FROM python:3.6-slim
#
# RUN apt-get update && apt-get install -y git cudatoolkit \
#  && cd home \
#  && git clone https://forge.ibisc.univ-evry.fr/lplaton/IRSOM.git \
#  && rm -rf IRSOM/model \
#  && chmod +x IRSOM/scripts/predict.py \
#  && apt-get remove -y git \
#  && rm -rf /var/lib/apt/lists/*
#
# run pip3 install --no-cache --upgrade pip setuptools docopt numpy pandas matplotlib plotnine tensorflow
#
# RUN python3 ./home/IRSOM/scripts/predict.py
# ENTRYPOINT ["./home/IRSOM/scripts/predict.py"]

FROM tensorflow/tensorflow:2.4.2-gpu

RUN apt-get update && apt-get install -y git \
  && cd home \
  && git clone https://forge.ibisc.univ-evry.fr/lplaton/IRSOM.git \
  && rm -rf IRSOM/model \
  && sed -i '1i #!/usr/bin/python3' IRSOM/scripts/predict.py \
  && chmod +x IRSOM/scripts/predict.py \
  && apt-get remove -y git \
  && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache --upgrade pip docopt matplotlib pandas plotnine
RUN ./home/IRSOM/scripts/predict.py -h
ENTRYPOINT ["./home/IRSOM/scripts/predict.py"]

# FROM ubuntu:20.04
#
# ENV TZ=Europe/Berlin
# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
#
# RUN apt-get update && apt-get install -y software-properties-common nvidia-cuda-toolkit \
#     && rm -rf /var/lib/apt/lists/*
#
# RUN python3 --version
#
# run pip3 install --no-cache --upgrade pip setuptools docopt numpy pandas matplotlib plotnine tensorflow
