# dotfiles — rsdevdba

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

| Tool | Install |
|---|---|
| `pylsp` | `sudo apt install python3-pylsp` (Ubuntu) or `sudo dnf install python3-pylsp` (RHEL/OL) |
| `ruff` | `curl -LsSf https://astral.sh/ruff/install.sh \| sh` |
| `shfmt` | `go install mvdan.cc/sh/v3/cmd/shfmt@latest` |
| `sqlfluff` | `pip3 install sqlfluff` |

## Platform-specific Installation

### macOS Tahoe

```bash
brew install neovim ripgrep shellcheck php composer
```

### Ubuntu 24.04 / 26.04

```bash
sudo apt update && sudo apt install -y gcc make git curl unzip tar ripgrep shellcheck php php-cli
curl -LO https://github.com/neovim/neovim/releases/download/v0.12.4/nvim-linux-x86_64.tar.gz
tar xf nvim-linux-x86_64.tar.gz && sudo cp -r nvim-linux-x86_64/* /usr/local/ && rm -rf nvim-linux-x86_64*
curl -sS https://getcomposer.org/installer | php && sudo mv composer.phar /usr/local/bin/composer
sudo apt install -y python3-pylsp
pip3 install sqlfluff
```

### WSL (Ubuntu 24.04)

Same as Ubuntu 24.04 above. Neovim runs natively inside WSL without additional configuration.

## Structure

```
dotfiles/
├── nvim/                    ← Neovim config (~/.config/nvim)
│   ├── init.lua
│   └── lua/rsdevdba/
│       ├── init.lua
│       ├── lazy.lua
│       ├── remaps.lua
│       ├── set.lua
│       ├── autocmds.lua
│       └── plugins/
├── wezterm/
│   └── .wezterm.lua         ← WezTerm config (~/.wezterm.lua)
├── install.sh               ← Installation script (symlinks)
└── README.md
```

## Keymaps

Leader key is **space**.

### Files and Navigation

| Keys | Action |
|---|---|
| `space e` | Toggle Neo-tree |
| `space E` | Reveal current file in Neo-tree |
| `space w` | Save file |
| `space b d` | Close current buffer |
| `space x` | Run current file (Go, Lua) |

### Window Navigation

| Keys | Action |
|---|---|
| `Ctrl+w h` | Move to left window |
| `Ctrl+w l` | Move to right window |
| `Ctrl+w j` | Move to window below |
| `Ctrl+w k` | Move to window above |
| `Ctrl+w q` | Close current window |

### LSP

| Keys | Action |
|---|---|
| `g d` | Go to definition |
| `g i` | Go to implementation |
| `K` | Hover documentation |
| `space v r n` | Rename symbol |
| `space v c a` | Code action |
| `space v r f` | Find references |
| `space v w s` | Workspace symbols |

### Diagnostics

| Keys | Action |
|---|---|
| `space v d o` | Open diagnostic float |
| `] d` | Next diagnostic |
| `[ d` | Previous diagnostic |
| `space v d h` | Hide diagnostics |
| `space v d s` | Show diagnostics |

### Clipboard and Editing

| Keys | Action |
|---|---|
| `space y` | Yank to system clipboard |
| `space Y` | Yank line to system clipboard |
| `space p` | Paste from system clipboard |
| `space d` | Delete without yanking |
| `space i e` | Insert error handling block (Go/Python) |

### Status Bar Icons

| Icon | Meaning |
|---|---|
| `△ N` | N warnings |
| `ⓘ N` | N hints |
| `Q N` | N suggestions |
| `✗ N` | N errors |

## SQL — Dialect Configuration

Create a `.sqlfluff` file at the root of each SQL project:

```ini
# Oracle PL/SQL
[sqlfluff]
dialect = oracle
```

```ini
# SQL Server T-SQL
[sqlfluff]
dialect = tsql
```

```ini
# ANSI SQL
[sqlfluff]
dialect = ansi
```

## Known Limitations

### Treesitter + Bash/Markdown + Heredoc/Fenced Code Blocks

The `nvim-treesitter` plugin (archived April 2026) has a bug with Neovim 0.12 that causes an error when parsing heredocs in `.sh` files and fenced code blocks in `.md` files. Workaround applied: Treesitter disabled for `bash` and `markdown`, with regex highlighting as fallback. Full colorization is maintained.

### luarocks

Mason displays warnings about `luarocks` not being available. This is expected and does not affect any LSP in the configured stack. Support disabled in `lazy.lua` with `rocks = { enabled = false }`.

### bash-language-server + Node.js

Requires Node.js >= 18. Node.js 16 or lower causes LSP startup failure. Install Node.js 24 via nvm as documented above.
