-- ~/.config/nvim/lua/lspconfig.lua or directly in init.lua
local lspconfig = require("lspconfig")

-- Example: jsonls (JSON language server)
lspconfig.jsonls.setup({
  settings = {
    json = {
      format = { enable = false }, -- disable formatting
      schemas = require("schemastore").json.schemas(),
    },
  },
})
