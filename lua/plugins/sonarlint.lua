return {
  'https://gitlab.com/schrieveslaach/sonarlint.nvim',
  dependencies = { 'mason-org/mason.nvim' },
  opts = function()
    local sonarlintAnalyzersPath = vim.fn.expand('$MASON/share/sonarlint-analyzers')
    return {
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
    }
  end,
}
