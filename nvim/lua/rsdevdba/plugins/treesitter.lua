return {
    { "nvim-tree/nvim-web-devicons" },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = ":TSUpdate",
        config = function()
            -- Migrado para Treesitter nativo do Neovim 0.12
            -- Elimina bug com heredoc em bash (nvim-treesitter arquivado abr/2026)
            vim.treesitter.language.register("bash", "sh")

            require("nvim-treesitter.configs").setup {
                modules = {},
                ensure_installed = {
                    -- Linguagens principais do stack
                    "bash",
                    "go",
                    "gomod",
                    "gowork",
                    "gosum",
                    "sql",
                    "markdown",
                    "markdown_inline",
                    "yaml",
                    "json",
                    "xml",
                    "toml",
                    "php",
                    "rust",
                    -- Lua / Neovim config
                    "lua",
                    "luadoc",
                    "vim",
                    "vimdoc",
                    -- Outros
                    "python",
                    "typescript",
                    "javascript",
                },
                sync_install = false,
                auto_install = true,
                ignore_install = {},
                highlight = {
                    disable = { "bash" },
                    enable = true,
                    -- Usa highlight nativo do Neovim 0.12 (sem nvim-treesitter highlighter)
                    -- Elimina o bug "attempt to call method range (a nil value)"
                    additional_vim_regex_highlighting = { "bash" },
                },
                indent = {
                    enable = true,
                },
                parser_install_dir = nil,
            }
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "master",
    },
}
