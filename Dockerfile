FROM ubuntu AS builder

RUN apt update && apt upgrade -y && \
  apt-get install --yes --no-install-recommends \
  build-essential cmake ca-certificates curl pkg-config git

WORKDIR /build
RUN git clone -b rocm-cpp https://github.com/kprinssu/piper.git
RUN cd piper && make


FROM rocm/pytorch:rocm6.3.3_ubuntu22.04_py3.10_pytorch_release_2.3.0
COPY --from=builder /build/piper/install /usr/share
