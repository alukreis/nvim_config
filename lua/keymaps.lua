local constants = require('config.constants')
local commonKeymapOptions = constants.commonKeymapOptions

vim.keymap.set('i', 'jk', '<ESC>', commonKeymapOptions)
vim.keymap.set('x', 'jk', '<ESC>', commonKeymapOptions)
vim.keymap.set('t', 'jk', '<C-\\><C-n>', commonKeymapOptions)

-- Open terminal below all buffers
vim.keymap.set('n', '<leader>t', '<cmd>botright terminal<cr><cmd>resize 15<cr>', commonKeymapOptions)
