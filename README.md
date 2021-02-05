## Docker Playground

### Setup
- Install docker
- Build docker image
```
docker build -t ws .
```

### Run
- Run docker iteractly
```
nvidia-docker run --shm-size=16g --ulimit memlock=-1 --ulimit stack=67108864 -v ~/minst_torch2trt:/app -p 8888:8888 -it ws bash
```
- Start jupyter notebook
```
jupyter notebook --ip='*' --NotebookApp.token='' --NotebookApp.password='' --allow-root
```
