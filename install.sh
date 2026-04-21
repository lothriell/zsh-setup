#!/usr/bin/env bash
# zsh + oh-my-zsh + oh-my-posh setup for WSL2 Ubuntu
# Usage: curl -fsSL https://raw.githubusercontent.com/lothriell/zsh-setup/main/install.sh | bash

set -euo pipefail

REPO_RAW="https://raw.githubusercontent.com/lothriell/zsh-setup/main"
OMP_THEME_DIR="$HOME/.config/oh-my-posh/themes"
OMZ_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

log() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }

require_ubuntu() {
	if ! command -v apt-get >/dev/null 2>&1; then
		echo "This script targets Ubuntu (WSL2). apt-get not found." >&2
		exit 1
	fi
}

install_apt_packages() {
	log "Installing base packages (zsh, curl, git, unzip)"
	sudo apt-get update -qq
	sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq zsh curl git unzip ca-certificates
}

install_eza() {
	if command -v eza >/dev/null 2>&1; then
		log "eza already installed"
		return
	fi
	log "Installing eza"
	if sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq eza 2>/dev/null; then
		return
	fi
	log "eza not in apt — adding gierens.de repo"
	sudo mkdir -p /etc/apt/keyrings
	curl -fsSL https://raw.githubusercontent.com/eza-community/eza/main/deb.asc |
		sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
	echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" |
		sudo tee /etc/apt/sources.list.d/gierens.list >/dev/null
	sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
	sudo apt-get update -qq
	sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq eza
}

install_oh_my_zsh() {
	if [[ -d "$HOME/.oh-my-zsh" ]]; then
		log "oh-my-zsh already installed"
		return
	fi
	log "Installing oh-my-zsh"
	RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}

install_zsh_autosuggestions() {
	local dest="$OMZ_CUSTOM/plugins/zsh-autosuggestions"
	if [[ -d "$dest" ]]; then
		log "zsh-autosuggestions already installed — updating"
		git -C "$dest" pull --quiet --ff-only || true
		return
	fi
	log "Installing zsh-autosuggestions"
	git clone --depth=1 --quiet https://github.com/zsh-users/zsh-autosuggestions "$dest"
}

install_oh_my_posh() {
	mkdir -p "$HOME/.local/bin"
	if command -v oh-my-posh >/dev/null 2>&1; then
		log "oh-my-posh already installed — upgrading"
	else
		log "Installing oh-my-posh to ~/.local/bin"
	fi
	curl -fsSL https://ohmyposh.dev/install.sh | bash -s -- -d "$HOME/.local/bin" >/dev/null

	case ":$PATH:" in
	*":$HOME/.local/bin:"*) ;;
	*) export PATH="$HOME/.local/bin:$PATH" ;;
	esac
}

fetch_configs() {
	log "Fetching zshrc and atomic theme"
	mkdir -p "$OMP_THEME_DIR"
	curl -fsSL "$REPO_RAW/atomic.omp.json" -o "$OMP_THEME_DIR/atomic.omp.json"

	if [[ -f "$HOME/.zshrc" ]] && ! grep -q 'atomic.omp.json' "$HOME/.zshrc"; then
		local backup="$HOME/.zshrc.backup.$(date +%Y%m%d-%H%M%S)"
		log "Backing up existing .zshrc to $backup"
		cp "$HOME/.zshrc" "$backup"
	fi
	curl -fsSL "$REPO_RAW/zshrc" -o "$HOME/.zshrc"
}

set_default_shell() {
	local zsh_bin
	zsh_bin="$(command -v zsh)"
	if [[ "${SHELL:-}" == "$zsh_bin" ]]; then
		log "zsh already the default shell"
		return
	fi
	log "Setting zsh as default shell for $USER"
	if ! grep -q "^$zsh_bin$" /etc/shells; then
		echo "$zsh_bin" | sudo tee -a /etc/shells >/dev/null
	fi
	sudo chsh -s "$zsh_bin" "$USER"
}

main() {
	require_ubuntu
	install_apt_packages
	install_eza
	install_oh_my_zsh
	install_zsh_autosuggestions
	install_oh_my_posh
	fetch_configs
	set_default_shell
	log "Done. Start a new shell or run: exec zsh"
}

main "$@"
