help:
	@cat Makefile

DATA?=${HOME}/Dataset
SRC?=${HOME}/Work

GPU?=0
DOCKER_FILE=Dockerfile
DOCKER=NV_GPU=$(GPU) nvidia-docker
BACKEND=tensorflow
PYTHON_VERSION?=3.6
CUDA_VERSION?=10.0
CUDNN_VERSION?=7


buildkeras:
	docker build --build-arg python_version=${PYTHON_VERSION} --build-arg cuda_version=${CUDA_VERSION} --build-arg cudnn_version=${CUDNN_VERSION} --tag keras-jupyter -f keras/$(DOCKER_FILE) .

buildpytorch:
	docker build --build-arg python_version=${PYTHON_VERSION} --build-arg cuda_version=${CUDA_VERSION} --build-arg cudnn_version=${CUDNN_VERSION} --tag pytorch-jupyter -f pytorch/$(DOCKER_FILE) .

builduniverse:
	docker build -t universe -f universe/$(DOCKER_FILE) .

buildros:
	docker build -t ros-kinetic -f ros/$(DOCKER_FILE) .

buildtflearn:
	docker build --build-arg python_version=3.6 --build-arg cuda_version=9.0 --build-arg cudnn_version=7 --tag tflearn-jupyter -f tflearn/$(DOCKER_FILE) .


keras: buildkeras
	$(DOCKER) run -d -p 60088:8888 -v $(SRC):/workspace -v $(DATA):/data -w /workspace keras-jupyter

pytorch: buildpytorch
	$(DOCKER) run -d --name pytorch-jupyter -p 8888:8888 -v $(SRC):/workspace -v $(DATA):/data -w /workspace pytorch-jupyter

universe: builduniverse
	$(DOCKER) run --privileged --rm -e DOCKER_NET_HOST=172.17.0.1 -v /var/run/docker.sock:/var/run/docker.sock universe pytest

ros: buildros
	$(DOCKER) run -it -p 11311:11311 -v $(SRC):/workspace ros-kinetic 

tflearn: buildtflearn
	$(DOCKER) run -d -p 8889:8888 -v $(SRC):/workspace -v $(DATA):/data -w /workspace tflearn-jupyter 

sharelatex:
	docker run -d -p 5000:80 -v $(DATA)/sharelatex_data:/var/lib/sharelatex --name=sharelatex sharelatex/sharelatex
