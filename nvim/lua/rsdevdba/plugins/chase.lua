-- This file can be loaded by calling `lua require("plugins")` from your
-- init.vim
local chase_source = vim.fs.joinpath(
    vim.uv.os_homedir(),
    "source",
    "rsdevdba",
    "chase"
)

local chase = { "RS-DEVDBA/chase.nvim", opts = {}, event = "VeryLazy" }
if vim.uv.fs_stat(chase_source) then
    chase = { "RS-DEVDBA/chase.nvim", dev = true, name = "chase", opts = {}, event = "VeryLazy" }
end

return {
    chase
}
