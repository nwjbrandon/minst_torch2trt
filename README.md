## Docker Playground

### Setup
- Install docker
- Build docker image
```
docker build -t ws .
```

### Run
- Enable access to the CUDA compiler (nvcc) during docker build operations by adding "default-runtime": "nvidia" to your /etc/docker/daemon.json configuration file before attempting to build the containers [nvidia runtime](https://github.com/dusty-nv/jetson-containers#docker-default-runtime): 
```
{
    "runtimes": {
        "nvidia": {
            "path": "nvidia-container-runtime",
            "runtimeArgs": []
        }
    },

    "default-runtime": "nvidia"
}
```
- Open GUI from docker
```
xhost +
```
- Run docker iteractly
```
sudo docker run --net=host --rm --runtime nvidia  --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" -v ~/ws:/ws -v /dev:/dev  -it ws bash
```
- Start jupyter notebook
```
jupyter notebook --ip='*' --NotebookApp.token='' --NotebookApp.password='' --allow-root
```
