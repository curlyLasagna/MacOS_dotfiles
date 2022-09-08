return {
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require = "plugins.configs.lspconfig"
    end
  },

  ["goolord/alpha-nvim"] = {
    disable = false,
  },

  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },

  ["tpope/vim-fugitive"] = {},
  ["junegunn/vim-easy-align"] = {},
  ["nvim-treesitter/nvim-treesitter-context"] = {
    after = "nvim-treesitter",
  },

  ["matbme/JABS.nvim"] = {
    cmd = "JABSOpen",
    config = function()
      require("config.jabs").setup {
        position = "center",
        width = 50,
        height = 10,
        border = "rounded",
        preview_position = "top",
        preview = {
          width = 80,
          height = 20,
          border = "rounded",
        },
      }
    end,
  },

  ["Pocco81/TrueZen.nvim"] = {},
}
