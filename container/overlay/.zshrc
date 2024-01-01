# Load oh-my-zsh

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="trapd00r"

HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode disabled  # disable automatic updates

HIST_STAMPS="%Y-%m-%d %H:%M:%S"

plugins=(
  git
  git-commit
  git-escape-magic
  git-extras
  git-prompt
  gitfast
  gitignore
)

source $ZSH/oh-my-zsh.sh
