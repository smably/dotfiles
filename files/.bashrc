function title() {
  echo -ne "\033]0;$1\007"
}

function _update_ps1() {
  # Default modules: "venv,user,host,ssh,cwd,perms,git,hg,jobs,exit,root"
  PS1=$(~/go/bin/powerline-go -modules "cwd,perms,node,git,dotenv,jobs,exit,root" $?)
  # can use ${PWD##*/} to just show directory name, but won't interpolate ~
  title "$(printf '%s\n' "${PWD/#$HOME/~}")"
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
  PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

eval "$(nodenv init -)"

eval $(thefuck --alias)

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# -------------------------------------

# Case insensitive completion
bind "set completion-ignore-case on"

# Show all possible completions when tab completing
bind "set show-all-if-ambiguous on"

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Custom colours for ls
export LSCOLORS=ExFxCxDxBxegedabagacad

# -------------------------------------


alias ls='ls -Gph' # colours, / after dirs, human readable units
alias ll='ls -la'
alias git='hub'
