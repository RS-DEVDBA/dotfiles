# dotfiles — rsdevdba

[![English](https://img.shields.io/badge/lang-English-blue)](README.md)
[![Português](https://img.shields.io/badge/lang-Português-green)](README.pt.md)
[![Español](https://img.shields.io/badge/lang-Español-red)](README.es.md)

Personal development environment configuration: Neovim + WezTerm.

## Stack

- **Editor:** Neovim 0.12.x with Lazy.nvim
- **Terminal:** WezTerm
- **Languages:** Go, Python, Rust, Bash, SQL (Oracle PL/SQL, T-SQL, ANSI), YAML, JSON, XML, TOML, PHP, Markdown, Lua

## Prerequisites

| Tool | Purpose |
|---|---|
| Neovim >= 0.12 | Editor |
| Git | Required by Lazy.nvim to clone plugins |
| Node.js >= 18 (via nvm) | Required by bash-language-server and other LSPs |
| Go | Required for Go development and tools |
| uv (Python env manager) | Required by chase.nvim |
| ripgrep | Required by Telescope live grep |
| shellcheck | Bash linter |

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/RS-DEVDBA/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

### 2. Install Node.js via nvm

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash
source ~/.bashrc  # or ~/.zshrc
nvm install 24
nvm use 24
nvm alias default 24
```

### 3. Install uv

```bash
curl -LsSf https://astral.sh/uv/install.sh | UV_INSTALL_DIR=/usr/local/bin sh
```

### 4. Install Neovim plugins

Open Neovim and run:

```
:Lazy sync
```

### 5. Install LSPs via Mason

Inside Neovim:

```
:MasonUpdate
```

## External Tools (not managed by Mason)

| Tool | Purpose | Install |
|---|---|---|
| `pylsp` | Python LSP | `sudo apt install python3-pylsp` (Ubuntu) or `sudo dnf install python3-pylsp` (RHEL/OL) or `brew install pylsp` (MacOS) |
| `ruff` | Python linter/formatter | `curl -LsSf https://astral.sh/ruff/install.sh \| sh` |
| `shfmt` | Bash formatter | `go install mvdan.cc/sh/v3/cmd/shfmt@latest` |
| `sqlfluff` | SQL linter | `pip3 install sqlfluff` |
