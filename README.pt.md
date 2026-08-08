# dotfiles — rsdevdba

[![English](https://img.shields.io/badge/lang-English-blue)](README.md)
[![Português](https://img.shields.io/badge/lang-Português-green)](README.pt.md)
[![Español](https://img.shields.io/badge/lang-Español-red)](README.es.md)

Configuração pessoal de ambiente de desenvolvimento: Neovim + WezTerm.

## Stack

- **Editor:** Neovim 0.12.x com Lazy.nvim
- **Terminal:** WezTerm
- **Linguagens:** Go, Python, Rust, Bash, SQL (Oracle PL/SQL, T-SQL, ANSI), YAML, JSON, XML, TOML, PHP, Markdown, Lua

## Pré-requisitos

| Ferramenta | Finalidade |
|---|---|
| Neovim >= 0.12 | Editor |
| Git | Necessário para o Lazy.nvim clonar plugins |
| Node.js >= 18 (via nvm) | Necessário para bash-language-server e outros LSPs |
| Go | Necessário para desenvolvimento Go e ferramentas |
| uv (gerenciador Python) | Necessário pelo chase.nvim |
| ripgrep | Necessário pelo live grep do Telescope |
| shellcheck | Linter para Bash |

## Instalação

### 1. Clonar o repositório

```bash
git clone https://github.com/RS-DEVDBA/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

### 2. Instalar Node.js via nvm

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash
source ~/.bashrc  # ou ~/.zshrc
nvm install 24
nvm use 24
nvm alias default 24
```

### 3. Instalar uv

```bash
curl -LsSf https://astral.sh/uv/install.sh | UV_INSTALL_DIR=/usr/local/bin sh
```

### 4. Instalar plugins do Neovim

Abra o Neovim e rode:

```
:Lazy sync
```

### 5. Instalar LSPs via Mason

Dentro do Neovim:

```
:MasonUpdate
```

## Ferramentas Externas (não gerenciadas pelo Mason)

| Ferramenta | Finalidade | Instalação |
|---|---|---|
| `pylsp` | LSP Python | `sudo apt install python3-pylsp` (Ubuntu) ou `sudo dnf install python3-pylsp` (RHEL/OL) ou `brew install pylsp` (MacOS) |
| `ruff` | Linter/formatter Python | `curl -LsSf https://astral.sh/ruff/install.sh \| sh` |
| `shfmt` | Formatter Bash | `go install mvdan.cc/sh/v3/cmd/shfmt@latest` |
| `sqlfluff` | Linter SQL | `pip3 install sqlfluff` |
