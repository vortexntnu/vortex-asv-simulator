FROM ros:melodic

ARG distro=melodic

# Create vortex user
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

RUN echo "source /opt/ros/melodic/setup.bash" >> /home/vortex/.bashrc
RUN echo "source /home/vortex/sim_ws/devel/setup.bash" >> /home/vortex/.bashrc

RUN mkdir -p /home/vortex/sim_ws
RUN chown vortex /home/vortex/sim_ws

CMD ["/bin/bash"]