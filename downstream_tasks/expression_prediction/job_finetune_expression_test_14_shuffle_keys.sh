#!/bin/bash
#SBATCH --job-name=14shuf
#SBATCH --nodes=1
#SBATCH --time=228:00:00 
#SBATCH --gpus-per-node=8
#SBATCH --cpus-per-task=28
#SBATCH --reservation=rnd
#SBATCH --mem=96G

date
echo "job_finetune_expression_test_14.sh"
cd /external/nfs/01-home/vsefishman/DNALM/GENA_LM/GENA_LM-expr_260226/GENA_LM/downstream_tasks/expression_prediction/
source /external/nfs/01-home/vsefishman/envs/mGenaNTbench/bin/activate
export HF_HOME=/external/nfs/01-home/vsefishman/.hf
export TRANSFORMERS_OFFLINE=1
export HF_HUB_OFFLINE=1

bash finetune_expression_14.sh loss_test_nkeys14_shufflenkeys

date