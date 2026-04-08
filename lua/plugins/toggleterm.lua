local terminals = require('helpers.terminals')

return {
  'akinsho/toggleterm.nvim',
  opts = {
    open_mapping = false,
  },
  keys = {
    {
      '<leader>tg',
      terminals.toggle_general_term,
      mode = 'n',
    },
    {
      '<leader>tt',
      terminals.toggle_testing_term,
      mode = 'n',
    },
  },
}
