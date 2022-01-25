FROM dddlab/base-rstudio:v20200720-d6cbe5a-94fdd01b492f
 
LABEL maintainer="LSIT <lsitops@lsit.ucsb.edu>"

USER root

RUN apt update && apt upgrade -yq && apt-get clean -y

USER $NB_USER

RUN conda clean -i 

RUN conda install pycryptosat && conda update -n base conda

RUN conda config --set sat_solver pycryptosat && \
    conda install -y r-base && \
    conda install -c conda-forge udunits2 && \
    conda install -c conda-forge imagemagick && \
    conda install -c conda-forge r-rstan && \ 
    conda install -c conda-forge gdal

RUN pip install -U matplotlib numpy pandas proj

RUN R -e "install.packages(c('tidyverse', 'lme4', 'rstan', 'brms'), repos = 'http://cran.us.r-project.org')"
