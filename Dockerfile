FROM avikdatta/rjupyterdockerimage

MAINTAINER reach4avik@yahoo.com

ENTRYPOINT []

ENV NB_USER vmuser

USER $NB_USER
WORKDIR /home/$NB_USER

RUN apt-key adv --keyserver keys.gnupg.net --recv-key 381BA480 \
    && echo "deb http://cloud.r-project.org//bin/linux/debian jessie-cran34/" >> /etc/apt/sources.list \
    && apt-get -y update \
    && 
    
ENV PYENV_ROOT="/home/$NB_USER/.pyenv"   
ENV PATH="$PYENV_ROOT/libexec/:$PATH" 
ENV PATH="$PYENV_ROOT/shims/:$PATH" 

RUN eval "$(pyenv init -)"  \
    && pyenv global 3.5.2

#ENV R_LIBS_USER /home/$NB_USER/rlib

#RUN git clone https://github.com/johnmyleswhite/ML_for_Hackers.git \
#    && R CMD BATCH --no-save /home/$NB_USER/ML_for_Hackers/package_installer.R
    
#RUN rm -f /home/$NB_USER/ML_for_Hackers/package_installer.R.*
    
CMD ['jupyter-notebook','--ip','0.0.0.0']
