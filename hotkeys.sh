#!/usr/bin/env bash
# Usage: hotkeys [section]
# Sections: tmux, git, files, tools, all (default: all)

# Colors
BOLD='\033[1m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
DIM='\033[2m'
NC='\033[0m'

header() { echo -e "\n${BOLD}${CYAN}$1${NC}"; echo -e "${DIM}$(printf '%.0s─' {1..40})${NC}"; }
row()    { printf "  ${GREEN}%-28s${NC} ${DIM}%s${NC}\n" "$1" "$2"; }
sub()    { echo -e "\n  ${YELLOW}$1${NC}"; }

section_tmux() {
  header "tmux  (prefix: Ctrl+A)"
  sub "Panes"
  row "Ctrl+A |"         "Split vertically (side by side)"
  row "Ctrl+A -"         "Split horizontally (top/bottom)"
  row "Ctrl+A ← → ↑ ↓"  "Switch pane (repeatable)"
  row "Ctrl+A q → number" "Switch pane by number"
  row "Ctrl+A Shift+arrow" "Resize pane"
  row "Ctrl+A z"         "Zoom pane (toggle fullscreen)"
  row "Ctrl+A x"         "Close pane"
  sub "Windows"
  row "Ctrl+A c"         "New window"
  row "Ctrl+A n / p"     "Next / previous window"
  row "Ctrl+A 1-9"       "Switch to window by number"
  row "Ctrl+A ,"         "Rename window"
  sub "Sessions"
  row "Ctrl+A d"         "Detach session"
  row "tmux ls"          "List sessions"
  row "tmux attach -t"   "Attach to named session"
  row "tmux new -s"      "New named session"
  sub "Misc"
  row "Ctrl+A r"         "Reload config"
  row "Ctrl+A ["         "Scroll mode (q to exit)"
  row "Ctrl+A ?"         "List all keybindings"
}

section_git() {
  header "git aliases"
  row "g"     "git"
  row "gs / gst"  "git status"
  row "ga"    "git add"
  row "gaa"   "git add --all"
  row "gcm"   "git commit -m"
  row "gco"   "git checkout"
  row "gcb / gcob" "git checkout -b"
  row "gb"    "git branch"
  row "gba"   "git branch --all"
  row "gbd"   "git branch --delete"
  row "gpo"   "git push origin"
  row "gpom"  "git push origin main"
  row "gpu"   "git push upstream"
  row "lg"    "lazygit (TUI)"
}

section_files() {
  header "files & navigation"
  row "ls"    "eza --icons"
  row "ll"    "eza --icons -l"
  row "la"    "eza --icons -la (hidden files)"
  row "lt"    "eza --icons --tree -L 2"
  row "cat"   "bat (syntax highlighted)"
  row "z <dir>"  "Jump to frecent directory"
  row "zi"    "Interactive directory picker"
}

section_terminal() {
  header "terminal  (readline / prompt)"
  sub "Cursor movement"
  row "Ctrl+A"          "Move to start of line"
  row "Ctrl+E"          "Move to end of line"
  row "Alt+B / Alt+F"   "Move back / forward one word"
  sub "Select & copy prompt input"
  row "Triple-click"    "Select entire input line"
  row "Click → Shift+click" "Select a range of typed text"
  sub "Cut / paste (readline buffer)"
  row "Ctrl+U"          "Cut from cursor to start of line"
  row "Ctrl+K"          "Cut from cursor to end of line"
  row "Ctrl+Y"          "Paste from readline buffer"
  sub "History"
  row "Ctrl+R"          "Reverse search command history"
  row "Ctrl+P / Ctrl+N" "Previous / next history entry"
  sub "Misc"
  row "Ctrl+L"          "Clear screen"
  row "Ctrl+W"          "Delete previous word"
}

section_tools() {
  header "tools"
  sub "lazygit (lg)"
  row "space"  "Stage / unstage file"
  row "c"      "Commit"
  row "p / P"  "Push / Pull"
  row "b"      "Branches"
  row "?"      "Help"
  row "q"      "Quit"
  sub "misc"
  row "itl"    "instruqt track logs"
  row "itu"    "instruqt update"
  row "peon"   "peon-ping controls"
  row "tldr"   "tldr <command>"
}

FILTER="${1:-all}"

case "${FILTER}" in
  tmux)     section_tmux ;;
  git)      section_git ;;
  files)    section_files ;;
  tools)    section_tools ;;
  terminal) section_terminal ;;
  all)
    section_tmux
    section_git
    section_files
    section_tools
    section_terminal
    ;;
  *)
    echo -e "${YELLOW}Usage:${NC} hotkeys [tmux|git|files|tools|terminal|all]"
    exit 1
    ;;
esac

echo ""
