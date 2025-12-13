FROM texlive/texlive:latest
ARG DEBIAN_FRONTEND=noninteractive
ARG PANDOC_VERSION=3.6.3
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    git \
    make \
    wget \
    fonts-noto-cjk \
    fonts-noto-cjk-extra \
    && rm -rf /var/lib/apt/lists/*

RUN ARCH=$(dpkg --print-architecture) && \
    wget "https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-1-${ARCH}.deb" && \
    dpkg -i pandoc-${PANDOC_VERSION}-1-${ARCH}.deb && \
    rm pandoc-${PANDOC_VERSION}-1-${ARCH}.deb

RUN pandoc --version && python3 --version && git --version && make --version

WORKDIR /data

ENTRYPOINT ["/bin/bash", "-c"]