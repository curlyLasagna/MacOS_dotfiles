-- local map = require("core.utils").map
--
-- map('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>')
-- map('n', '<leader>W', ':w !sudo tee % > /dev/null<CR>')
-- map('v', '<', '<gv')
-- map('v', '>', '>gv')
-- map('n', '<A-t>', '<Cmd>ToggleTerm direction=float<CR>')
-- map('n', '<A-x>', '<Cmd>ToggleTerm direction=horizontal<CR>')
-- map('n', '<A-v>', '<Cmd>ToggleTerm direction=vertical<CR>')
local M = {}

M.custom_maps = {
  n = {
    ["<leader>cd"] = { "<cmd> cd %:p:h<CR>:pwd<CR>", "Change directory to current buffer" },
    ["<leader>W"] = { "<cmd> w !sudo tee % > /dev/null<CR>", "Save as sudo" },
  },

  -- v = {
  --   []
  -- }
}

return M
