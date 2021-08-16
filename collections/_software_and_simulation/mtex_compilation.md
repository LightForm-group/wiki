---
title: Compiling binary files for MTEX
author: Peter Crowther
subcollection: MTEX
---

MTEX relies on some other programs for doing maths. These programs are included with MTEX for several common systems inclusing windows and MacOS. However, it may be the case that these programs are not valid for your system.

If this is the case you will see a message when you first load MTEX about "Invalid MEX-file". This means that the supporting programs need to be compiled from binary sources for your system.

This guide is specific to the iCSF (incline) HPC machine at the University of Manchester, though the procedure will be boradly the same for all UNIX systems. The URLS and package versions were valid in Auguast 2021, but you should check and see if there have been updates since the 


### Go to home directory and load important modules
```bash
cd ~
module add apps/binapps/matlab/R2019a
module add compilers/gcc/8.3.0
```

### Get mtex
```bash
wget https://github.com/mtex-toolbox/mtex/releases/download/mtex-5.7.0/mtex-5.7.0.zip
unzip -q mtex-5.7.0.zip
rm mtex-5.7.0.zip
cd mtex-5.7.0
matlab
# Matlab will try and initialise mtex but fail to do so becuse it cant load the NFFT library.
exit
cd ~
```

### Get compile and install FFTW
```bash
wget http://www.fftw.org/fftw-3.3.9.tar.gz
tar -xf fftw-3.3.9.tar.gz
rm fft fftw-3.3.9.tar.gz
cd fftw-3.3.9
./configure --prefix=${HOME}/fftw --enable-openmp --enable-threads --enable-shared
make
make install
cd ~
```

### Get compile and install NFFT
```bash
wget https://www-user.tu-chemnitz.de/~potts/nfft/download/nfft-3.5.2.tar.gz
tar -xf nfft-3.5.2.tar.gz
rm nfft-3.5.2.tar.gz
cd nfft-3.5.2
./configure --enable-nfsoft --enable-nfsft --enable-openmp --enable-portable-binary --with-matlab=/opt/gridware/apps/binapps/matlab1/R2019a --prefix=${HOME}/nfft --with-fftw3=${HOME}/fftw
make
```

### Copy compiled mex files to mtex folder
```bash
cp matlab/nfsoft/nfsoftmex.mex* ~/mtex-5.7.0/extern/nfft_openMP/
cp matlab/nfsft/nfsftmex.mex* ~/mtex-5.7.0/extern/nfft_openMP/
```

If you want, you can now delete the nfft and fftw folders from your home directory, as the compiled .mex files are all that are needed.