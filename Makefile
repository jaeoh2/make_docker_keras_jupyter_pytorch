help:
	@cat Makefile

DATA?=${HOME}/Data
SRC?=${HOME}/Work

GPU?=0
DOCKER_FILE=Dockerfile
DOCKER=NV_GPU=$(GPU) nvidia-docker
BACKEND=tensorflow
PYTHON_VERSION?=3.5
CUDA_VERSION?=8.0
CUDNN_VERSION?=6


buildkeras:
	docker build --build-arg python_version=${PYTHON_VERSION} --build-arg cuda_version=${CUDA_VERSION} --build-arg cudnn_version=${CUDNN_VERSION} --tag keras-jupyter -f keras/$(DOCKER_FILE) .

buildpytorch:
	docker build --build-arg python_version=${PYTHON_VERSION} --build-arg cuda_version=${CUDA_VERSION} --build-arg cudnn_version=${CUDNN_VERSION} --tag pytorch-jupyter -f pytorch/$(DOCKER_FILE) .

keras: buildkeras
	$(DOCKER) run -d -p 60088:8888 -v $(SRC):/workspace -v $(DATA):/data -w /workspace keras-jupyter

pytorch: buildpytorch
	$(DOCKER) run -d -p 60089:8888 -v $(SRC):/workspace -v $(DATA):/data -w /workspace pytorch-jupyter
