# Initial setup
FROM ubuntu:22.04

# User creation
RUN useradd -m myuser
RUN echo 'myuser:password' | chpasswd
ARG NB_USER=myuser
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}
WORKDIR ${HOME}

# Copy needed things
COPY model.dill .
COPY model_predict.py .
COPY requirements.txt .

# Change permissions
RUN chown -R ${NB_UID} ${HOME}

# Install software
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt upgrade -y
RUN apt install python3-pip git -y

# Install python packates
RUN pip install -U pip
RUN pip install madml
RUN pip install -r requirements.txt
RUN python3 -m pip install --no-cache-dir notebook jupyterlab
RUN pip install --no-cache-dir jupyterhub

# Switch to user
USER ${NB_USER}
