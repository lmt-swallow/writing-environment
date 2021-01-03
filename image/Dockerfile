FROM haskell:8.10

RUN apt update -y && apt install -y  \
  texlive-latex-base \
  texlive-latex-recommended \
  texlive-science \
  texlive-science-doc \
  texlive-latex-extra \
  texlive-fonts-extra \
  texlive-bibtex-extra \
  texlive-luatex \
  texlive-lang-japanese \
  texlive-extra-utils \  
  latexmk \
  fontconfig \ 
  python \
  python-dev \
  python-pip \
  python-virtualenv \
  python-pandocfilters  \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*  

RUN cabal update && cabal install \
  pandoc \
  pandoc-crossref \
  pandoc-citeproc \
  && rm -rf /root/.cabal/lib /root/.cabal/packages

WORKDIR /workspace

ENTRYPOINT ["pandoc"]