local helpers = require('helpers')

-- For nvim-tree benefit, turn off native browser
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.termguicolors = true -- For colorscheme
vim.cmd('colorscheme one-nvim')

if helpers.are_coq_dependencies_installed() then
  -- COQ fast as fuck
  vim.g.coq_settings = {
    auto_start='shut-up'
  }
else
  -- Nvim cmp uses native autocomplete menu
  vim.g.completeopt='menu,menuone,noselect'
end
