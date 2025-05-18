local setters = require('helpers.setters')
local constants = require('config.constants')
local conform = require('conform')
local commonKeymapOptions = constants.commonKeymapOptions

-- Common return to normal mode maps
vim.keymap.set('i', 'jk', '<ESC>', commonKeymapOptions)
vim.keymap.set('x', 'jk', '<ESC>', commonKeymapOptions)
vim.keymap.set('t', 'jk', '<C-\\><C-n>', commonKeymapOptions)

-- Open terminal below all buffers
vim.keymap.set(
  'n',
  '<leader>t',
  '<cmd>botright terminal<cr><cmd>resize 15<cr>',
  commonKeymapOptions
)
-- Open diagnostic message for current line in hover panel
vim.keymap.set('n', '<leader>h', vim.diagnostic.open_float, commonKeymapOptions)

-- Set numbers
vim.keymap.set('n', '<leader>n', setters.toggle_numbers, commonKeymapOptions)

vim.keymap.set('n', '<leader>f', conform.format, commonKeymapOptions)
