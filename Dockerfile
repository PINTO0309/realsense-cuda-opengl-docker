FROM nvidia/cudagl:11.4.2-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

ARG WKDIR=/home/user
WORKDIR ${WKDIR}

RUN apt-get update \
    && apt-get install -y \
        gnupg lsb-release lsb-core \
        software-properties-common \
    && apt-key adv \
        --keyserver keyserver.ubuntu.com \
        --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || \
        apt-key adv \
        --keyserver hkp://keyserver.ubuntu.com:80 \
        --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE \
    && add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u \
    && apt-get install -y --install-recommends \
        libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev \
        automake autoconf libpng-dev nano python3-pip \
        curl zip unzip libtool swig zlib1g-dev pkg-config \
        python3-mock libpython3-dev libpython3-all-dev \
        g++ gcc cmake make pciutils cpio gosu wget udev \
        libgtk-3-dev libxtst-dev sudo apt-transport-https \
        build-essential gnupg git xz-utils vim libyaml-cpp-dev \
        libva-drm2 libva-x11-2 vainfo libva-wayland2 libva-glx2 \
        libva-dev libdrm-dev xorg xorg-dev protobuf-compiler \
        openbox libx11-dev libgl1-mesa-glx libgl1-mesa-dev \
        libtbb2 libtbb-dev libopenblas-dev libopenmpi-dev \
        python-is-python3 libusb-1.0-0-dev libssl-dev \
        librealsense2-dkms librealsense2-utils \
        librealsense2-dev librealsense2-dbg \
        librealsense2-gl librealsense2-gl-dev librealsense2-gl-dbg \
    && pip install pip --upgrade \
    && sed -i 's/# set linenumbers/set linenumbers/g' /etc/nanorc \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

ENV USERNAME=user
RUN echo "root:root" | chpasswd \
    && adduser --disabled-password --gecos "" "${USERNAME}" \
    && adduser ${USERNAME} video \
    && echo "${USERNAME}:${USERNAME}" | chpasswd \
    && echo "%${USERNAME}    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}
USER ${USERNAME}
RUN sudo chown ${USERNAME}:${USERNAME} ${WKDIR} \
    && echo "export LIBGL_ALWAYS_INDIRECT=1" >> ${WKDIR}/.bashrc \
    && echo "export QT_X11_NO_MITSHM=1" >> ${WKDIR}/.bashrc \
    && echo "export QT_XCB_NO_MITSHM=1" >> ${WKDIR}/.bashrc \
    && echo "export XLIB_NO_SHM=1" >> ${WKDIR}/.bashrc \
    && echo "cd ${WKDIR}/workdir" >> ${WKDIR}/.bashrc