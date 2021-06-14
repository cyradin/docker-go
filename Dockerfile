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

# Install packages needed for VS Code Golang extension
RUN go get -v github.com/uudashr/gopkgs/v2/cmd/gopkgs && \
    go get -v honnef.co/go/tools/cmd/staticcheck && \
    go get -v github.com/ramya-rao-a/go-outline && \
    go get -v github.com/cweill/gotests/gotests && \
    go get -v github.com/fatih/gomodifytags && \
    go get -v github.com/josharian/impl && \
    go get -v github.com/haya14busa/goplay/cmd/goplay && \
    go get -v github.com/go-delve/delve/cmd/dlv && \
    go get -v github.com/go-delve/delve/cmd/dlv@master && \
    go get -v honnef.co/go/tools/cmd/staticcheck && \
    go get -v golang.org/x/tools/gopls

RUN addgroup user \
    && adduser --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password --shell=/bin/bash --ingroup=user user \
    && chown -R user:user /opt \
    && echo 'user ALL=NOPASSWD: ALL' > /etc/sudoers.d/user \
    && chmod 0440 /etc/sudoers.d/user \
    && visudo --check

USER user

# see https://github.com/microsoft/vscode-remote-release/issues/22
ENV HOME /home/user

WORKDIR /home/user/app

ENTRYPOINT [ "sleep", "infinity" ]
