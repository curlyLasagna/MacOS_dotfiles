-- Overrides default_config.lua
local M = {}

local plugin_conf = require "custom.plugins.configs"
local userPlugins = require "custom.plugins"

M.plugins = {
   options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspconfig",
      },
   },

   override = {
      ["nvim-treesitter/nvim-treesitter"] = plugin_conf.treesitter,
      ["kyazdani42/nvim-tree.lua"] = plugin_conf.nvimtree,
      ["goolord/alpha-nvim"] = plugin_conf.alpha,
      ["NvChad/ui"] = {
         statusline = {
            separator_style = "arrow"
         }
      }
   },

   user = userPlugins,
}

M.options = {
   user = function()
      vim.opt.relativenumber = true
      vim.opt.virtualedit = "all"
      vim.g.tex_conceal = "abdmg"
   end,
}

M.ui = {
   theme = "tokyonight",
}

M.mappings = require "custom.mappings"

return M
