local M = {}

M.setup_lsp = function(attach, capabilities)
  local lsp_installer = require("nvim-lsp-installer")
  local lspconfig = require("lspconfig")

   -- lspservers with default config
  local servers = {
    "jdtls",
    "clangd",
    "hls",
    "texlab"
  }

  for _, lsp in ipairs(servers) do
     lspconfig[lsp].setup {
        on_attach = attach,
        capabilities = capabilities,
        flags = {
           debounce_text_changes = 150,
        },
     }
  end

  lsp_installer.settings {
     ui = {
        icons = {
           server_installed = "﫟" ,
           server_pending = "",
           server_uninstalled = "✗",
        },
     },
   }

end

return M
