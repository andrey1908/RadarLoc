FROM nvcr.io/nvidia/cuda:10.2-cudnn8-devel

ENV DEBIAN_FRONTEND noninteractive

ARG NUM_THREADS=1

ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A4B469963BF863CC

RUN apt-get update && apt-get install -y \
    build-essential \
    python3 \
    python3-pip \
    python3-dev \
    vim \
    tmux \
    sudo \
    git \
    libopenblas-dev \
    ffmpeg \
    libsm6 \
    libxext6 && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade \
    setuptools \
    pip

RUN pip3 install \
    numpy \
    ninja \
    torch==1.10.1 \
    torchvision \
    torchaudio \
    pytorch_metric_learning \
    wandb \
    opencv-python

RUN export MAX_JOBS=$NUM_THREADS && \
    pip3 install -U MinkowskiEngine --install-option="--blas=openblas" -v --no-deps

 # User setup
ARG USER=docker_radar_loc
ARG UID=1000
ARG GID=1000
ARG PW=user

# Add user and his password
RUN useradd -m ${USER} --uid=${UID} && \
    echo "${USER}:${PW}" | chpasswd && \
    usermod -s /bin/bash ${USER} && \
    usermod -a -G sudo ${USER}

ENV PYTHONPATH=$PYTHONPATH:/home/${USER}/RadarLoc

WORKDIR /home/${USER}
USER ${UID}:${GID}