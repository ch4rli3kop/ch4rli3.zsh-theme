# ch4rli3kop custom zsh theme
# github.com/ch4rli3kop

setopt prompt_subst
setopt prompt_cr prompt_sp

local line_color=241
typeset -g CH4RLI3_PREFIX=""
typeset -g CH4RLI3_LINE=""

# add "(project)" only venv enabled
prompt_prefix() {
  local conda=""
  local venv=""

  # conda env
  [[ -n "$CONDA_DEFAULT_ENV" ]] && conda="$CONDA_DEFAULT_ENV"

  # python venv
  if [[ -n "$VIRTUAL_ENV" ]]; then
    venv="${VIRTUAL_ENV:h:t}"   # /path/proj/.venv -> proj
  fi

  if [[ -n "$conda" && -n "$venv" ]]; then
    print -r -- "(${conda}:${venv}) "
  elif [[ -n "$conda" ]]; then
    print -r -- "(${conda}) "
  elif [[ -n "$venv" ]]; then
    print -r -- "(${venv}) "
  else
    print -r -- ""
  fi
}

build_line() {
  local prefix="$1"
  local plen=${#prefix}
  local n=$(( COLUMNS - plen ))
  (( n < 0 )) && n=0
  print -r -- "${(l:$n::-:)}"
}

# calculate line dynamically
precmd() {
  CH4RLI3_PREFIX="$(prompt_prefix)"
  CH4RLI3_LINE="$(build_line "$CH4RLI3_PREFIX")"
}

PROMPT='${CH4RLI3_PREFIX}%F{'"$line_color"'}${CH4RLI3_LINE}%f
%{$terminfo[bold]$fg[cyan]%}%n \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}[%~]%{$reset_color%} \
%{$fg[red]%}%* \
%{$terminfo[bold]$fg_bold[white]%}› %{$reset_color%}'

