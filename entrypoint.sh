#!/usr/bin/env bash

export LD_LIBRARY_PATH=/usr/share/piper:$LD_LIBRARY_PATH
exec python3 -m wyoming_piper \
  --piper '/usr/share/piper/piper' \
  --uri 'tcp://0.0.0.0:10200' \
  --data-dir /data \
  --download-dir /data \
  --voice en_US-danny-low \
  --use-rocm \
  "$@"
