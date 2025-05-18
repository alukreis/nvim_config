local prettierdConfig = { 'prettierd' }

return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      css = prettierdConfig,
      scss = prettierdConfig,
      json = prettierdConfig,
      python = { 'black' },
      javascript = prettierdConfig,
      typescript = prettierdConfig,
    },
  },
}
