local shallow_merge = require('helpers.shallow-merge')
local defaultLspConfig = require('lsp_configs.default')

return {
  'neovim/nvim-lspconfig',
  dependencies = { 'saghen/blink.cmp', 'mason-org/mason.nvim' },
  opts = function()
    local angularlsModulesPath =
      vim.fn.expand('$MASON/packages/angular-language-server/node_modules')
    return {
      servers = {
        pylsp = defaultLspConfig,
        ts_ls = defaultLspConfig,
        lua_ls = defaultLspConfig,
        bashls = defaultLspConfig,
        eslint = defaultLspConfig,
        angularls = shallow_merge(defaultLspConfig, {
          cmd = {
            'ngserver',
            '--stdio',
            '--tsProbeLocations',
            angularlsModulesPath,
            '--ngProbeLocations',
            angularlsModulesPath .. '/@angular/language-server/node_modules',
          }
        }),
        tailwindcss = defaultLspConfig,
        rust_analyzer = defaultLspConfig,
      },
    }
  end,
  config = function(_, opts)
    for server, config in pairs(opts.servers) do
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      vim.lsp.config(server, config);
      vim.lsp.enable(server);
    end
  end,
}
