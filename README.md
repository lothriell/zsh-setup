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
- `zshrc.local.template` — seeded to `~/.zshrc.local` on first install for per-machine overrides (proxy, private aliases). Never touched on re-install.

## Proxy / per-machine config

`~/.zshrc` sources `~/.zshrc.local` if it exists. On first install the template is copied there; edit it on each work PC and fill in the proxy placeholders, then `exec zsh`. See the template for apt/git proxy one-liners too.

To run the installer itself through a proxy (bootstrap case), set the env vars before the curl:

```bash
export https_proxy=http://PROXY_HOST:PROXY_PORT http_proxy=http://PROXY_HOST:PROXY_PORT
curl -fsSL https://raw.githubusercontent.com/lothriell/zsh-setup/main/install.sh | bash
```

## Font

The atomic theme uses Nerd Font glyphs. In Windows Terminal set the profile font to a Nerd Font (e.g. `MesloLGS NF` or `JetBrainsMono Nerd Font`). Download: https://www.nerdfonts.com/font-downloads
