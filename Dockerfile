FROM rocm/pytorch:rocm6.4.1_ubuntu22.04_py3.10_pytorch_release_2.3.0

# Set working directory for build
COPY . /app
WORKDIR /app

RUN apt install -y migraphx && pip install -U pip && pip install -r requirements.txt --no-cache-dir \
  && pip install git+https://github.com/kprinssu/piper@master#subdirectory=src/python_run \
  && pip install -e /app \
  && pip uninstall -y onnxruntime \
  && pip install onnxruntime-rocm -f https://repo.radeon.com/rocm/manylinux/rocm-rel-6.4.1/

ENTRYPOINT [ "sh", "/app/run.sh" ]
