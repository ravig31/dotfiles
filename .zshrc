# Reminders
echo "Do Daily OTW!\nDo Daily OTW!\nDo Daily OTW!"


VENV_PREFIX="${HOME}/main/envs"
PY_VENV_SUFFIX="bin/activate"
REPO_PREFIX="${HOME}/main"

# misc
alias shellagain="source ${HOME}/.zshrc"
alias zz="vim ${HOME}/.zshrc"  # open shell quickly

alias icformat="cat ${HOME}/main/.clang-format >> ${PWD}/.clang-format"
alias vim='nvim'
alias vimconf='(cd ${HOME}/dotfiles/.config/nvim && vim)'
alias gdmstart='sudo systemctl start gdm.service'
alias sai='sudo apt install -y'
alias sar='sudo apt remove -y'

export TERM=xterm-256color

# home-pc wol
alias wolhome-pc="wakeonlan A8:5E:45:53:45:A6"
alias wowhome-pc='ssh fedorasrv-remote "wol A8:5E:45:53:45:A6"'

cmake-rebuild() {
  rm -rf ./build
  mkdir build
  cmake -S . -B build/
}

# over the wire
otw() {
	ssh -p 2220 "$1"@bandit.labs.overthewire.org
}

# envs
alias env_cudf="cd $REPO_PREFIX/cudf && conda activate cudf_dev"

# VS code remote
codessh() {
	code --remote ssh-remote+homepc-local /home/ravig31/"$1"
}

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

#libomp
export LIBRARY_PATH=$LIBRARY_PATH:/opt/homebrew/opt/libomp/lib

#vcpkg
export VCPKG_ROOT="$HOME/vcpkg"
export PATH="$VCPKG_ROOT:$PATH"

# JAVA
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH=${JAVA_HOME}/bin:$PATH

# PAPI
export PAPI_DIR=~/main/papi/src/install/
export PATH=${PAPI_DIR}/bin:$PATH
export LD_LIBRARY_PATH=${PAPI_DIR}/lib:$LD_LIBRARY_PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# rust
. "$HOME/.cargo/env"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/ravindugamage/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ravig31/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ravig31/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ravig31/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ravig31/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# CUDA
export PATH="/usr/local/cuda/bin:$PATH"
