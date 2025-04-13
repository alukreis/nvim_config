local defaultLspConfig = require('lsp_configs.default')

return {
  'neovim/nvim-lspconfig',
  dependencies = { 'saghen/blink.cmp' },

  -- example using `opts` for defining servers
  opts = {
    servers = {
      pylsp = defaultLspConfig,
      ts_ls = defaultLspConfig,
      lua_ls = defaultLspConfig,
      bashls = defaultLspConfig,
      tailwindcss = defaultLspConfig,
      rust_analyzer = defaultLspConfig,
    },
  },
  config = function(_, opts)
    local lspconfig = require('lspconfig')
    for server, config in pairs(opts.servers) do
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
  end,
}
