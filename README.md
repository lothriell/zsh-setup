# zsh-setup

zsh + oh-my-zsh + oh-my-posh (atomic theme) for WSL2 Ubuntu.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/lothriell/zsh-setup/main/install.sh | bash
```

Then `exec zsh` or open a new terminal.

## What it does

- Installs `zsh`, `eza`, `git`, `curl` via apt
- Installs [oh-my-zsh](https://ohmyz.sh/)
- Installs the `zsh-autosuggestions` plugin
- Installs [oh-my-posh](https://ohmyposh.dev/) to `~/.local/bin`
- Drops `zshrc` to `~/.zshrc` (existing file backed up with a timestamp)
- Drops `atomic.omp.json` to `~/.config/oh-my-posh/themes/`
- Sets `zsh` as the default login shell

Re-running is safe — each step is idempotent.

## Files

- `install.sh` — installer
- `zshrc` — the `.zshrc` installed to `$HOME`
- `atomic.omp.json` — oh-my-posh theme

## Font

The atomic theme uses Nerd Font glyphs. In Windows Terminal set the profile font to a Nerd Font (e.g. `MesloLGS NF` or `JetBrainsMono Nerd Font`). Download: https://www.nerdfonts.com/font-downloads
