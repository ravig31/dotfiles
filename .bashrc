# .bashrc
REPO_PREFIX="${HOME}/main"

# binaries
export PATH="/home/$USER/bin:$PATH"

# misc
alias shellagain="source ${HOME}/.bashrc"
alias zz="code ${HOME}/.bashrc"  # open shell quickly
alias ll="ls -l"
alias la="ls -a"

# fast-fetch
fastfetch --config ~/.config/fastfetch/config

# ssh
eval `keychain --eval --quiet github-personal`

# cmake
cmake-rebuild() {
  rm -rf ./build
  mkdir build
  cmake -S . -B build/
}

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# PAPI
export PAPI_DIR=~/main/papi-7.2.0b2/src/install/
export PATH=${PAPI_DIR}/bin:$PATH
export LD_LIBRARY_PATH=${PAPI_DIR}/lib:$LD_LIBRARY_PATH


