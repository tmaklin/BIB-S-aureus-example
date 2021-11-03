# mSWEEP/mGEMS *Escherichia coli* plate sweep metagenomics tutorial

Example of using mSWEEP and mGEMS to identify *E. coli* strains from
mixed samples, all the way from clustering reference sequences to
assembling binned reads.

Each command is documented below individually. To run all the commands
at once, install the required software and run the
```run_tutorial.sh``` script.

## External software required to run the tutorial
1. [PopPUNK v2.4.0](https://github.com/johnlees/PopPUNK)
2. [mlst v2.19.0](mlst])https://github.com/tseemann/mlst)
3. [Themisto v1.2.0](https://github.com/algbio/themisto)
4. [mSWEEP v1.5.0](https://github.com/PROBIC/mSWEEP)
5. [mGEMS v1.1.0](https://github.com/PROBIC/mGEMS)

The version numbers refer to the versions of the software that were
used when this tutorial was published.

## Tutorial

### Install the required software
#### PopPUNK
Using conda:
```
conda create --name poppunk=2.4.0
conda install -c defaults -c bioconda -c conda-forge poppunk
```

#### mlst
Using conda:
```
conda create --name mlst
conda install -c defaults -c bioconda -c conda-forge mlst=2.19.0
```

#### Themisto
1. Download the binaries for your system from (https://github.com/algbio/themisto/releases/tag/v1.2.0)
2. ... or compile Themisto from source by running:
```
wget -O themisto_v1.2.0_src.tar.gz https://github.com/algbio/themisto/archive/refs/tags/v1.2.0.tar.gz
tar -zxvf themisto_v1.2.0_src.tar.gz
cd themisto_v1.2.0_src/build
cd build
cmake -DCMAKE_MAX_KMER_LENGTH=32 ..
make -j3
```

Compiling Themisto from source can take a few minutes, so feel free to
go grab some coffee/tea/water.

#### mSWEEP
1. Download the binaries for your system from (https://github.com/PROBIC/mSWEEP/releases/tag/v1.5.0)
2. ... or compile mSWEEP from source by running:
```
wget -O mSWEEP_v1.5.0_src.tar.gz https://github.com/PROBIC/mSWEEP/archive/refs/tags/v1.5.0.tar.gz
tar -zxvf mSWEEP_v1.5.0_src.tar.gz
cd mSWEEP_v1.5.0_src
mkdir build
cd build
cmake ..
make -j
```

#### mGEMS
1. Download the binaries for your system from (https://github.com/PROBIC/mGEMS/releases/tag/v1.1.0)
2. ... or compile mGEMS from source by running:
```
wget -O mGEMS_v1.1.0_src.tar.gz https://github.com/PROBIC/mGEMS/archive/refs/tags/v1.1.0.tar.gz
tar -zxvf mGEMS_v1.1.0_src.tar.gz
cd mGEMS_v1.1.0_src
mkdir build
cd build
cmake ..
make -j
```

### Download the reference data

