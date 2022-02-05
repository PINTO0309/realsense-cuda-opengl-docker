# realsense-cuda-opengl-docker
## 1. docker build
```bash
git clone https://github.com/PINTO0309/realsense-cuda-opengl-docker.git
cd realsense-cuda-opengl-docker
docker build -t realsense-cuda-opengl-docker:latest .
```

## 2. docker pull
```bash
docker pull ghcr.io/pinto0309/realsense-cuda-opengl-docker:latest
```

## 3. docker run
```bash
xhost +local: && \
docker run --gpus all -it --rm \
-v `pwd`:/home/user/workdir \
-v /tmp/.X11-unix/:/tmp/.X11-unix:rw \
--device /dev/video0:/dev/video0:mwr \
--device /dev/video0:/dev/video1:mwr \
--device /dev/video0:/dev/video2:mwr \
--device /dev/video0:/dev/video3:mwr \
--device /dev/video0:/dev/video4:mwr \
--device /dev/video0:/dev/video5:mwr \
--net=host \
-e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
-e DISPLAY=$DISPLAY \
--privileged \
ghcr.io/pinto0309/realsense-cuda-opengl-docker:latest
```

## 4. Run **`realsense-viewer`**
```bash
realsense-viewer
```
![image](https://user-images.githubusercontent.com/33194443/152633195-2fc6e4bd-058e-4ae0-9a9e-8d223f3d96ba.png)

## 5. Run **`nvidia-smi`**
```
nvidia-smi

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
