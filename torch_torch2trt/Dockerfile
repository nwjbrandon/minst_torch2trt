FROM nvcr.io/nvidia/deepstream:5.0.1-20.09-triton

WORKDIR /app

RUN apt update && apt upgrade -y

RUN apt install python3-dev -y

RUN pip3 install --upgrade pip

RUN pip3 install torch torchvision matplotlib scipy opencv-python notebook scikit-learn seaborn pandas numpy

RUN git clone https://github.com/NVIDIA-AI-IOT/torch2trt.git

RUN cd torch2trt && python3 setup.py install --plugins
