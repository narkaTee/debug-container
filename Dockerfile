FROM debian:trixie

RUN apt-get update && apt-get install -y --no-install-recommends \
    tcpdump \
    tshark \
    tcpick \
    nmap \
    dnsutils \
    procps \
    iputils-ping \
    iproute2 \
    iptables \
    socat \
    curl \
    wget \
    openssh-client \
    openssl \
    traceroute \
    mtr-tiny \
    htop \
    strace \
    lsof \
    vim \
    less \
    jq \
    file \
    xxd \
    bash \
    zsh \
    ca-certificates \
    ruby \
    rake \
    git \
    fzf \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm -rf /usr/share/doc /usr/share/locale

ENV TERM=xterm-256color

COPY dotfiles-update.sh /root/.dotfiles-update.sh

RUN chmod +x /root/.dotfiles-update.sh \
    && git clone --depth 1 https://github.com/narkaTee/dotfiles.git /root/.dotfiles \
    && mkdir -p /root/.config/setup \
    && echo 'source /root/.dotfiles-update.sh' >> /root/.config/setup/env.local.sh \
    && cd /root/.dotfiles && rake vim zsh \
    && echo exit | script -qec zsh /dev/null >/dev/null

WORKDIR /root

CMD ["zsh"]
