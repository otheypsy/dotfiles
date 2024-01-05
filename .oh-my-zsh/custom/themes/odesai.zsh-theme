# vim:ft=zsh ts=2 sw=2 sts=2

# Must use Powerline font, for \uE0A0 to render.
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}\uE0A0 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%} ✗"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%} ✔"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_RUBY_PROMPT_PREFIX="%{$fg_bold[red]%}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="›%{$reset_color%}"

PROMPT='
%{$fg[cyan]%}%n%{$reset_color%} ➜ %{$fg[green]%}%~%{$reset_color%}$(git_prompt_info) %{$reset_color%}
$ '

RPROMPT='$(ruby_prompt_info)'

# Printing error message if command failed.
precmd()
{
    # Command failed
    if [ $? -ne 0 ]; then
        echo "$fg_bold[red]✗ Failed"
    else
        echo "$fg_bold[green]✔ Success"
    fi
}

