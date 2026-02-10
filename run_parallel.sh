#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR

GPU_COUNT=$(nvidia-smi -L | wc -l)
echo "Detected $GPU_COUNT GPUs. Starting parallel shards..."

for (( i=0; i<$GPU_COUNT; i++ ))
do
    CUDA_VISIBLE_DEVICES=$i python step1_generate_solutions.py \
        --shard $i \
        --total_shards $GPU_COUNT \
        --tp 1 > "log_shard$i.txt" 2>&1 &
done

wait
python merge_shards.py

