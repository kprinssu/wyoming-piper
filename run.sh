#!/usr/bin/env bash
exec python3 -m wyoming_piper --piper /opt/conda/envs/py_3.10/bin/piper --uri 'tcp://0.0.0.0:10200' --data-dir /data --download-dir /data  --voice en_US-danny-low "$@"
