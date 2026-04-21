#!/usr/bin/env bash
set -e

cd ../..

export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7

TBS=256
BS=8
NP=8
GAS=$(( TBS / (BS * NP) ))  

config_name=$1

export NCCL_DEBUG=INFO
export NCCL_NVLS_ENABLE=0

TMPDIR=$HOME/tmp TMP=$HOME/tmp TEMP=$HOME/tmp \
GENALM_HOME=$(realpath ..) NCCL_DEBUG=INFO \
accelerate launch \
  --multi_gpu \
  --main_process_port 29515 \
  --num_processes "$NP" \
  --module downstream_tasks.expression_prediction.run_expression_finetuning_final_14_seed \
  --experiment_config "downstream_tasks/expression_prediction/configs/${config_name}.yaml" \
  --batch_size "$BS" \
  --gradient_accumulation_steps "$GAS"

echo "done"