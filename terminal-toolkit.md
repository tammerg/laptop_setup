# Terminal Toolkit

Personal reference for the v2 terminal setup.

---

## tmux

**Prefix: `Ctrl+A`**

### Panes

| Action | Keys |
|--------|------|
| Split vertically (side by side) | `Ctrl+A \|` |
| Split horizontally (top/bottom) | `Ctrl+A -` |
| Switch pane by direction (repeatable) | `Ctrl+A` then keep tapping `←` `→` `↑` `↓` |
| Switch pane by number | `Ctrl+A q` → press number |
| Resize pane | `Ctrl+A` + `Shift+←` `→` `↑` `↓` |
| Close pane | `Ctrl+A x` |
| Zoom pane (toggle fullscreen) | `Ctrl+A z` |

### Windows

| Action | Keys |
|--------|------|
| New window | `Ctrl+A c` |
| Next window | `Ctrl+A n` |
| Previous window | `Ctrl+A p` |
| Switch to window by number | `Ctrl+A 1-9` |
| Rename window | `Ctrl+A ,` |
| Close window | `Ctrl+A &` |

### Sessions

| Action | Keys |
|--------|------|
| Detach session | `Ctrl+A d` |
| List sessions | `tmux ls` |
| Attach last session | `tmux attach` |
| Attach named session | `tmux attach -t <name>` |
| New named session | `tmux new -s <name>` |

### Misc

| Action | Keys |
|--------|------|
| Reload config | `Ctrl+A r` |
| Command prompt | `Ctrl+A :` |
| Scroll mode | `Ctrl+A [` (then arrow keys, `q` to exit) |
| List all keybindings | `Ctrl+A ?` |

---

## Zsh Aliases

### Git

| Alias | Command |
|-------|---------|
| `g` | `git` |
| `gs` / `gst` | `git status` |
| `ga` | `git add` |
| `gaa` | `git add --all` |
| `gcm` | `git commit -m` |
| `gco` | `git checkout` |
| `gcb` / `gcob` | `git checkout -b` |
| `gb` | `git branch` |
| `gba` | `git branch --all` |
| `gbd` | `git branch --delete` |
| `gpo` | `git push origin` |
| `gpom` | `git push origin main` |
| `gpu` | `git push upstream` |

### File Navigation

| Alias | Command |
|-------|---------|
| `ls` | `eza --icons` |
| `ll` | `eza --icons -l` |
| `la` | `eza --icons -la` |
| `lt` | `eza --icons --tree -L 2` |
| `cat` | `bat` |
| `z <dir>` | Jump to frecent directory |
| `zi` | Interactive directory picker |

### Tools

| Alias | Command |
|-------|---------|
| `lg` | `lazygit` |
| `tldr` | `tldr` |
| `itl` | `instruqt track logs` |
| `itu` | `instruqt update` |
| `peon` | peon-ping controls |

### Package Managers (SCFW wrapped)

| Alias | Command |
|-------|---------|
| `npm` | `scfw run npm` |
| `pip` | `scfw run pip` |
| `poetry` | `scfw run poetry` |

---

## Tools Quick Reference

### zoxide (`z`)
Frecency-based directory jumping — learns from your `cd` history.

```bash
z projects        # jump to ~/projects
z store           # jump to best match for "store"
zi                # interactive picker (fzf-style)
```

### lazygit (`lg`)
Terminal UI for git. Launch with `lg` inside any repo.

| Key | Action |
|-----|--------|
| `←` `→` | Switch panels |
| `space` | Stage/unstage file |
| `c` | Commit |
| `p` | Push |
| `P` | Pull |
| `b` | Branches |
| `?` | Help |
| `q` | Quit |

### bat (`cat`)
Syntax-highlighted `cat`. Drop-in replacement — just use `cat`.

```bash
cat file.js       # syntax highlighted
cat file.js -n    # with line numbers
```

### eza (`ls`)
Modern `ls` with icons and colors.

```bash
ls                # list with icons
ll                # long format
la                # long format + hidden files
lt                # tree view (2 levels)
```

---

## Setup

To apply this setup on a new machine:

```bash
git clone <repo> ~/projects/dotfiles
cd ~/projects/dotfiles
./setup.sh
```

Backups of replaced configs are saved to `~/.setup-backups/<timestamp>/`.
