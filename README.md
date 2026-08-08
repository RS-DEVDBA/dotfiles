# dotfiles — rsdevdba

Configuração pessoal de ambiente de desenvolvimento: Neovim + WezTerm.

## Stack

- **Editor:** Neovim 0.12.x com Lazy.nvim
- **Terminal:** WezTerm
- **Linguagens:** Go, Python, Rust, Bash, SQL (Oracle PL/SQL, T-SQL, ANSI), YAML, JSON, XML, TOML, PHP, Markdown, Lua

## Pré-requisitos

### Todas as plataformas

| Ferramenta | Instalação |
|---|---|
| Neovim >= 0.12 | Ver abaixo por plataforma |
| Git | Sistema |
| Node.js >= 18 (via nvm) | `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh \| bash` |
| Go | https://go.dev/dl |
| uv (Python env manager) | `curl -LsSf https://astral.sh/uv/install.sh \| UV_INSTALL_DIR=/usr/local/bin sh` |
| ripgrep | Ver abaixo por plataforma |
| shellcheck | Ver abaixo por plataforma |

### Oracle Linux / RHEL 8.x

```bash
sudo dnf install -y gcc make git curl unzip tar
curl -LO https://github.com/neovim/neovim/releases/download/v0.12.4/nvim-linux-x86_64.tar.gz
tar xf nvim-linux-x86_64.tar.gz && sudo cp -r nvim-linux-x86_64/* /usr/local/ && rm -rf nvim-linux-x86_64*
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/15.1.0/ripgrep-15.1.0-x86_64-unknown-linux-musl.tar.gz
tar xf ripgrep-15.1.0-x86_64-unknown-linux-musl.tar.gz && sudo cp ripgrep-15.1.0-x86_64-unknown-linux-musl/rg /usr/local/bin/ && rm -rf ripgrep-15.1.0-x86_64-unknown-linux-musl*
curl -LO https://github.com/koalaman/shellcheck/releases/download/v0.11.0/shellcheck-v0.11.0.linux.x86_64.tar.xz
tar xf shellcheck-v0.11.0.linux.x86_64.tar.xz && sudo cp shellcheck-v0.11.0/shellcheck /usr/local/bin/ && rm -rf shellcheck-v0.11.0*
sudo dnf install -y https://rpms.remirepo.net/enterprise/remi-release-8.rpm
sudo dnf module reset php -y && sudo dnf module enable php:remi-8.5 -y && sudo dnf install -y php-cli php-common
curl -sS https://getcomposer.org/installer | php && sudo mv composer.phar /usr/local/bin/composer
```

### Oracle Linux / RHEL 9.x

```bash
sudo dnf install -y gcc make git curl unzip tar
curl -LO https://github.com/neovim/neovim/releases/download/v0.12.4/nvim-linux-x86_64.tar.gz
tar xf nvim-linux-x86_64.tar.gz && sudo cp -r nvim-linux-x86_64/* /usr/local/ && rm -rf nvim-linux-x86_64*
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/15.1.0/ripgrep-15.1.0-x86_64-unknown-linux-musl.tar.gz
tar xf ripgrep-15.1.0-x86_64-unknown-linux-musl.tar.gz && sudo cp ripgrep-15.1.0-x86_64-unknown-linux-musl/rg /usr/local/bin/ && rm -rf ripgrep-15.1.0-x86_64-unknown-linux-musl*
curl -LO https://github.com/koalaman/shellcheck/releases/download/v0.11.0/shellcheck-v0.11.0.linux.x86_64.tar.xz
tar xf shellcheck-v0.11.0.linux.x86_64.tar.xz && sudo cp shellcheck-v0.11.0/shellcheck /usr/local/bin/ && rm -rf shellcheck-v0.11.0*
sudo dnf install -y https://rpms.remirepo.net/enterprise/remi-release-9.rpm
sudo dnf module reset php -y && sudo dnf module enable php:remi-8.5 -y && sudo dnf install -y php-cli php-common
curl -sS https://getcomposer.org/installer | php && sudo mv composer.phar /usr/local/bin/composer
```

### Oracle Linux / RHEL 10.x

```bash
sudo dnf install -y gcc make git curl unzip tar
curl -LO https://github.com/neovim/neovim/releases/download/v0.12.4/nvim-linux-x86_64.tar.gz
tar xf nvim-linux-x86_64.tar.gz && sudo cp -r nvim-linux-x86_64/* /usr/local/ && rm -rf nvim-linux-x86_64*
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/15.1.0/ripgrep-15.1.0-x86_64-unknown-linux-musl.tar.gz
tar xf ripgrep-15.1.0-x86_64-unknown-linux-musl.tar.gz && sudo cp ripgrep-15.1.0-x86_64-unknown-linux-musl/rg /usr/local/bin/ && rm -rf ripgrep-15.1.0-x86_64-unknown-linux-musl*
curl -LO https://github.com/koalaman/shellcheck/releases/download/v0.11.0/shellcheck-v0.11.0.linux.x86_64.tar.xz
tar xf shellcheck-v0.11.0.linux.x86_64.tar.xz && sudo cp shellcheck-v0.11.0/shellcheck /usr/local/bin/ && rm -rf shellcheck-v0.11.0*
sudo dnf install -y https://rpms.remirepo.net/enterprise/remi-release-10.rpm
sudo dnf module reset php -y && sudo dnf module enable php:remi-8.5 -y && sudo dnf install -y php-cli php-common
curl -sS https://getcomposer.org/installer | php && sudo mv composer.phar /usr/local/bin/composer
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

### macOS Tahoe

```bash
brew install neovim ripgrep shellcheck php composer
```

## Instalação

```bash
git clone https://github.com/RS-DEVDBA/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

Abra o Neovim e rode:

```
:Lazy sync
```

## LSPs via Mason

Dentro do Neovim após instalar os plugins:

```
:MasonUpdate
```

## Plugins Externos (não gerenciados pelo Mason)

| Ferramenta | Instalação |
|---|---|
| `pylsp` | `sudo apt install python3-pylsp` (Ubuntu) ou `sudo dnf install python3-pylsp` (RHEL/OL) |
| `ruff` | `curl -LsSf https://astral.sh/ruff/install.sh \| sh` |
| `shfmt` | `go install mvdan.cc/sh/v3/cmd/shfmt@latest` |
| `sqlfluff` | `pip3 install sqlfluff` |

## Estrutura

```
dotfiles/
├── nvim/                    ← config do Neovim (~/.config/nvim)
│   ├── init.lua
│   └── lua/rsdevdba/
│       ├── init.lua
│       ├── lazy.lua
│       ├── remaps.lua
│       ├── set.lua
│       ├── autocmds.lua
│       └── plugins/
├── wezterm/
│   └── .wezterm.lua         ← config do WezTerm (~/.wezterm.lua)
├── install.sh               ← script de instalação via symlinks
└── README.md
```

## Keymaps

A tecla líder é o **espaço**.

| Teclas | Ação |
|---|---|
| `espaço e` | Abrir/fechar Neo-tree |
| `espaço w` | Salvar arquivo |
| `espaço x` | Executar arquivo (Go, Lua) |
| `g d` | Ir para definição |
| `K` | Documentação hover |
| `espaço v r n` | Renomear símbolo |
| `espaço v d o` | Abrir diagnóstico na linha |
| `] d` | Próximo diagnóstico |
| `[ d` | Diagnóstico anterior |
| `espaço y` | Copiar para clipboard do sistema |
| `espaço p` | Colar do clipboard do sistema |
