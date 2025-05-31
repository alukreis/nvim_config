return {
  'https://gitlab.com/schrieveslaach/sonarlint.nvim',
  dependencies = { 'mason-org/mason.nvim' },
  config = function()
    local sonarlint = require('sonarlint')
    local sonarlintAnalyzersPath = vim.fn.expand('${MASON}/share/sonarlint-analyzers')
    sonarlint.setup({
      server = {
        cmd = {
          'sonarlint-language-server',
          '-stdio',
          '-analyzers',
          sonarlintAnalyzersPath .. '/sonarpython.jar',
          sonarlintAnalyzersPath .. '/sonarjs.jar',
        },
      },
      filetypes = {
        'python',
        'javascript',
        'typescript',
      },
    })
  end,
}
