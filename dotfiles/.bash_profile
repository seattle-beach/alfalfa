export PATH="/usr/local/bin:/usr/local/go/bin/:$HOME/.local/bin:$HOME/go/bin:$PATH"

# Path to the bash it configuration
export BASH_IT=~/.bash_it

# Load Bash It
source $BASH_IT/bash_it.sh

export GIT_DUET_ROTATE_AUTHOR=1
export EDITOR=vim

if command -v rbenv &> /dev/null; then
  eval "$(rbenv init -)"
fi

alias bindle=bundle
alias gbr="git branch"
alias gci="git commit"
alias gco="git checkout"
alias gst="git status"

alias ag="ag --skip-vcs-ignore"

if [ "$TERMINAL_EMULATOR " = "JetBrains-JediTerm " ]; then
  export DISABLE_COLORS=1
fi

function prompt_command {
  echo -n 'git|'
  git_prompt_info
  echo -n '|git $ '
}

function git_prompt_info {
  git_prompt_vars
  GIT_TOGETHER=$(git config git-together.active)
  GIT_DUET=$(echo $(git config --get-regexp ^duet.env.git-.*-name | sed -e 's/^.*-name //' | tr 'A-Z' 'a-z' | sed -e 's/\([a-z]\)[^ +]*./\1/g' ) | sed -e 's/ /+/')
  GIT_PAIR=${GIT_DUET:-`git config user.initials | sed 's% %+%'`}
  GIT_INITIALS=${GIT_TOGETHER:-$GIT_PAIR}
  gitdir=$(git_dir)

  if is_merging "$gitdir"; then
    echo -e " \e[31mMERGING\e[0m"
  elif is_rebasing "$gitdir"; then
    echo -e " \e[31mREBASING\e[0m"
  else
    echo -e " $GIT_INITIALS$SCM_PREFIX$SCM_BRANCH$SCM_STATE$SCM_SUFFIX"
  fi
}

function git_dir {
  (
    while [ "$(pwd)" != / ]; do
      if [ -d .git ]; then
        pwd
        exit
      fi
      cd ..
    done
  )
}

function is_merging {
  gd="$1"

  if [ -z "$gd" ]; then
    return 1
  fi

  [ -f "${gd}/.git/MERGE_HEAD" ]
  return $?
}

function is_rebasing {
  gd="$1"

  if [ -z "$gd" ]; then
    return 1
  fi

  [ -d "${gd}/.git/rebase-apply" ] || [ -d "${gd}/.git/rebase-merge" ]
  return $?
}

function git_prompt_vars {
  local details=''
  SCM_STATE=${GIT_THEME_PROMPT_CLEAN:-$SCM_THEME_PROMPT_CLEAN}
  if [[ "$(git config --get bash-it.hide-status)" != "1" ]]; then
    [[ "${SCM_GIT_IGNORE_UNTRACKED}" = "true" ]] && local git_status_flags='-uno'
    local status_lines=$((git status --porcelain ${git_status_flags} -b 2> /dev/null ||
                          git status --porcelain ${git_status_flags}    2> /dev/null) | git_status_summary)
    local status=$(awk 'NR==1' <<< "$status_lines")
    local counts=$(awk 'NR==2' <<< "$status_lines")
    IFS=$'\t' read untracked_count unstaged_count staged_count <<< "$counts"
    if [[ "${untracked_count}" -gt 0 || "${unstaged_count}" -gt 0 || "${staged_count}" -gt 0 ]]; then
      SCM_DIRTY=1
      if [[ "${SCM_GIT_SHOW_DETAILS}" = "true" ]]; then
        [[ "${staged_count}" -gt 0 ]] && details+=" ${SCM_GIT_STAGED_CHAR}${staged_count}" && SCM_DIRTY=3
        [[ "${unstaged_count}" -gt 0 ]] && details+=" ${SCM_GIT_UNSTAGED_CHAR}${unstaged_count}" && SCM_DIRTY=2
        [[ "${untracked_count}" -gt 0 ]] && details+=" ${SCM_GIT_UNTRACKED_CHAR}${untracked_count}" && SCM_DIRTY=1
      fi
      SCM_STATE=${GIT_THEME_PROMPT_DIRTY:-$SCM_THEME_PROMPT_DIRTY}
    fi
  fi

  [[ "${SCM_GIT_SHOW_CURRENT_USER}" == "true" ]] && details+="$(git_user_info)"

  SCM_CHANGE=$(git rev-parse --short HEAD 2>/dev/null)

  local ref=$(git symbolic-ref -q HEAD 2> /dev/null)
  if [[ -n "$ref" ]]; then
    SCM_BRANCH=${SCM_THEME_BRANCH_PREFIX}${ref#refs/heads/}
    local tracking_info="$(grep "${SCM_BRANCH}\.\.\." <<< "${status}")"
    if [[ -n "${tracking_info}" ]]; then
      [[ "${tracking_info}" =~ .+\[gone\]$ ]] && local branch_gone="true"
      tracking_info=${tracking_info#\#\# ${SCM_BRANCH}...}
      tracking_info=${tracking_info% [*}
      local remote_name=${tracking_info%%/*}
      local remote_branch=${tracking_info#${remote_name}/}
      local remote_info=""
      local num_remotes=$(git remote | wc -l 2> /dev/null)
      [[ "${SCM_BRANCH}" = "${remote_branch}" ]] && local same_branch_name=true
      if ([[ "${SCM_GIT_SHOW_REMOTE_INFO}" = "auto" ]] && [[ "${num_remotes}" -ge 2 ]]) ||
          [[ "${SCM_GIT_SHOW_REMOTE_INFO}" = "true" ]]; then
        remote_info="${remote_name}"
        [[ "${same_branch_name}" != "true" ]] && remote_info+="/${remote_branch}"
      elif [[ ${same_branch_name} != "true" ]]; then
        remote_info="${remote_branch}"
      fi
      if [[ -n "${remote_info}" ]];then
        if [[ "${branch_gone}" = "true" ]]; then
          SCM_BRANCH+="${SCM_THEME_BRANCH_GONE_PREFIX}${remote_info}"
        else
          SCM_BRANCH+="${SCM_THEME_BRANCH_TRACK_PREFIX}${remote_info}"
        fi
      fi
    fi
    SCM_GIT_DETACHED="false"
  else
    local detached_prefix=""
    ref=$(git describe --tags --exact-match 2> /dev/null)
    if [[ -n "$ref" ]]; then
      detached_prefix=${SCM_THEME_TAG_PREFIX}
    else
      ref=$(git describe --contains --all HEAD 2> /dev/null)
      ref=${ref#remotes/}
      [[ -z "$ref" ]] && ref=${SCM_CHANGE}
      detached_prefix=${SCM_THEME_DETACHED_PREFIX}
    fi
    SCM_BRANCH=${detached_prefix}${ref}
    SCM_GIT_DETACHED="true"
  fi

  local ahead_re='.+ahead ([0-9]+).+'
  local behind_re='.+behind ([0-9]+).+'
  [[ "${status}" =~ ${ahead_re} ]] && SCM_BRANCH+=" ${SCM_GIT_AHEAD_CHAR}${BASH_REMATCH[1]}"
  [[ "${status}" =~ ${behind_re} ]] && SCM_BRANCH+=" ${SCM_GIT_BEHIND_CHAR}${BASH_REMATCH[1]}"

  SCM_BRANCH+=${details}

  SCM_PREFIX=${GIT_THEME_PROMPT_PREFIX:-$SCM_THEME_PROMPT_PREFIX}
  SCM_SUFFIX=${GIT_THEME_PROMPT_SUFFIX:-$SCM_THEME_PROMPT_SUFFIX}
}

function clock_char {
    if [[ "${THEME_CLOCK_CHECK}" = true ]]; then
        echo -e "${bold_cyan}$DATE_STRING ${red}$CLOCK_CHAR"
    fi
}

function scm_char {
  scm_prompt_char
  echo -e "$SCM_CHAR"
}

function scm_prompt_info {
  scm
  scm_prompt_char
  SCM_DIRTY=0
  SCM_STATE=''
  [[ $SCM == $SCM_GIT ]] && git_prompt_info && return
}

function prompt_command() {
  CLOCK_CHAR='☆'
  DATE_STRING=$(date +"%Y-%m-%d %H:%M:%S")
  SCM_THEME_PROMPT_PREFIX=" |"

  if [ -z "$DISABLE_COLORS" ]; then
    SCM_THEME_PROMPT_DIRTY=" ${red}✗"
    SCM_THEME_PROMPT_CLEAN=" ${bold_green}✓"
    SCM_THEME_PROMPT_SUFFIX="${green}|"
    
    GIT_THEME_PROMPT_DIRTY=" ${red}✗"
    GIT_THEME_PROMPT_CLEAN=" ${bold_green}✓"
    GIT_THEME_PROMPT_PREFIX=" ${green}|"
    GIT_THEME_PROMPT_SUFFIX="${green}|"

    PS1="\n${bold_cyan}$DATE_STRING ${red}$CLOCK_CHAR ${purple}\h ${reset_color}in ${green}\w\n${bold_cyan}$(scm_char)${green}$(scm_prompt_info) ${green}→${reset_color} "
  else
    SCM_THEME_PROMPT_DIRTY=" ✗"
    SCM_THEME_PROMPT_CLEAN=" ✓"
    SCM_THEME_PROMPT_SUFFIX="|"
    
    GIT_THEME_PROMPT_DIRTY=" ✗"
    GIT_THEME_PROMPT_CLEAN=" ✓"
    GIT_THEME_PROMPT_PREFIX=" |"
    GIT_THEME_PROMPT_SUFFIX="|"

    PS1="\n$DATE_STRING $CLOCK_CHAR \h $in \w\n$(scm_char)$(scm_prompt_info) → "
  fi
}




unset PS1
PROMPT_COMMAND=prompt_command

# The direnv hook modifies PROMPT_COMMAND, so it needs to go after anything that sets PROMPT_COMMAND.
if command -v direnv &> /dev/null; then
  eval "$(direnv hook bash)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

alias k=kubectl
alias kc=kubectl
