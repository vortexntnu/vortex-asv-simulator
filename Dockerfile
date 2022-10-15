FROM ros:melodic

ARG distro=melodic
SHELL ["/bin/bash", "-c"] 

# Create vortex user (required for GUI)
RUN useradd -ms /bin/bash \
    --home /home/vortex  vortex
RUN echo "vortex:vortex" | chpasswd
RUN usermod -aG sudo vortex

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

COPY . /sim_ws/src
RUN source /opt/ros/melodic/setup.bash && cd /sim_ws && catkin build

COPY entrypoint.sh /
CMD ["/entrypoint.sh"]