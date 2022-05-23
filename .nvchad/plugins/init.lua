return {
  ["karb94/neoscroll.nvim"] = {
    config = function()
      require("neoscroll").setup()
    end,
    setup = function()
     nvchad.packer_lazy_load "neoscroll.nvim"
    end,
  },

  ["iamcco/markdown-preview.nvim"] = {
    ft = {'markdown', 'pandon.markdown', 'rmd'},
    run = 'cd app && yarn install',
    cmd = 'MarkdownPreview',
    setup = function ()
      nvchad.packer_lazy_load "markdown-preview.nvim"
    end
  },

  ["goolord/alpha-nvim"] = {
    disable = false,
  },

  ["luukvbaal/stabilize.nvim"] = {
    config = function()
      require("stabilize").setup()
    end,
    setup = function ()
      nvchad.packer_lazy_load "stabilize.nvim"
    end
  },

  ["lervag/vimtex"] = {
    ft = {'latex'},
    config = function ()
      require("vimtex").setup()
    end
  }
}
