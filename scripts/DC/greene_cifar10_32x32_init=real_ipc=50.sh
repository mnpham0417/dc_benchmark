#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=6
#SBATCH --gres=gpu:1
#SBATCH --time=47:59:00
#SBATCH --mem=64GB
#SBATCH --job-name=dcbench
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mp5847@nyu.edu
#SBATCH --output=greene_cifar10_32x32_init=real_ipc=50_%A_%j.out

module purge

singularity exec --nv \
    --overlay /scratch/work/public/imagenet/imagenet-train.sqf:ro \
	--overlay /scratch/work/public/imagenet/imagenet-val.sqf:ro \
	--overlay /scratch/mp5847/singularity_containers/overlay-50G-10M.ext3:ro \
	/scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif \
	/bin/bash -c "source /ext3/env.sh; python3 /home/mp5847/src/dc_benchmark/methods/dc/main.py --dataset CIFAR10 --model ConvNet --ipc 50 --Iteration 20000 --data_path /home/mp5847/src/dc_benchmark/methods/dc/data --name greene_cifar10_32x32_init=real_ipc=50 --log_path ./output_DC --init real"