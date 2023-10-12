FROM osrf/ros:noetic-desktop-full

RUN apt-get update && apt-get install -y \
    git cmake vim \
    gnutls-bin \
    python3-catkin-tools

RUN git config --global http.sslVerify false && \
    git config --global http.postBuffer 1048576000

RUN git clone https://github.com/Livox-SDK/Livox-SDK.git /Livox-SDK && \
    cd /Livox-SDK && \
    cd build && \
    cmake .. && \
    make && \
    make install
    
RUN mkdir /ROS_WS && \
    cd /ROS_WS && \
    mkdir src && \
    catkin init && \
    cd src && \
    git clone https://github.com/Livox-SDK/livox_ros_driver.git && \
    git clone https://github.com/hku-mars/FAST_LIO.git

RUN cd /ROS_WS/src/FAST_LIO && \
    git submodule update --init

RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; cd /ROS_WS; catkin build'
