ARG cuda_version=9.1 
ARG cudnn_version=7
#FROM nvidia/cuda:${cuda_version}-cudnn${cudnn_version}-runtime-ubuntu16.04
FROM nvidia/cuda:${cuda_version}-devel-ubuntu16.04

ENV CUDNN_VERSION=7.0.4.31

RUN apt-get update && apt-get install -y --no-install-recommends \
        libcudnn7=$CUDNN_VERSION-1+cuda9.0

ARG python_version=3.6
ARG conda_python_version=3
ARG conda_dir=/opt/conda

ENV PATH $conda_dir/bin:$PATH

#install prerequisities
RUN apt-get update && \
        apt-get install -y --no-install-recommends git wget sudo build-essential && \
	#apt-get install -y openssh-server && \
        apt-get install -y libsm6 libxrender1 libfontconfig1

#install miniconda
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates && \
        wget --quiet https://repo.continuum.io/miniconda/Miniconda$conda_python_version-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
        echo 'export PATH=$conda_dir/bin:$PATH' > /etc/profile.d/conda.sh && \
        /bin/bash /tmp/miniconda.sh -b -p $conda_dir && \
	conda update --all --yes && \
        rm -rf /tmp* && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*

RUN conda install -y --quiet python=$python_version && \
        conda install -y \
	h5py \
	pandas \
	jupyter \
	matplotlib \
	scipy \
        && conda clean --yes --tarballs --packages --source-cache

RUN pip install --upgrade pip \
	https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.6.0-cp36-cp36m-linux_x86_64.whl \
	tflearn

ENV CUDA_HOME=/usr/local/cuda
ENV CUDA_ROOT=$CUDA_HOME
ENV PATH=$PATH:$CUDA_ROOT/bin:$HOME/bin
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_ROOT/lib64

#RUN ( echo "#!/bin/bash"; \ 
#  echo ""; \ 
#  echo "service ssh start"; \ 
#  echo "tail -f /dev/null"; ) > /root/entrypoint.sh && \ 
#  chmod +x /root/entrypoint.sh && \ 
#  sed -i.bak 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \ 
#  echo "PermitUserEnvironment yes" >> /etc/ssh/sshd_config
#
#EXPOSE 22
#
#CMD ["/root/entrypoint.sh"]

EXPOSE 8888

CMD jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token='password'
