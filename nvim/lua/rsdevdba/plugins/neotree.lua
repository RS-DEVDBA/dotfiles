return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("neo-tree").setup({
                close_if_last_window = true,
                popup_border_style = "rounded",
                enable_git_status = true,
                enable_diagnostics = true,
                window = {
                    position = "left",
                    width = 35,
                    mappings = {
                        ["<space>"] = "toggle_preview", -- preview com espaço
                        ["l"] = "open",
                        ["h"] = "close_node",
                        ["S"] = "open_split",
                        ["s"] = "open_vsplit",
                    },
                },
                filesystem = {
                    follow_current_file = {
                        enabled = true, -- destaca o arquivo atual na árvore
                    },
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
                -- Preview do arquivo ao lado direito ao navegar
                preview = {
                    use_float = false, -- mostra em split, não em float
                },
            })

            -- Abrir/fechar Neo-tree com espaço+e
            vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>",
                { desc = "Toggle Neo-tree" })

            -- Revelar arquivo atual na árvore com espaço+E
            vim.keymap.set("n", "<leader>E", "<cmd>Neotree reveal<CR>",
                { desc = "Reveal file in Neo-tree" })
        end,
    },
}
