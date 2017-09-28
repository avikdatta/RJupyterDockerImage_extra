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

RUN echo 'install.packages(c("lme4", \
                             "lubridate", \
                             "plyr", \
                             "scales"), \
                             repos="https://cloud.r-project.org/", \
                             dependencies = TRUE, type = "source")' > /home/$NB_USER/install.R \
    && R CMD BATCH --no-save /home/$NB_USER/install.R
    
RUN rm -f /home/$NB_USER/install.R*
    
CMD ['jupyter-notebook', '--ip=0.0.0.0']
