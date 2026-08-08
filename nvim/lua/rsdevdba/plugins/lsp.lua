return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "mason-org/mason.nvim" },
            { "mason-org/mason-lspconfig.nvim" },
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                automatic_enable = false, -- LSPs habilitados manualmente no BufReadPost
                ensure_installed = {
                    -- Shell
                    "bashls",       -- Bash LSP (shellcheck integrado via config abaixo)
                    -- Go
                    "gopls",        -- Go completo
                    -- SQL
                    "sqls",         -- SQL LSP: ANSI, Oracle, T-SQL (autocomplete/hover)
                    -- Markup / Config
                    "marksman",     -- Markdown (links, referências, TOC)
                    "yamlls",       -- YAML + schema Docker Compose
                    "jsonls",       -- JSON
                    "lemminx",      -- XML
                    -- PHP
                    "intelephense", -- PHP LSP
                    -- Lua (config do próprio nvim)
                    "lua_ls",
                    -- Gramática / prosa
                    "ltex",
                    -- Protobuf
                    "buf_ls",
                    -- TypeScript/JS
                    "ts_ls",
                    "ts_query_ls",
                    -- TOML
                    "taplo",
                    -- Rust
                    "rust_analyzer",
                    -- Python
                    "pylsp",
                    "ruff",
                },
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(event)
                    local get_opts = function(desc)
                        return { desc = desc, buffer = event.buf }
                    end

                    vim.keymap.set("n", "<C-k>", function() vim.lsp.buf.signature_help() end, get_opts("Signature help"))
                    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, get_opts("Go to definition"))
                    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end,
                        get_opts("Go to implementation"))
                    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, get_opts("Code action"))
                    vim.keymap.set("n", "<leader>vdc", function() vim.lsp.buf.declaration() end,
                        get_opts("Go to declaration"))
                    vim.keymap.set("n", "<leader>vrf", function() vim.lsp.buf.references() end,
                        get_opts("Find references"))
                    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, get_opts("Rename symbol"))
                    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, get_opts("Hover documentation"))
                    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end,
                        get_opts("Search workspace symbols"))
                    vim.keymap.set("n", "<leader>vdo", function() vim.diagnostic.open_float() end,
                        get_opts("Open diagnostics in float window"))
                    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end,
                        get_opts("Jump to previous diagnostic"))
                    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end,
                        get_opts("Jump to next diagnostic"))
                    vim.keymap.set("n", "<leader>vdh", function() vim.diagnostic.hide() end,
                        get_opts("Hides diagnostics"))
                    vim.keymap.set("n", "<leader>vds", function() vim.diagnostic.show() end,
                        get_opts("Shows diagnostics"))
                    vim.keymap.set("n", "<leader>vth", function() vim.diagnostic.config({ virtual_text = false }) end,
                        get_opts("Disable virtual text diagnostics"))
                    vim.keymap.set("n", "<leader>vts", function() vim.diagnostic.config({ virtual_text = true }) end,
                        get_opts("Enable virtual text diagnostics"))

                    -- FORMAT ON SAVE via conform.nvim (shfmt para bash, LSP para demais)
                    vim.keymap.set("n", "<leader>fm", function()
                        require("conform").format({ bufnr = event.buf, timeout_ms = 3000 })
                    end, get_opts("Format buffer"))
                end,
            })

            vim.api.nvim_create_autocmd("BufReadPost", {
                callback = function()
                    local capabilities = vim.tbl_deep_extend(
                        "force",
                        vim.lsp.protocol.make_client_capabilities(),
                        require("cmp_nvim_lsp").default_capabilities()
                    )
                    local installed_servers = require("mason-lspconfig").get_installed_servers()

                    -- Paths para intelephense (PHP)
                    local intelephense_includes_file = vim.fs.joinpath(
                        vim.fn.expand("~"), ".intelephense_extra_includes"
                    )
                    local include_paths = { ".", vim.fn.getcwd(), "/usr/share/pear", "/usr/share/php" }
                    if vim.fn.filereadable(intelephense_includes_file) == 1 then
                        local lines = vim.fn.readfile(intelephense_includes_file)
                        for _, line in ipairs(lines) do
                            include_paths[#include_paths + 1] = line
                        end
                    end

                    local custom_configs = {
                        -- Bash: integração com shellcheck para lint
                        bashls       = {
                            settings = {
                                bashIde = {
                                    shellcheckPath = "shellcheck",
                                    shellcheckArguments = "-x",
                                },
                            },
                        },

                        -- Go
                        gopls        = {
                            settings = {
                                gopls = {
                                    env = {
                                        GOFLAGS = "-tags=integration,end2end,live,unit",
                                    },
                                    analyses = {
                                        unusedparams = true,
                                        shadow = true,
                                        ST1020 = false, -- desabilita warning de comentários
                                        ST1021 = false, -- desabilita warning de comentários de tipos
                                        ST1022 = false, -- desabilita warning de comentários de variáveis
                                        ST1000 = false, -- desabilita warning de comentários de pacote
                                    },
                                    staticcheck = true,
                                },
                            },
                        },

                        -- SQL
                        sqls         = {
                            on_attach = function(client, _)
                                client.server_capabilities.documentFormattingProvider = false
                            end,
                        },

                        -- YAML: schema Docker Compose
                        yamlls       = {
                            settings = {
                                yaml = {
                                    keyOrdering = false,
                                    schemas = {
                                        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
                                            "docker-compose*.yml",
                                            "docker-compose*.yaml",
                                            "compose*.yml",
                                            "compose*.yaml",
                                        },
                                    },
                                    validate = true,
                                    lint = { enable = true },
                                },
                            },
                        },

                        marksman     = {},
                        lemminx      = {},
                        taplo        = {},

                        -- JSON
                        jsonls       = {
                            settings = {
                                json = {
                                    validate = { enable = true },
                                },
                            },
                        },

                        -- PHP
                        intelephense = {
                            settings = {
                                intelephense = {
                                    environment = {
                                        documentRoot = vim.fn.getcwd(),
                                        includePaths = include_paths,
                                    },
                                    files = {
                                        associations = { "*.php", "*.phtml", "*.inc" },
                                    },
                                },
                            },
                        },

                        -- Lua
                        lua_ls       = {
                            settings = {
                                Lua = {
                                    runtime = { version = "Lua 5.1" },
                                    globals = { "bit", "vim", "it", "use", "describe", "after_each", "before_each" },
                                    workspace = {
                                        library = {
                                            "${3rd}/busted/library",
                                            "${3rd}/luassert/library",
                                            vim.env.VIMRUNTIME,
                                        },
                                    },
                                },
                            },
                        },

                        -- LTeX
                        ltex         = {
                            settings = {
                                ltex = {
                                    language = "pt-BR",
                                    enabled = {
                                        "bibtex", "gitcommit", "markdown", "org", "tex",
                                        "restructuredtext", "rsweave", "latex", "quarto",
                                        "rmd", "context", "mail", "plaintext",
                                    },
                                },
                            },
                        },

                        -- Python
                        ruff         = {
                            root_dir = function() return vim.fn.getcwd() end,
                        },

                        -- TypeScript treesitter queries
                        ts_query_ls  = {
                            settings = {
                                parser_install_directories = vim.api.nvim_get_runtime_file("parser", true),
                            },
                        },
                    }

                    for _, server in ipairs(installed_servers) do
                        local config = custom_configs[server] or {}
                        config.capabilities = capabilities
                        vim.lsp.config(server, config)
                    end

                    vim.lsp.enable(installed_servers)
                end,
            })
        end,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lua" },
        },
        config = function()
            local cmp = require("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            local cmp_mapping = cmp.mapping.preset.insert({
                ["<C-p>"]     = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"]     = cmp.mapping.select_next_item(cmp_select),
                ["<C-y>"]     = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<Tab>"]     = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.confirm({ select = true })
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"]   = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item(cmp_select)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            })

            cmp.setup({
                completion = {
                    completeopt = "menu,menuone,preview,noselect",
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp", group_index = 2 },
                    { name = "luasnip",  group_index = 2 },
                    { name = "copilot",  group_index = 2 },
                }, {
                    { name = "buffer", group_index = 2 },
                    { name = "path",   group_index = 2 },
                }),
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
                mapping = cmp_mapping,
            })

            vim.diagnostic.config({
                severity_sort = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    source = true,
                },
            })
        end,
    },

    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        config = function()
            local ls = require("luasnip")
            vim.keymap.set("i", "<C-k>", function() ls.expand({}) end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-l>", function() ls.jump(1) end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-j>", function() ls.jump(-1) end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-e>", function()
                if ls.choice_active() then ls.change_choice(1) end
            end, { desc = "Change choice in choice node", silent = true })
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
        dependencies = { "rafamadriz/friendly-snippets" },
    },

    -- Lazydev
    {
        "folke/lazydev.nvim",
        opts = {
            library = {
                plugins = { "nvim-dap-ui" },
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },

    -- Auto-pairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local autopairs = require("nvim-autopairs")
            autopairs.setup({
                check_ts = true,
                ts_config = {
                    go = { "string" },
                },
            })
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },

    -- conform.nvim: formatter externo (shfmt para bash)
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    sh   = { "shfmt" },
                    bash = { "shfmt" },
                },
                format_on_save = {
                    timeout_ms = 3000,
                    lsp_fallback = true, -- usa LSP para linguagens sem formatter externo
                },
                formatters = {
                    shfmt = {
                        prepend_args = { "-i", "4" }, -- indentação 4 espaços
                    },
                },
            })
        end,
    },
}
