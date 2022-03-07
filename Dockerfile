FROM ros:melodic

ARG distro=melodic
ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"] 

RUN apt-get update && apt-get install -y python-catkin-tools

RUN apt-get update && apt-get install -y \ 
    libgazebo9-dev \
    ros-$distro-gazebo-plugins
 
RUN apt-get update && apt-get install -y \ 
    ros-$distro-geographic-msgs \
    ros-$distro-imu-filter-madgwick \
    ros-$distro-xacro \
    ros-$distro-lms1xx \
    ros-$distro-robot-state-publisher \
    ros-$distro-uuv-assistants

RUN apt-get update && apt-get install -y \
    ros-$distro-uuv* \
    ros-$distro-heron*

COPY . /simulator_ws/src
RUN source /opt/ros/$distro/setup.bash && cd /simulator_ws && catkin build

COPY entrypoint.sh /
CMD ["/entrypoint.sh"]