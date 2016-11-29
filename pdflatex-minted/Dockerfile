FROM debian:jessie
MAINTAINER Maël Auzias <docker@mael.auzias.net>

RUN apt-get update && apt-get install -y \
    texlive* \
    ca-certificates \
    python3 \
    curl \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Adding Pygments for package minted
RUN curl -O https://bootstrap.pypa.io/get-pip.py \
    && python3 get-pip.py \
    && rm get-pip.py \
    && pip install Pygments \
    # upgrade minted to v 2.2 (not v 2.4) otherwise the version is too old and does not support a couple of options
    && curl -o /usr/share/texlive/texmf-dist/tex/latex/minted/minted.sty \
    https://raw.githubusercontent.com/gpoore/minted/0a8640dddff47ae31a7a0d6e3cf030c82c111907/source/minted.sty

# Create user and working dir
WORKDIR /build
RUN useradd --no-create-home --uid 1000 pdflatex-user
USER pdflatex-user

# assuming the image is named "pdflatex", use it (somehow) as follow:
# docker run --rm -it -v `pwd`:/build pdflatex pdflatex -shell-escape -output-directory ${BUILD_DIR} -draftmode  ${FILE}.tex

# entrypoint `bash` is prefered as pdflatex package brings both `pdflatex`- and `bibtex`- commands
ENTRYPOINT [ "bash" ]
