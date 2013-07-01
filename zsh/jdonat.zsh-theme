# local color_array=(cyan white yellow magenta black blue red default grey green)
# hostname | md5 -qr | cut -c1

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%(?..%{$fg[red]%}%?↵%{$reset_color%})"
local time_code="%{%(?.$reset_color.$fg[red])%}%*%{$reset_color%}"

PROMPT='%{%(?.$fg[$NCOLOR].$fg[red])%}%n%{$fg[green]%}@%m%{$reset_color%} %(?..%{$fg[red]%})%~ \
$(git_prompt_info)\
%{$fg[red]%}%(!.#.»)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code} ${time_code}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}±%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="⚡"

