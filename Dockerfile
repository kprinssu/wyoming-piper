# Build piper fork that contains rocm cpp support
FROM ubuntu AS piper_builder

RUN apt update && apt upgrade -y && \
  apt-get install --yes --no-install-recommends \
  build-essential cmake ca-certificates curl pkg-config git

WORKDIR /build
RUN git clone -b rocm-cpp https://github.com/kprinssu/piper.git
RUN cd piper && make

# Build wheels for wyoming-piper
FROM python:3.10 AS wyoming_piper_builder

WORKDIR /src
COPY . .

RUN ./script/setup && ./script/package

FROM rocm/dev-ubuntu-24.04:6.3.3
COPY --from=piper_builder /build/piper/install /usr/share/piper
RUN --mount=type=bind,from=wyoming_piper_builder,target=/mnt/builder pip3 install --break-system-packages /mnt/builder/src/dist/*.whl

ENTRYPOINT [ "python3", "-m", "wyoming_piper", "--piper", "/usr/share/piper", "--uri", "'tcp://0.0.0.0:10200'", "--data-dir", "/data", "--download-dir",  "/data" ]
