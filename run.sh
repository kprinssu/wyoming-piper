#!/usr/bin/env bash

  conda init bash
  source activate py_3.10
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/

exec python3 -m wyoming_piper --piper /opt/conda/envs/py_3.10/bin/piper --uri 'tcp://0.0.0.0:10200' --data-dir /data --download-dir /data  --voice en_US-danny-low "$@"
