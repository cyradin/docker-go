ARG GO_VERSION
FROM golang:${GO_VERSION}-buster

ARG GOPRIVATE=
ENV GOPRIVATE=${GOPRIVATE}

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    bash-completion \
    wget \
    git \
    nano \
    vim \
    curl \
    net-tools \
    coreutils \
    sudo \
    build-essential

RUN apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN addgroup user \
    && adduser --disabled-password --shell=/bin/bash --ingroup=users user \
    && echo 'user ALL=NOPASSWD: ALL' > /etc/sudoers.d/user \
    && chmod 0440 /etc/sudoers.d/user \
    && visudo --check

USER user

# see https://github.com/microsoft/vscode-remote-release/issues/22
ENV HOME /home/user

ENV GOPATH=/home/user/go
ENV PATH $GOPATH/bin:$PATH
WORKDIR /home/user/app

ENTRYPOINT ["/bin/bash", "-c", "trap : TERM INT; sleep infinity & wait"]

