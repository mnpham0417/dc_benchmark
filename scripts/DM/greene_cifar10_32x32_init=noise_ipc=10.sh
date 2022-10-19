#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=6
#SBATCH --gres=gpu:1
#SBATCH --time=47:59:00
#SBATCH --mem=64GB
#SBATCH --job-name=dcbench
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mp5847@nyu.edu
#SBATCH --output=greene_cifar10_32x32_init=noise_ipc=10_dm_%A_%j.out

module purge

singularity exec --nv \
    --overlay /scratch/work/public/imagenet/imagenet-train.sqf:ro \
	--overlay /scratch/work/public/imagenet/imagenet-val.sqf:ro \
	--overlay /scratch/mp5847/singularity_containers/overlay-50G-10M.ext3:ro \
	/scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif \
	/bin/bash -c "source /ext3/env.sh; conda activate dcbench; python3 /home/mp5847/src/dc_benchmark/methods/dc/main_DM.py  --dataset CIFAR10  --model ConvNet --Iteration 1000  --ipc 10  --dsa_strategy color_crop_cutout_flip_scale_rotate  --init noise  --lr_img 1  --num_exp 1  --num_eval 5 --data_path /home/mp5847/src/dc_benchmark/methods/dc/data --name greene_cifar10_32x32_init=noise_ipc=10 --log_path ./output/DM/cifar10_32x32_init=noise_ipc=10 --save_path ./result/DM/cifar10_32x32_init=noise_ipc=10"