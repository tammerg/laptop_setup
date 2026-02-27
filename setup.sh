#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# Tammer's System Setup v2
# Idempotent — safe to re-run at any time.
# Backs up existing configs to ~/.setup-backups/<timestamp>/
# ============================================================

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="${HOME}/.setup-backups/$(date +%Y%m%d-%H%M%S)"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log()     { echo -e "${BLUE}==>${NC} $*"; }
success() { echo -e "${GREEN}  ✓${NC} $*"; }
warn()    { echo -e "${YELLOW}  !${NC} $*"; }

# ============================================================
# Backup a file before overwriting
# ============================================================
backup_file() {
  local file="$1"
  if [[ -f "${file}" ]]; then
    mkdir -p "${BACKUP_DIR}"
    local filename
    filename="$(basename "${file}")"
    cp "${file}" "${BACKUP_DIR}/setup-backup-${filename}"
    warn "Backed up ${file} → ${BACKUP_DIR}/setup-backup-${filename}"
  fi
}

# ============================================================
# 1. Homebrew
# ============================================================
install_homebrew() {
  log "Checking Homebrew..."
  if ! command -v brew &>/dev/null; then
    log "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    success "Homebrew installed"
  else
    success "Homebrew already installed ($(brew --version | head -1))"
  fi
}

# ============================================================
# 2. Brew packages
# ============================================================
install_packages() {
  log "Installing packages..."

  local packages=(
    starship
    zoxide
    zsh-autosuggestions
    zsh-fast-syntax-highlighting
    eza
    bat
    lazygit
    tmux
  )

  for pkg in "${packages[@]}"; do
    if brew list "${pkg}" &>/dev/null; then
      success "${pkg} already installed"
    else
      log "Installing ${pkg}..."
      brew install "${pkg}"
      success "${pkg} installed"
    fi
  done
}

# ============================================================
# 3. .zshrc
# ============================================================
install_zshrc() {
  log "Installing .zshrc..."
  backup_file "${HOME}/.zshrc"
  cp "${DOTFILES_DIR}/configs/zshrc" "${HOME}/.zshrc"
  success ".zshrc installed"
}

# ============================================================
# 4. .tmux.conf
# ============================================================
install_tmux_conf() {
  log "Installing .tmux.conf..."
  backup_file "${HOME}/.tmux.conf"
  cp "${DOTFILES_DIR}/configs/tmux.conf" "${HOME}/.tmux.conf"
  success ".tmux.conf installed"
}

# ============================================================
# 5. Cursor IDE settings
# ============================================================
install_cursor_settings() {
  log "Installing Cursor settings..."
  local cursor_settings_dir="${HOME}/Library/Application Support/Cursor/User"
  local cursor_settings_file="${cursor_settings_dir}/settings.json"

  if [[ ! -d "${cursor_settings_dir}" ]]; then
    warn "Cursor settings directory not found — skipping (is Cursor installed?)"
    return 0
  fi

  backup_file "${cursor_settings_file}"
  cp "${DOTFILES_DIR}/configs/cursor-settings.json" "${cursor_settings_file}"
  success "Cursor settings installed"
}

# ============================================================
# 6. Pre-generate init caches
# ============================================================
generate_caches() {
  log "Generating init caches..."
  mkdir -p "${HOME}/.cache"

  if command -v starship &>/dev/null; then
    starship init zsh > "${HOME}/.cache/starship_init.zsh"
    success "Starship cache generated"
  else
    warn "starship not found — skipping cache"
  fi

  if command -v zoxide &>/dev/null; then
    zoxide init zsh > "${HOME}/.cache/zoxide_init.zsh"
    success "Zoxide cache generated"
  else
    warn "zoxide not found — skipping cache"
  fi
}

# ============================================================
# Main
# ============================================================
main() {
  echo ""
  echo "  System Setup v2"
  echo "  ==============="
  echo ""

  install_homebrew
  echo ""
  install_packages
  echo ""
  install_zshrc
  install_tmux_conf
  echo ""
  install_cursor_settings
  echo ""
  generate_caches

  echo ""
  echo -e "${GREEN}Setup complete!${NC} Open a new terminal tab to apply changes."
  echo ""

  if [[ -d "${BACKUP_DIR}" ]]; then
    warn "Backups saved to: ${BACKUP_DIR}"
  fi
}

main "$@"
