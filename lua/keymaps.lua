local constants = require('config.constants')
local commonKeymapOptions = constants.commonKeymapOptions

vim.keymap.set('i', 'jk', '<ESC>', commonKeymapOptions)
vim.keymap.set('x', 'jk', '<ESC>', commonKeymapOptions)
vim.keymap.set('t', 'jk', '<C-\\><C-n>', commonKeymapOptions)

-- Trouble binds
vim.keymap.set('n', '<leader>tt', '<cmd>TroubleToggle<cr>', commonKeymapOptions)
