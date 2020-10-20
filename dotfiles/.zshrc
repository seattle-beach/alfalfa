export PATH=$HOME/.gem/ruby/2.6.0/bin:$PATH  # for bundler
export GIT_DUET_ROTATE_AUTHOR=1
export EDITOR=vim

if command -v rbenv &> /dev/null; then
  eval "$(rbenv init -)"
fi

if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

if command -v pyenv &> /dev/null; then
  eval "$(pyenv init -)"
fi

alias bindle=bundle

alias ag="ag --skip-vcs-ignore"

alias git=git-together
alias gbr="git branch"
alias gci="git commit"
alias gco="git checkout"
alias gst="git status"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


alias k=kubectl
alias kc=kubectl
