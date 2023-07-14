#!/bin/bash

# module load GROMACS/2021.5-foss-2021b-CUDA-11.4.1
# module unload Python/3.9.6-GCCcore-11.2.0
module load profile/lifesc
module load autoload gromacs/2022

echo -e "1" | gmx trjconv -f npt_d11.xtc -s npt_d11.tpr -o whole.xtc -pbc whole -ur compact
echo -e "1" "1" | gmx trjconv -f whole.xtc -s npt_d11.tpr -o cluster.xtc -pbc cluster -ur compact
echo -e "1" | gmx trjconv -f cluster.xtc -s npt_d11.tpr -o cluster.gro -dump 60
echo -e "1" | gmx trjconv -f cluster.xtc -s cluster.gro -o nojump.xtc -pbc nojump -ur compact
echo -e "1" "1" | gmx trjconv -f nojump.xtc -s cluster.gro -o center.xtc -ur compact -center

echo -e "1" | gmx trjconv -f center.xtc -s npt_d11.tpr -o center.gro -dump 12
echo -e "1" "1" | gmx trjconv -f center.xtc -s center.gro -o cluster/fit.xtc -fit rot+trans
echo -e "1" | gmx trjconv -f cluster/fit.xtc -s npt_d11.tpr -o ./cluster/for_cpp_topology.pdb -dump 200

# gmx cluster -f fit.xtc -s center.gro -skip 10
