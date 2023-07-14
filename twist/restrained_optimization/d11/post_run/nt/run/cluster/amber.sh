#!/bin/bash

module load GROMACS/2021.5-foss-2021b-CUDA-11.4.1
module unload Python/3.9.6-GCCcore-11.2.0
conda activate locuaz

cpptraj < cpp_clu

