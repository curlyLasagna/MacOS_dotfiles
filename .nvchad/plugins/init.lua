return {
  -- ["karb94/neoscroll.nvim"] = {
  --   config = function()
  --     require "neoscroll".setup()
  --   end,
  --   setup = function()
  --    nvchad.packer_lazy_load "neoscroll.nvim"
  --   end,
  -- },

  ["lervag/vimtex"] = {
    -- opt = true,
    config = function ()
      vim.g.vimtex_view_method = "skim"
      vim.g.latex_view_general_viewer = "skim"
      vim.g.vimtex_compiler_latexmk = {
        build_dir = '.build'
      }

      vim.g.vimtex_log_ignore = {
        "Underfull",
        "Overfull",
        "specifier changed to",
        "Token not allowed in a PDF string",
      }
    end,
    ft = "tex",
  },

  ["iamcco/markdown-preview.nvim"] = {
    ft = {'markdown', 'pandon.markdown', 'rmd'},
    run = 'cd app && yarn install',
    cmd = 'MarkdownPreview',
  },

  ["goolord/alpha-nvim"] = {
    disable = false,
  },

  ["luukvbaal/stabilize.nvim"] = {
    config = function()
      require "stabilize".setup()
    end,
  },

  ["tpope/vim-fugitive"] = {}
}
