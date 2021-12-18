FROM ros:noetic-perception

ARG UNAME=ros
ARG UID=1000
ARG GID=1000

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ros-${ROS_DISTRO}-desktop-full \
    ros-${ROS_DISTRO}-panda-moveit-config \
    ros-${ROS_DISTRO}-moveit-commander \
    dbus-x11 \
    terminator \
    vim && \
    rm -rf /var/lib/apt/lists/*

# CS427 Additions: Navigation stack + Turtlebot3 simulation packages
RUN apt-get update && apt-get install -y \
	ros-${ROS_DISTRO}-turtlebot3-slam \
	ros-${ROS_DISTRO}-slam-gmapping \
	ros-${ROS_DISTRO}-turtlebot3-gazebo \
	ros-${ROS_DISTRO}-turtlebot3-navigation \
	ros-${ROS_DISTRO}-dwa-local-planner && \
	rm -rf /var/lib/apt/lists/*

COPY planning_context.launch /opt/ros/noetic/share/panda_moveit_config/launch

RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -G sudo -o -s /bin/bash $UNAME && echo "$UID:$GID" && echo "$UNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER $UNAME

RUN echo source "/opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
RUN echo "export TURTLEBOT3_MODEL=waffle" >> ~/.bashrc

CMD ["terminator"]
