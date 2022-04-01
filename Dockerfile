FROM rust:1.59-slim-bullseye

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget cmake build-essential && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Set non-root user
ENV USER="user"
RUN useradd -ms /bin/bash $USER
USER $USER
ENV HOME="/home/$USER"
WORKDIR $HOME

RUN wget https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh -O anaconda.sh
RUN chmod +x anaconda.sh
RUN bash ./anaconda.sh -b -p $HOME/anaconda
RUN rm ./anaconda.sh
ENV PATH="/${HOME}/anaconda/bin:${PATH}"

RUN rustup component add rust-src
RUN cargo install evcxr_jupyter
RUN evcxr_jupyter --install

RUN mkdir $HOME/.jupyter
COPY ./jupyter_notebook_config.json $HOME/.jupyter

EXPOSE 8888
ENTRYPOINT ["jupyter", "notebook", "--no-browser", "--ip=0.0.0.0", "--port=8888"]
