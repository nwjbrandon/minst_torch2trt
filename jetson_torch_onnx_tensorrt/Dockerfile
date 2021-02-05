FROM nvcr.io/nvidia/deepstream-l4t:5.0.1-20.09-iot
# Pip
RUN apt update && apt upgrade -y
RUN apt install python3-pip python3-dev libxml2-dev libxslt-dev -y
RUN pip3 install --upgrade pip
RUN pip3 install setuptools==53.0.0
### Torch
RUN apt install libopenmpi2 libopenblas-base -y
RUN pip3 install cython==0.29.21
RUN wget https://nvidia.box.com/shared/static/cs3xn3td6sfgtene6jdvsxlr366m2dhq.whl -O torch-1.7.0-cp36-cp36m-linux_aarch64.whl
RUN pip3 install torch-1.7.0-cp36-cp36m-linux_aarch64.whl
# https://forums.developer.nvidia.com/t/illegal-instruction-core-dumped/165488/8
RUN pip3 install numpy==1.19.4
### Torchvision
RUN apt install libjpeg-dev zlib1g-dev -y
RUN git clone -b v0.8.0 https://github.com/pytorch/vision torchvision
RUN cd torchvision && python3 setup.py install
### Cmake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.19.5/cmake-3.19.5-Linux-aarch64.sh \
      -q -O /tmp/cmake-install.sh \
      && chmod u+x /tmp/cmake-install.sh \
      && mkdir /usr/bin/cmake \
      && /tmp/cmake-install.sh --skip-license --prefix=/usr/bin/cmake \
      && rm /tmp/cmake-install.sh
ENV PATH="/usr/bin/cmake/bin:${PATH}"
### Python Libraries
RUN pip3 install cmake==3.18.4.post1
RUN pip3 install protobuf==3.14.0
RUN apt install protobuf-compiler libprotoc-dev libgl1-mesa-glx -y
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
### Onnx2TRT
RUN apt install libprotobuf-dev protobuf-compiler -y
# https://github.com/onnx/onnx-tensorrt/pull/340/files
RUN git clone https://github.com/onnx/onnx-tensorrt && \
      cd onnx-tensorrt && \
      git checkout release/7.1 && \
      git submodule init && \
      git submodule update && \
      cmake . -DCUDA_INCLUDE_DIRS=/usr/local/cuda/include -DTENSORRT_ROOT=/usr/src/tensorrt -DGPU_ARCHS="53" && \
      make && \
      make install
WORKDIR /workspace