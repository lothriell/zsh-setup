export PATH="$HOME/.local/bin:$PATH"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# No oh-my-zsh theme — oh-my-posh renders the prompt (see bottom of file)
ZSH_THEME=""

# Plugins
plugins=(git
	z
	zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration
ZSH_DISABLE_COMPFIX=true

# Aliases
alias suroot='sudo -E -s'
alias lla='ls -la'
alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --no-user --group-directories-first  --time-style long-iso'
alias la='eza -la --icons --no-user --group-directories-first  --time-style long-iso'

# Oh My Posh prompt
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/themes/atomic.omp.json)"
