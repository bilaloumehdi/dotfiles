#!/usr/bin/env bash

set -euo pipefail

load_homebrew_shellenv() {
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

clone_if_missing() {
  local repo="$1"
  local target="$2"

  if [[ -d "$target/.git" ]]; then
    return
  fi

  if [[ -e "$target" ]]; then
    echo "Skipping $target because it already exists and is not a git checkout." >&2
    return
  fi

  git clone --depth=1 "$repo" "$target"
}

ensure_git() {
  if ! command -v git >/dev/null 2>&1; then
    brew install git
  fi
}

install_zsh_plugins() {
  clone_if_missing "https://github.com/ohmyzsh/ohmyzsh.git" "$HOME/.oh-my-zsh"

  local zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
  mkdir -p "$zsh_custom/plugins"

  clone_if_missing "https://github.com/zsh-users/zsh-autosuggestions.git" "$zsh_custom/plugins/zsh-autosuggestions"
  clone_if_missing "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$zsh_custom/plugins/zsh-syntax-highlighting"
  clone_if_missing "https://github.com/jeffreytse/zsh-vi-mode.git" "$zsh_custom/plugins/zsh-vi-mode"
}

install_tmux_plugins() {
  local tpm_dir="$HOME/.tmux/plugins/tpm"

  clone_if_missing "https://github.com/tmux-plugins/tpm.git" "$tpm_dir"

  if [[ -x "$tpm_dir/bin/install_plugins" ]]; then
    "$tpm_dir/bin/install_plugins"
  fi
}

# Install Homebrew if missing
load_homebrew_shellenv

if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  load_homebrew_shellenv
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew was installed, but brew is not available in PATH." >&2
  exit 1
fi

# Install packages
brew bundle

# Install git if the system does not already provide it.
ensure_git

# Install shell plugins used by .zshrc
install_zsh_plugins

# Stow dotfiles
stow .

# Install tmux plugin manager and configured tmux plugins
install_tmux_plugins

# Set up shell
chsh -s "$(which zsh)"
