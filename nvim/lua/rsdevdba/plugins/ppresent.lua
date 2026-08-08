local ppresent_src = vim.fs.joinpath(
    vim.uv.os_homedir(),
    "source",
    "rsdevdba",
    "ppresent"
)

-- Só carrega o plugin se o diretório local existir.
-- Sem fallback para GitHub (repositório privado/local).
if not vim.uv.fs_stat(ppresent_src) then
    return {}
end

return {
    {
        "rsdevdba/ppresent.nvim",
        dir = ppresent_src,
        opts = {},
        keys = {
            { "<leader>pp", function() vim.cmd([[PresentStart]]) end, desc = "Run the PresentStart" },
        },
    }
}
