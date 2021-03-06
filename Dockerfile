FROM  ubuntu:latest

ENV TERM=xterm
ENV DEBIAN_FRONTEND=noninteractive
ENV WORKON_HOME=/root/

# Update the environment
RUN apt-get update && \
    apt-get install -y \
    apt-utils \
    dpkg

# Install development tools
RUN apt-get install -y \
    gcc \
    make \
    git

# TODO: Import git configuration values for the global user.email and 
# user.name parameters.

# Install Python3 and dependencies
RUN apt-get install -y \
        python3 \
        python3-pip \
        python3-dev \ 
        sphinx-doc


RUN pip3 install \
    poetry \
    behave \
    virtualenv

RUN pip3 install jupyter

# Install GNU Emacs
RUN apt-get install -y emacs-nox
ADD ./docker/.emacs.d /root/.emacs.d

# Install a terminal multiplexer
RUN apt-get install -y tmux

RUN mkdir -p /root/projects
WORKDIR /root/projects
CMD jupyter notebook --ip 0.0.0.0 --allow-root

# Execute with
# docker run -it -p 8888:8888 -v atl-projects:/root/projects/ atlanta-local:latest
# or
# docker run -it -p 8888:8888 -v c/Users/kvora/Projects/:/root/projects atlanta-local:latest
# to mount a local windows directory
