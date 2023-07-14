# Before

`data/run/start.pdb` came from `/m100_work/AIRC_Fortun21/barletta/twist/run/d11`

```
echo -e 0 | gmx trjconv -s data/run/npt_d11.tpr -f data/run/npt_d11.gro -o data/d11.pdb
```


# After

```
cp /m100_work/AIRC_Fortun21/barletta/twist/restrained_optimization/d11/work_dir/5-B_LGEENTI-B_YFSSYPA-B_AKIRNQIHRRGGKSDSPT/npt_d11.gro post_run/fr/run/start.gro
cp /m100_work/AIRC_Fortun21/barletta/twist/restrained_optimization/d11/work_dir/5-B_LGEENTI-B_YFSSYPA-B_AKIRNQIHRRGGKSDSPT/npt_d11.zip post_run/fr/run/start.zip
unzip post_run/nt/run/start.zip -d post_run/nt/run/

cp /m100_work/AIRC_Fortun21/barletta/twist/restrained_optimization/d11/work_dir/5-B_LGEENTI-B_YNSSYPA-B_AKIRNQIHTRGGKSDSPT/npt_d11.gro post_run/nt/run/start.gro
cp /m100_work/AIRC_Fortun21/barletta/twist/restrained_optimization/d11/work_dir/5-B_LGEENTI-B_YNSSYPA-B_AKIRNQIHTRGGKSDSPT/npt_d11.zip post_run/nt/run/start.zip
unzip post_run/fr/run/start.zip -d post_run/fr/run/

```

And run `run.sh`. After running 250ns, the complex remains stable. I ran:

```
./limpiar.sh
```

to remove PBC effects and fit the trajectoy and then inside:
`/m100_work/AIRC_Fortun21/barletta/twist/restrained_optimization/d11/post_run/fr/run/cluster` and
`/m100_work/AIRC_Fortun21/barletta/twist/restrained_optimization/d11/post_run/nt/run/cluster`
I ran:

```
cpptr < cpp_clu
```

to get 2 clusters from each run. They seem very similar. Then:


On `/m100_work/AIRC_Fortun21/barletta/twist/optimization`

```
mkdir -p d11fr0/data/run
mkdir -p d11fr1/data/run
mkdir -p d11nt0/data/run
mkdir -p d11nt1/data/run
cp /m100_work/AIRC_Fortun21/barletta/twist/restrained_optimization/d11/data/run/*sh d11fr0/data/run
cp /m100_work/AIRC_Fortun21/barletta/twist/restrained_optimization/d11/data/run/*sh d11fr1/data/run
cp /m100_work/AIRC_Fortun21/barletta/twist/restrained_optimization/d11/data/run/*sh d11nt0/data/run
cp /m100_work/AIRC_Fortun21/barletta/twist/restrained_optimization/d11/data/run/*sh d11nt1/data/run

sed -i s/d11/d11fr0/g d11fr0/data/run/*sh
sed -i s/d11/d11fr1/g d11nt1/data/run/*sh
sed -i s/d11/d11nt0/g d11nt0/data/run/*sh
sed -i s/d11/d11nt1/g d11nt1/data/run/*sh

cp /m100_work/AIRC_Fortun21/barletta/twist/restrained_optimization/d11/post_run/fr/run/cluster/top_cluster.c0.pdb d11fr0/data/run/start.pdb
cp /m100_work/AIRC_Fortun21/barletta/twist/restrained_optimization/d11/post_run/fr/run/cluster/top_cluster.c1.pdb d11fr1/data/run/start.pdb
cp /m100_work/AIRC_Fortun21/barletta/twist/restrained_optimization/d11/post_run/nt/run/cluster/top_cluster.c0.pdb d11nt0/data/run/start.pdb
cp /m100_work/AIRC_Fortun21/barletta/twist/restrained_optimization/d11/post_run/nt/run/cluster/top_cluster.c1.pdb d11nt1/data/run/start.pdb
```

Then, remove the CRYST1 record from all start.pdb, and run:
```
mmin.sh
nnvt.sh
nnpt.sh
```

Finally, start protocol.
