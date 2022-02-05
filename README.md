# realsense-cuda-opengl-docker
RealSense execution environment built on a Docker container on Ubuntu 20.04. NIVIDA GPU and OpenGL capable. CUADA 11.4.

## 1. docker build
```bash
$ git clone https://github.com/PINTO0309/realsense-cuda-opengl-docker.git \
&& cd realsense-cuda-opengl-docker \
&& docker build -t pinto0309/realsense-cuda-opengl-docker:latest .
```

## 2. docker pull
```bash
$ docker pull pinto0309/realsense-cuda-opengl-docker:latest
```

## 3. docker run
```bash
$ xhost +local: && \
docker run --gpus all -it --rm \
-v `pwd`:/home/user/workdir \
-v /tmp/.X11-unix/:/tmp/.X11-unix:rw \
--device /dev/video0:/dev/video0:mwr \
--device /dev/video1:/dev/video1:mwr \
--device /dev/video2:/dev/video2:mwr \
--device /dev/video3:/dev/video3:mwr \
--device /dev/video4:/dev/video4:mwr \
--device /dev/video5:/dev/video5:mwr \
--net=host \
-e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
-e DISPLAY=$DISPLAY \
--privileged \
pinto0309/realsense-cuda-opengl-docker:latest
```

## 4. Run **`realsense-viewer`**
```bash
$ realsense-viewer
```
![image](https://user-images.githubusercontent.com/33194443/152633195-2fc6e4bd-058e-4ae0-9a9e-8d223f3d96ba.png)

## 5. Run **`nvidia-smi`**
```
$ nvidia-smi

Sat Feb  5 07:49:13 2022       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 470.103.01   Driver Version: 470.103.01   CUDA Version: 11.4     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  NVIDIA GeForce ...  Off  | 00000000:01:00.0  On |                  N/A |
|  0%   44C    P8    15W / 220W |    310MiB /  7959MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
+-----------------------------------------------------------------------------+
```

## 6. Run **`glxgears`**
```bash
$ glxgears
```
![ezgif com-gif-maker (3)](https://user-images.githubusercontent.com/33194443/152633773-a25722fa-fd7d-4eb5-b23d-bf764cae46e9.gif)

## 7. Running from within WSL2
[Note] OpenGL will not work properly.

1. Perform the following initial settings.  
  [WSL2 USB Camera Jan 17, 2022 Edition](https://zenn.dev/pinto0309/articles/7c7ce81bea8b6c)
2. Start WSL2 (Windows Terminal).
```powershell
> wsl --list
Ubuntu-20.04 (default)

> wsl -d Ubuntu-20.04
```
3. USB attach. (Windows Terminal)
```powershell
> usbipd wsl list

BUSID DEVICE                                                       STATTE
1-1   Intel(R) RealSense(TM) Depth Camera 435 with RGB Module D... Not attached

> usbipd wsl attach --busid 1-1
```
4. docker run. (WSL2 Terminal)
```bash
$ docker pull pinto0309/realsense-cuda-opengl-docker:latest

$ xhost +local: && \
docker run --gpus all -it --rm \
-v `pwd`:/home/user/workdir \
-v /tmp/.X11-unix/:/tmp/.X11-unix:rw \
--device /dev/video0:/dev/video0:mwr \
--device /dev/video1:/dev/video1:mwr \
--device /dev/video2:/dev/video2:mwr \
--device /dev/video3:/dev/video3:mwr \
--device /dev/video4:/dev/video4:mwr \
--device /dev/video5:/dev/video5:mwr \
--net=host \
-e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
-e DISPLAY=$DISPLAY \
--privileged \
pinto0309/realsense-cuda-opengl-docker:latest

$ ls -l /dev/video*
xxxxxx 1 xxxx xxxx xx,xx,xx xx:xx /dev/video0
xxxxxx 1 xxxx xxxx xx,xx,xx xx:xx /dev/video1
xxxxxx 1 xxxx xxxx xx,xx,xx xx:xx /dev/video2
xxxxxx 1 xxxx xxxx xx,xx,xx xx:xx /dev/video3
xxxxxx 1 xxxx xxxx xx,xx,xx xx:xx /dev/video4
xxxxxx 1 xxxx xxxx xx,xx,xx xx:xx /dev/video5

$ sudo chmod 777 /dev/video*

$ nvidia-smi

Sat Feb  5 07:49:13 2022       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 470.103.01   Driver Version: 470.103.01   CUDA Version: 11.4     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  NVIDIA GeForce ...  Off  | 00000000:01:00.0  On |                  N/A |
|  0%   44C    P8    15W / 220W |    310MiB /  7959MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
+-----------------------------------------------------------------------------+
```

## 8. CUDA assisted librealsense container
```bash
$ docker pull pinto0309/realsense-cuda-opengl-docker:latest.cuda
```
or
```bash
$ git clone https://github.com/PINTO0309/realsense-cuda-opengl-docker.git \
&& cd realsense-cuda-opengl-docker \
&& docker build \
-t pinto0309/realsense-cuda-opengl-docker:latest.cuda \
-f Dockerfile.cudarealsense .
```
```bash
$ xhost +local: && \
docker run --gpus all -it --rm \
-v `pwd`:/home/user/workdir \
-v /tmp/.X11-unix/:/tmp/.X11-unix:rw \
--device /dev/video0:/dev/video0:mwr \
--device /dev/video1:/dev/video1:mwr \
--device /dev/video2:/dev/video2:mwr \
--device /dev/video3:/dev/video3:mwr \
--device /dev/video4:/dev/video4:mwr \
--device /dev/video5:/dev/video5:mwr \
--net=host \
-e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
-e DISPLAY=$DISPLAY \
--privileged \
pinto0309/realsense-cuda-opengl-docker:latest.cuda
```
