FROM nvcr.io/nvidia/deepstream-l4t:5.1-21.02-iot

WORKDIR /workspace
RUN apt update && apt upgrade -y

### Install cmake
WORKDIR /workspace
RUN wget https://github.com/Kitware/CMake/releases/download/v3.19.5/cmake-3.19.5-Linux-aarch64.sh -q -O /tmp/cmake-install.sh 
RUN chmod u+x /tmp/cmake-install.sh
RUN mkdir /usr/bin/cmake 
RUN /tmp/cmake-install.sh --skip-license --prefix=/usr/bin/cmake 
RUN rm /tmp/cmake-install.sh
ENV PATH="/usr/bin/cmake/bin:${PATH}"

### Install pip3
RUN apt install python3-pip python3-dev -y
RUN pip3 install --upgrade pip

### Install protoc
WORKDIR /workspace
RUN apt install unzip -y
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v3.17.3/protoc-3.17.3-linux-aarch_64.zip
RUN unzip protoc-3.17.3-linux-aarch_64.zip  -d /workspace/protoc-3.17.3/
RUN cp /workspace/protoc-3.17.3/bin/protoc /usr/local/bin/protoc

### Install protobuf
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v3.17.3/protobuf-python-3.17.3.zip
RUN unzip protobuf-python-3.17.3.zip  -d /workspace
WORKDIR /workspace/protobuf-3.17.3
RUN apt-get install autoconf autogen -y
RUN apt-get install libtool libtool-bin -y
RUN ./autogen.sh 
RUN ./configure --prefix=/usr/local 
RUN make -j$(nproc) 
RUN make install
RUN ldconfig
RUN pip3 install Cython
WORKDIR /workspace/protobuf-3.17.3/python
RUN python3 setup.py build --cpp_implementation 
RUN python3 setup.py test --cpp_implementation 
RUN python3 setup.py install --cpp_implementation 

### Install tensorflow
WORKDIR /workspace
RUN apt install libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran -y
RUN pip3 install testresources setuptools==49.6.0
RUN pip3 install numpy==1.18.5
RUN apt install pkg-config libhdf5-100 libhdf5-dev -y
RUN pip3 install future==0.18.2 mock==3.0.5 h5py==2.10.0 keras_preprocessing==1.1.1 keras_applications==1.0.8 gast==0.2.2 futures pybind11
RUN pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v45 'tensorflow<2'

### Install tensorflow models dependencies 
WORKDIR /workspace
RUN pip3 install Pillow==8.1.0 lxml==4.6.3 notebook==6.4.0 matplotlib==3.3.1
RUN pip3 install opencv-python==4.5.1.48
RUN pip3 install numpy==1.18.5

### Install onnxruntime (download whl file: https://elinux.org/Jetson_Zoo#ONNX_Runtime)
WORKDIR /workspace
RUN apt install -y --no-install-recommends build-essential software-properties-common libopenblas-dev libpython3.6-dev
ENV CUDACXX "/usr/local/cuda/bin/nvcc"
ENV PATH "${PATH}:/usr/local/cuda/bin"
COPY onnxruntime_gpu-1.6.0-cp36-cp36m-linux_aarch64.whl .
RUN pip3 install onnxruntime_gpu-1.6.0-cp36-cp36m-linux_aarch64.whl
RUN pip3 install onnx==1.9.0
RUN pip3 install tf2onnx==1.6.3

### Install realsense
RUN apt install libssl-dev libusb-1.0-0-dev pkg-config -y
RUN apt install libgtk-3-dev libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev -y
RUN apt install qtcreator -y
WORKDIR /workspace
RUN git clone https://github.com/IntelRealSense/librealsense.git
WORKDIR /workspace/librealsense
RUN git checkout v2.47.0
RUN mkdir build
WORKDIR /workspace/librealsense/build
RUN cmake ../ -DBUILD_PYTHON_BINDINGS:bool=true -DBUILD_WITH_CUDA=true
RUN make -j2
RUN make install
ENV PYTHONPATH "${PYTHONPATH}:/usr/local/lib"

### Install tensorflow models (commit version: 079d67d9a0b3407e8d074a200780f3835413ef99)
WORKDIR /workspace
RUN git clone https://github.com/tensorflow/models.git /workspace/models 
WORKDIR /workspace/models/research
RUN git checkout 079d67d9a0b3407e8d074a200780f3835413ef99
RUN protoc object_detection/protos/*.proto --python_out=. 
ENV PYTHONPATH "${PYTHONPATH}:/workspace/models/research:/workspace/models/research/slim"

### Install miscellaneous
RUN pip3 install pyftpdlib==1.5.6
RUN pip3 install requests==2.25.1
RUN pip3 install black==19.10b0
RUN pip3 install isort==5.6.4
RUN pip3 install flake8==3.8.4
RUN pip3 install pyhumps==3.0.2
RUN pip3 install urx==0.11.0

EXPOSE 80
EXPOSE 443
EXPOSE 5000
EXPOSE 8000
EXPOSE 8888
EXPOSE 9000
EXPOSE 60000-65535