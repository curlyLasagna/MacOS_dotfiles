-- Overrides default_config.lua
local M = {}

local plugin_conf = require "custom.plugins.configs"
local userPlugins = require "custom.plugins"

M.plugins = {

  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.lspconfig"
    },
    statusline = {
      separator_style = "arrow"
    },
  },

  override = {
    ["nvim-treesitter/nvim-treesitter"] = plugin_conf.treesitter,
    ["kyazdani42/nvim-tree.lua"] = plugin_conf.nvimtree,
    ["goolord/alpha-nvim"] = plugin_conf.alpha,
  },

  remove = {
   "NvChad/nvterm",
  },

  user = userPlugins,

}

M.options = {
  user = function ()
    vim.opt.relativenumber = true
    vim.opt.virtualedit = "all"
    vim.opt.conceallevel = 1
    vim.g.tex_conceal='abdmg'
  end,
}

M.ui = {
  theme = "chadtain",
  theme_toggle = {"chadtain", "rxyhn"},
  changed_themes = {
    rxyhn = {
      base_16 = {
        base00 = "#141415"
      }
    }
  },
  hl_override = {
    MatchParen = {bg = "cyan"},
  }
}

M.mappings = require "custom.mappings"

return M
