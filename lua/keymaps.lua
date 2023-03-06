local nvimTreeApi = require('nvim-tree.api')
local commonKeymapOptions = { noremap = true }

vim.keymap.set('i', 'jk', '<ESC>', commonKeymapOptions)
vim.keymap.set('v', 'jk', '<ESC>', commonKeymapOptions)
vim.keymap.set('t', 'jk', '<C-\\><C-n>', commonKeymapOptions)

-- Nvim tree binds
vim.keymap.set('n', 'ge', nvimTreeApi.tree.focus, commonKeymapOptions)
