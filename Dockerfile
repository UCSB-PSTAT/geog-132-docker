FROM dddlab/base-rstudio:v20200720-d6cbe5a-94fdd01b492f
 
LABEL maintainer="LSIT <lsitops@lsit.ucsb.edu>"

USER root

RUN apt update && apt upgrade -yq && apt install build-essential libtool autoconf unzip cmake libgomp1 pkg-config libnlopt-dev g++ -yq && apt-get clean -y

USER $NB_USER

RUN conda clean -i 

RUN conda install mamba -n base -c conda-forge

RUN mamba install -y r-base && \
    mamba install -c conda-forge udunits2 && \
    mamba install -c conda-forge imagemagick && \
    mamba install -c conda-forge r-rstan && \ 
    mamba install -c conda-forge gdal

RUN pip install -U matplotlib numpy pandas proj

RUN R -e "dotR <- file.path(Sys.getenv('HOME'), '.R'); if(!file.exists(dotR)){ dir.create(dotR) }; Makevars <- file.path(dotR, 'Makevars'); if (!file.exists(Makevars)){  file.create(Makevars) }; cat('\nCXX14FLAGS=-O3 -fPIC -Wno-unused-variable -Wno-unused-function', 'CC = gcc', 'CXX = g++', 'CXX11 = g++', 'CXX14 = g++ -std=c++1y -fPIC', file = Makevars, sep = '\n', append = TRUE)"
RUN R -e "install.packages(c('tidyverse', 'lme4', 'rstan', 'brms'), repos = 'http://cran.us.r-project.org')"
