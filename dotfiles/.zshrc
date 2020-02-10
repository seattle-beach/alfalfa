export GIT_DUET_ROTATE_AUTHOR=1
export EDITOR=vim

if command -v rbenv &> /dev/null; then
  eval "$(rbenv init -)"
fi

if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

alias bindle=bundle

alias ag="ag --skip-vcs-ignore"

alias git=git-together
alias gbr="git branch"
alias gci="git commit"
alias gco="git checkout"
alias gst="git status"


