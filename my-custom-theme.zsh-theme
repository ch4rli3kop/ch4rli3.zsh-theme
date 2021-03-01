# ch4rli3kop custom zsh theme
# github.com/ch4rli3kop

local current_dir='${PWD/#$HOME/~}'
local line_color=241

print_line()
{
  dash='\e[38;5;${line_color}m-'
  for i in {1..$((COLUMNS))}
  do
    echo -ne $dash
  done
}
# prompt format: USER in [DIRECTORY] TIME ›
PROMPT="$(print_line)
%{$terminfo[bold]$fg[cyan]%}%n \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}[${current_dir}]%{$reset_color%} \
%{$fg[red]%}%* \
%{$terminfo[bold]$fg_bold[white]%}› %{$reset_color%}"
