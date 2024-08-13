
## attempting to fix code nav in ghc/ghc repo (F12 fails, as do code lens hints) 

FYI per haskell-language-server docs: code nav is supported https://haskell-language-server.readthedocs.io/en/latest/features.html#call-hierarchy

```bash

# seeing if once I get a build working that all the deps are in place and all files are generated to make code nav work... FYI View -> Output -> Select Haskell from dropdown -> review errors

# *** build setup:
# based on: https://gitlab.haskell.org/ghc/ghc/-/wikis/building/preparation/mac-osx

# install ghcup and install recent build of ghc + cabal

# install deps
brew install autoconf automake sphinx-doc # also a python install
# fish_add_path /opt/homebrew/opt/sphinx-doc/bin # optional add sphinx-doc to PATH (to build docs)

cabal update
cabal install alex happy # build deps

git clone https://gitlab.haskell.org/ghc/ghc
cd ghc
./boot
./configure # defaults succeeded, that said the guide above passed somee options
hadrian/build

```