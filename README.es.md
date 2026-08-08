# dotfiles — rsdevdba

[![English](https://img.shields.io/badge/lang-English-blue)](README.md)
[![Português](https://img.shields.io/badge/lang-Português-green)](README.pt.md)
[![Español](https://img.shields.io/badge/lang-Español-red)](README.es.md)

Configuración personal del entorno de desarrollo: Neovim + WezTerm.

## Stack

- **Editor:** Neovim 0.12.x con Lazy.nvim
- **Terminal:** WezTerm
- **Lenguajes:** Go, Python, Rust, Bash, SQL (Oracle PL/SQL, T-SQL, ANSI), YAML, JSON, XML, TOML, PHP, Markdown, Lua

## Requisitos previos

| Herramienta | Propósito |
|---|---|
| Neovim >= 0.12 | Editor |
| Git | Requerido por Lazy.nvim para clonar plugins |
| Node.js >= 18 (via nvm) | Requerido por bash-language-server y otros LSPs |
| Go | Requerido para desarrollo en Go y herramientas |
| uv (gestor Python) | Requerido por chase.nvim |
| ripgrep | Requerido por el live grep de Telescope |
| shellcheck | Linter para Bash |

## Instalación

### 1. Clonar el repositorio

```bash
git clone https://github.com/RS-DEVDBA/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

### 2. Instalar Node.js via nvm

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash
source ~/.bashrc  # o ~/.zshrc
nvm install 24
nvm use 24
nvm alias default 24
```

### 3. Instalar uv

```bash
curl -LsSf https://astral.sh/uv/install.sh | UV_INSTALL_DIR=/usr/local/bin sh
```

### 4. Instalar plugins de Neovim

Abra Neovim y ejecute:

```
:Lazy sync
```

### 5. Instalar LSPs via Mason

Dentro de Neovim:

```
:MasonUpdate
```

## Herramientas externas (no gestionadas por Mason)

| Herramienta | Propósito | Instalación |
|---|---|---|
| `pylsp` | LSP Python | `sudo apt install python3-pylsp` (Ubuntu) o `sudo dnf install python3-pylsp` (RHEL/OL) o `brew install pylsp` (MacOS) |
| `ruff` | Linter/formatter Python | `curl -LsSf https://astral.sh/ruff/install.sh \| sh` |
| `shfmt` | Formatter Bash | `go install mvdan.cc/sh/v3/cmd/shfmt@latest` |
| `sqlfluff` | Linter SQL | `pip3 install sqlfluff` |
