ARG cuda_version=8.0
ARG cudnn_version=6
FROM nvidia/cuda:${cuda_version}-cudnn${cudnn_version}-runtime-ubuntu16.04

ARG python_version=3.5
ARG conda_python_version=3
ARG conda_dir=/opt/conda

ENV PATH $conda_dir/bin:$PATH

#install prerequisities
RUN apt-get update && \
	apt-get install -y --no-install-recommends git wget ffmpeg unzip bzip2 sudo build-essential && \
	apt-get install -y libsm6 libxrender1 libfontconfig1 && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

#install miniconda
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates && \
	wget --quiet https://repo.continuum.io/miniconda/Miniconda$conda_python_version-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
	echo 'export PATH=$conda_dir/bin:$PATH' > /etc/profile.d/conda.sh && \
	/bin/bash /tmp/miniconda.sh -b -p $conda_dir && \
	rm -rf /tmp* && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN conda install -y --quiet python=$PYTHON_VERSION && \
	conda install -y \
	h5py \
	pandas \
	theano \
	jupyter \
	matplotlib \
	seaborn \
	scikit-learn \
	scikit-image \
	&& conda clean --yes --tarballs --packages --source-cache

RUN pip install --upgrade pip && \
	pip install --upgrade tensorflow-gpu keras joblib && \
	pip install --upgrade opencv-python

ENV CUDA_HOME=/usr/local/cuda
ENV CUDA_ROOT=$CUDA_HOME
ENV PATH=$PATH:$CUDA_ROOT/bin:$HOME/bin
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_ROOT/lib64

EXPOSE 8888

CMD jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token='password'
