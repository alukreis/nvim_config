local shallow_merge = require('helpers.shallow-merge')
local defaultLspConfig = require('lsp_configs.default')

return {
  'neovim/nvim-lspconfig',
  dependencies = { 'saghen/blink.cmp', 'mason-org/mason.nvim' },
  opts = {
    servers = {
      pylsp = defaultLspConfig,
      ts_ls = defaultLspConfig,
      lua_ls = defaultLspConfig,
      bashls = defaultLspConfig,
      eslint = defaultLspConfig,
      angularls = shallow_merge(defaultLspConfig, {
        -- Needed otherwise doesn't really override cmd?!
        on_new_config = function(newConfig)
          local angularlsModulesPath =
            vim.fn.expand('$MASON/packages/angular-language-server/node_modules')
          newConfig.cmd = {
            'ngserver',
            '--stdio',
            '--tsProbeLocations',
            angularlsModulesPath,
            '--ngProbeLocations',
            angularlsModulesPath .. '/@angular/language-server/node_modules',
          }
        end,
      }),
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
