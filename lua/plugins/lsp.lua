return {
  'neovim/nvim-lspconfig',
  dependencies = { 'saghen/blink.cmp' },

  -- example using `opts` for defining servers
  opts = {
    servers = {
      pylsp = {},
      ts_ls = {},
      lua_ls = {
        settings = {
          Lua = {
            version = 'LuaJIT',
          },
        },
      },
      tailwindcss = {},
      rust_analyzer = {},
    }
  },
  config = function(_, opts)
    local lspconfig = require('lspconfig')
    for server, config in pairs(opts.servers) do
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
  end
}
