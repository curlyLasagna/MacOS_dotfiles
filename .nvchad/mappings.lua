-- local map = require("core.utils").map
--
-- map('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>')
-- map('n', '<leader>W', ':w !sudo tee % > /dev/null<CR>')
-- map('v', '<', '<gv')
-- map('v', '>', '>gv')
local M = {}

M.custom_maps = {
  n = {
    ["<leader>cd"] = { "<cmd> cd %:p:h<CR>:pwd<CR>", "Change directory to current buffer" },
    ["<leader>W"] = { "<cmd> w !sudo tee % > /dev/null<CR>", "Save as sudo" },
  },

  v = {
    ["<"] = { "<gv"},
    [">"] = { ">gv"}
  }
}

return M
