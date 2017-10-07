FROM avikdatta/rjupyterdockerimage

MAINTAINER reach4avik@yahoo.com

ENTRYPOINT []

ENV NB_USER vmuser

USER root
WORKDIR /root/

RUN apt-get -y update \
    && apt-get install -y \
    && libxml2-dev \
    && r-cran-xml
    
USER $NB_USER
WORKDIR /home/$NB_USER

   
ENV PYENV_ROOT="/home/$NB_USER/.pyenv"   
ENV PATH="$PYENV_ROOT/libexec/:$PATH" 
ENV PATH="$PYENV_ROOT/shims/:$PATH" 

RUN eval "$(pyenv init -)"  \
    && pyenv global 3.5.2

ENV R_LIBS_USER /home/$NB_USER/rlib

RUN git clone https://github.com/johnmyleswhite/ML_for_Hackers.git \
    && sed -i 's|http://cran.stat.auckland.ac.nz/|https://cloud.r-project.org/|g' /home/$NB_USER/ML_for_Hackers/package_installer.R \
    && R CMD BATCH --no-save /home/$NB_USER/ML_for_Hackers/package_installer.R

RUN echo "library(devtools) > /home/$NB_USER/install.R \
    && echo "slam_url <- 'https://cloud.r-project.org/src/contrib/Archive/slam/slam_0.1-37.tar.gz'"  >> /home/$NB_USER/install.R \
    && echo "install_url(slam_url)" >> /home/$NB_USER/install.R \
    && echo " install_github("igraph/rigraph")" >> /home/$NB_USER/install.R \
    && R CMD BATCH --no-save /home/$NB_USER/install.R

CMD ['jupyter-notebook','--ip','0.0.0.0']
