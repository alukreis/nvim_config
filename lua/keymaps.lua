local nvimTreeApi = require('nvim-tree.api')
local commonKeymapOptions = { noremap = true }

vim.keymap.set('i', 'jk', '<ESC>', commonKeymapOptions)
vim.keymap.set('v', 'jk', '<ESC>', commonKeymapOptions)
vim.keymap.set('t', 'jk', '<C-\\><C-n>', commonKeymapOptions)

-- Nvim tree binds
vim.keymap.set('n', '<leader>eo', nvimTreeApi.tree.focus, commonKeymapOptions)
vim.keymap.set('n', '<leader>ec', nvimTreeApi.tree.close, commonKeymapOptions)

-- Trouble binds
vim.keymap.set('n', '<leader>tt', '<cmd>TroubleToggle<cr>', commonKeymapOptions)
