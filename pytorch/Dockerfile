ARG cuda_version=10.0
ARG cudnn_version=7
FROM nvidia/cuda:${cuda_version}-cudnn${cudnn_version}-devel-ubuntu16.04

#ARG python_version=3.6

#install prerequisities
RUN apt-get update && \
	apt-get install -y --no-install-recommends software-properties-common \
	build-essential \
	python3 \
	python3-dev \
	python3-pip \
	cmake \
	git \
	curl \
	wget \
	ca-certificates \
	libjpeg-dev \
	libpng-dev \
	libpcl-dev && \
	rm -rf /var/lib/apt/lists/*
	
RUN pip3 install --upgrade pip setuptools && \
        pip --no-cache-dir install https://download.pytorch.org/whl/cu100/torch-1.1.0-cp35-cp35m-linux_x86_64.whl \
	https://download.pytorch.org/whl/cu100/torchvision-0.3.0-cp35-cp35m-linux_x86_64.whl \
        h5py \
        mkl \
        Pillow \
        pandas \
        jupyter \
        matplotlib \
        scikit-learn \
        keras \
        joblib \
        opencv-python \
        lxml \
        html5lib \
        BeautifulSoup4 \
	scikit-learn \
	scikit-image \
        tqdm

ENV CUDA_HOME=/usr/local/cuda
ENV CUDA_ROOT=$CUDA_HOME
ENV PATH=$PATH:$CUDA_ROOT/bin:$HOME/bin
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_ROOT/lib64

EXPOSE 8888

CMD jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token='password'
