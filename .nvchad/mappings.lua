local M = {}

M.custom_maps = {
   n = {
      ["<leader>cd"] = { "<cmd> cd %:p:h<CR>:pwd<CR>", "Change directory to current buffer" },
      ["<leader>W"] = { "<cmd> w !sudo -S tee % ", "Save as sudo" },
      ["<C-q>"] = {"<cmd> qa<CR>", "End it all"}
   },

   v = {
      ["<"] = { "<gv" },
      [">"] = { ">gv" },
   },
}

M.easyAlign = {
   n = {
      ["ga"] = { " <cmd> EasyAlign<CR>", "Align" },
   },
   v = {
      ["ga"] = { "<cmd> EasyAlign<CR>", "Align" },
   },
}

M.truezen = {
   n = {
      ["<leader>ta"] = { "<cmd> TZAtaraxis <CR>", "   truzen ataraxis" },
      ["<leader>tm"] = { "<cmd> TZMinimalist <CR>", "   truzen minimal" },
      ["<leader>tf"] = { "<cmd> TZFocus <CR>", "   truzen focus" },
   },
}

return M
