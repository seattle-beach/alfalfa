export PATH="/usr/local/bin:$PATH"

# Path to the bash it configuration
export BASH_IT="/Users/pivotal/.bash_it"

# Lock and Load a custom theme file
export BASH_IT_THEME="bobby"

# Load Bash It
source $BASH_IT/bash_it.sh

export GIT_DUET_ROTATE_AUTHOR=1

if command -v direnv &> /dev/null; then
  eval "$(direnv hook bash)"
fi
