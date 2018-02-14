# make_docker_keras_jupyter_pytorch
Fork of https://github.com/keras-team/keras/tree/master/docker .  
This directory contains Dockerfile to make it easy to get up and running with Keras,jupyter,pytorch via Docker.

### Install Prerequisites
  [Docker Ubuntu](https://docs.docker.com/install/linux/docker-ee/ubuntu/)  
  [nvidia-docker](https://github.com/NVIDIA/nvidia-docker)

### Build and run keras with jupyter
    $ make keras
  
### Build and run pytorch with jupyter
    $ make pytorch

### Build and run pytorch with python 3.5, CUDA9.0 and CUDNN7
    $ make pytorch PYTHON_VERSION=3.5 CUDA_VERSION=9.0 CUDNN_VERSION=7

### Build and run pytorch with python 3.5, CUDA8.0 and CUDNN6
    $ make pytorch PYTHON_VERSION=3.5 CUDA_VERSION=8.0 CUDNN_VERSION=6
