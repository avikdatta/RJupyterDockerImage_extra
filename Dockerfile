FROM avikdatta/rjupyterdockerimage

MAINTAINER reach4avik@yahoo.com

ENTRYPOINT []

ENV NB_USER vmuser

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
    && echo "R CMD BATCH --no-save /home/$NB_USER/ML_for_Hackers/package_installer.R" > /home/$NB_USER/install_r.sh
# Fix for slam
# library(devtools)
# slam_url <- "https://cran.r-project.org/src/contrib/Archive/slam/slam_0.1-37.tar.gz"
# install_url(slam_url)
#
# Fix for xml
# apt-get install libxml2-dev
# apt-get install r-cran-xml
# Fix for ipraph
# install_github("igraph/rigraph")

CMD ['jupyter-notebook','--ip','0.0.0.0']
