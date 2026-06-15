# Dotfiles

Personal macOS development environment managed with GNU Stow and Homebrew.

This repository contains the configuration I use for my shell, terminal, editor, and daily development tools. The setup is intentionally simple: Homebrew installs the required packages, GNU Stow symlinks the dotfiles into `$HOME`, and the bootstrap script installs the external shell and tmux plugins used by the configs.

## What Is Included

- Zsh configuration for the interactive shell, prompt, plugins, aliases, and environment setup.
- Neovim configuration for editor behavior, language tooling, navigation, completion, and UI.
- tmux configuration for terminal multiplexing, pane/window workflows, plugin management, and session behavior.
- Ghostty terminal configuration.
- Homebrew `Brewfile` for command-line tools, applications, and development dependencies.

## Repository Layout

```text
.
|-- Brewfile                 # Homebrew packages, casks, and taps
|-- bootstrap.sh             # One-command setup script
|-- .stow-local-ignore       # Files Stow should not symlink into $HOME
|-- .zshrc                   # Main Zsh configuration
|-- .tmux.conf               # tmux configuration
|-- .ideavimrc               # IdeaVim configuration
`-- .config/
    |-- ghostty/             # Ghostty configuration
    |-- nvim/                # Neovim configuration
    `-- zsh/                 # Additional Zsh scripts and aliases
```

## Installation

Clone the repository into `~/dotfiles`:

```bash
git clone git@github.com:bilaloumehdi/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Run the bootstrap script from the repository root:

```bash
./bootstrap.sh
```

The script will:

1. Install Homebrew if it is missing.
2. Install packages and applications from `Brewfile`.
3. Install `git` if the system does not already provide it.
4. Install Oh My Zsh and the Zsh plugins referenced by `.zshrc`.
5. Symlink the dotfiles into `$HOME` with GNU Stow.
6. Install TPM and the tmux plugins referenced by `.tmux.conf`.
7. Set the default shell to Zsh.

## Before Running Bootstrap

If this is a new machine, make sure Apple's command line tools are available:

```bash
xcode-select --install
```

If you already have dotfiles in `$HOME`, run a Stow dry-run first to check for conflicts:

```bash
cd ~/dotfiles
stow -nv .
```

If Stow reports conflicts, back up or remove the existing files before running `./bootstrap.sh`.

## Manual Commands

Install or update Homebrew dependencies:

```bash
brew bundle --file=Brewfile
```

Check whether Brewfile dependencies are installed without requiring upgrades:

```bash
brew bundle check --no-upgrade --file=Brewfile
```

Preview Stow changes:

```bash
stow -nv .
```

Apply Stow links manually:

```bash
stow .
```

## Notes

- `bootstrap.sh` is expected to be run from the repository root.
- Powerlevel10k is installed by Homebrew and sourced directly from `/opt/homebrew/share/powerlevel10k`.
- `.stow-local-ignore` keeps repository-only files such as `README.md`, `Brewfile`, and `bootstrap.sh` out of `$HOME`.
- tmux plugins are installed through TPM after `.tmux.conf` has been stowed.
