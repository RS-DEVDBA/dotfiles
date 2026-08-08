-- Inserir shebang automaticamente em arquivos .sh e .bash novos e vazios
vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = { "*.sh", "*.bash" },
    callback = function()
        vim.api.nvim_buf_set_lines(0, 0, 0, false, {
            "#!/usr/bin/env bash",
            "",
        })
        -- Posiciona cursor na linha 3 (após o shebang e linha em branco)
        vim.api.nvim_win_set_cursor(0, { 3, 0 })
    end,
})
