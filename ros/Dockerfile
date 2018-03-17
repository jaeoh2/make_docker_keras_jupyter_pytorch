FROM ubuntu:16.04
ARG distro=xenial

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Setup sources.lst
RUN echo "deb http://packages.ros.org/ros/ubuntu $distro main" > /etc/apt/sources.list.d/ros-latest.list

# Setup keys
RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116


#install prerequisities
RUN apt-get update && \
	apt-get install ros-kinetic-desktop-full -y && \
	apt-get install python-rosdep -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN c_rehash /etc/ssl/certs

RUN rosdep init

RUN rosdep update

RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc

RUN source ~/.bashrc

RUN apt-get update && \
	apt-get install python-rosinstall python-rosinstall-generator python-wstool build-essential -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*
	

EXPOSE 11311
