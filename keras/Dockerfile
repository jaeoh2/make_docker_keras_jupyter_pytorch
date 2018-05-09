ARG cuda_version=9.0
ARG cudnn_version=7
#FROM nvidia/cuda:${cuda_version}-cudnn${cudnn_version}-devel-ubuntu16.04
FROM nvidia/cuda:${cuda_version}-runtime-ubuntu16.04
ENV CUDNN_VERSION 7.0.5.15

RUN apt-get update && \
	apt-get install -y --no-install-recommends \
	libcudnn7=$CUDNN_VERSION-1+cuda9.0

ARG python_version=3.6
ARG conda_python_version=3
ARG conda_dir=/opt/conda

ENV PATH $conda_dir/bin:$PATH

#install prerequisities
RUN apt-get update && \
	apt-get install -y --no-install-recommends \
	git \
	wget \
	ffmpeg \
	unzip \
	bzip2 \
	build-essential \
	libsm6 \
	libxrender1 \
	libfontconfig1 \
	python3 \
	python3-dev \
	python3-pip \
	&& \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip setuptools && \
	pip --no-cache-dir install tensorflow_gpu \
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
	tqdm

ENV CUDA_HOME=/usr/local/cuda
ENV CUDA_ROOT=$CUDA_HOME
ENV PATH=$PATH:$CUDA_ROOT/bin:$HOME/bin
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_ROOT/lib64

EXPOSE 8888

CMD jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token='password'
