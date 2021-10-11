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
    && chown -R user:users /opt \
    && mkdir -p /go/bin \
    && touch /go/bin/.keep \
    && mkdir -p /go/pkg \
    && touch /go/pkg/.keep \
    && mkdir -p /go/src \
    && touch /go/src/.keep \
    && chown -R user:users /go \
    && echo 'user ALL=NOPASSWD: ALL' > /etc/sudoers.d/user \
    && chmod 0440 /etc/sudoers.d/user \
    && visudo --check

USER user

# see https://github.com/microsoft/vscode-remote-release/issues/22
ENV HOME /home/user

WORKDIR /home/user/app

ENTRYPOINT [ "sleep", "infinity" ]
