# start every terminal session with homebrew path added to $PATH env. var
#export PATH=/opt/homebrew/bin:$PATH
export PATH="$HOME/.config/emacs/bin:/opt/homebrew/bin:$PATH"


# home directory of doom emacs
export DOOMDIR="$HOME/.config/doom"


# highlight currently selected item when tabbing
autoload -Uz compinit
compinit
zmodload zsh/complist
zstyle ':completion:*' menu select


# autosuggestions while typing  (MacOS only)
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# set colors for command line
#autoload -U colors && colors
#PS1="%{$fg[green]%}%n%{$reset_color%}@%{$fg[green]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "

# full color terminal
# makes .vimrc load properly
export TERM="xterm-256color"

# pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
