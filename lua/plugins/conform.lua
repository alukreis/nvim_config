local commonKeymapOptions = require('config.constants').commonKeymapOptions
local shallow_merge = require('helpers.shallow-merge')

local prettierdConfig = { 'prettierd' }

return {
  'stevearc/conform.nvim',
  cmd = { 'ConformInfo' },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      css = prettierdConfig,
      scss = prettierdConfig,
      json = prettierdConfig,
      rust = { 'rustfmt' },
      python = { 'black' },
      javascript = prettierdConfig,
      typescript = prettierdConfig,
    },
  },
  keys = {
    shallow_merge({
      '<leader>f',
      function()
        local conform = require('conform')
        conform.format({ async = true })
      end,
      mode = 'n',
      desc = 'Format buffer',
    }, commonKeymapOptions),
  },
}
