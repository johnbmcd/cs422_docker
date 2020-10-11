FROM ros:melodic-perception

ARG UNAME=ros
ARG UID=1000
ARG GID=1000

RUN apt-get update && apt-get install -y \
    ros-${ROS_DISTRO}-desktop-full \
    ros-${ROS_DISTRO}-panda-moveit-config \
    dbus-x11 \
    terminator && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME
USER $UNAME

RUN echo source "/opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc

CMD ["terminator"]
