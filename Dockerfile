FROM dddlab/base-rstudio:v20200720-d6cbe5a-94fdd01b492f
 
LABEL maintainer="LSIT <lsitops@lsit.ucsb.edu>"

USER root

RUN apt update && apt upgrade -yq && apt install build-essential libtool autoconf unzip cmake libgomp1 pkg-config libnlopt-dev -yq && apt-get clean -y

USER $NB_USER

RUN conda clean -i 

RUN conda install mamba -n base -c conda-forge

RUN mamba install -y r-base && \
    mamba install -c conda-forge udunits2 && \
    mamba install -c conda-forge imagemagick && \
    mamba install -c conda-forge r-rstan && \ 
    mamba install -c conda-forge gdal

RUN pip install -U matplotlib numpy pandas proj

RUN R -e "install.packages(c('tidyverse', 'lme4', 'rstan', 'brms'), repos = 'http://cran.us.r-project.org')"
