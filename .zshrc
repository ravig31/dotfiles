VENV_PREFIX="${HOME}/main/envs"
PY_VENV_SUFFIX="bin/activate"
REPO_PREFIX="${HOME}/main"

# misc
alias code='open -a "Visual Studio Code"'
alias shellagain="source ${HOME}/.zshrc"
alias zz="vim ${HOME}/.zshrc"  # open shell quickly
alias icformat="cat ${HOME}/main/.clang-format >> ${PWD}/.clang-format"
alias vim='nvim'

cmake-rebuild() {
  rm -rf ./build
  mkdir build
  cmake -S . -B build/
}

# fast-fetch
# fastfetch --config ~/.config/fastfetch/config.jsonc

# ssh
eval `keychain --eval --quiet github-personal`

export VISUAL="vim"
export EDITOR="vim"
pipr() { [ -z "$VIRTUAL_ENV" ] && echo "error: can only exec on venv." || python -m pip freeze | xargs pip uninstall -y; }

# makefile
zstyle ':completion:*:*:make:*' tag-order 'targets'
autoload -U compinit && compinit

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="candy"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Machine or library specifc
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"

export LDFLAGS="-L/opt/homebrew/opt/fmt/lib",
export CPPFLAGS="-I/opt/homebrew/opt/fmt/include"

#libomp
export LIBRARY_PATH=$LIBRARY_PATH:/opt/homebrew/opt/libomp/lib

#vcpkg
export VCPKG_ROOT="$HOME/vcpkg"
export PATH="$VCPKG_ROOT:$PATH"

#envs
alias foodinator='source "${VENV_PREFIX}/foodinator/${PY_VENV_SUFFIX}" && cd "${REPO_PREFIX}/foodinator"'
alias js-kaggle='source "${VENV_PREFIX}/js-kaggle/${PY_VENV_SUFFIX}" && cd "${REPO_PREFIX}/jane-street-real-time-market-data-forecasting"'
alias tgbinance='source "${VENV_PREFIX}/tgbinance/${PY_VENV_SUFFIX}" && cd "${REPO_PREFIX}/tg_binance_bot"'
alias gdd='source "${VENV_PREFIX}/google-doc-decode/${PY_VENV_SUFFIX}" && cd "${REPO_PREFIX}/google-doc-decode"'

# JAVA
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH=${JAVA_HOME}/bin:$PATH

# PAPI
export PAPI_DIR=~/main/papi/src/install/
export PATH=${PAPI_DIR}/bin:$PATH
export LD_LIBRARY_PATH=${PAPI_DIR}/lib:$LD_LIBRARY_PATH
