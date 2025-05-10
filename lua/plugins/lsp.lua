local shallow_merge = require('helpers.shallow-merge')
local defaultLspConfig = require('lsp_configs.default')
local masonPackagesPath = require('config.constants').masonPackagesPath

local angularlsModulesPath = masonPackagesPath .. '/angular-language-server/node_modules'
local angularlsCommandTable = {
  'ngserver',
  '--stdio',
  '--tsProbeLocations',
  angularlsModulesPath,
  '--ngProbeLocations',
  angularlsModulesPath .. '/@angular/language-server/node_modules',
}

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
      eslint = defaultLspConfig,
      angularls = shallow_merge(defaultLspConfig, {
        cmd = angularlsCommandTable,
        -- Needed otherwise doesn't really override cmd?!
        on_new_config = function(newConfig)
          newConfig.cmd = angularlsCommandTable
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
