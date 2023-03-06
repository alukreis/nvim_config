-- For nvim-tree benefit, turn off native browser
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.termguicolors = true -- For colorscheme
vim.cmd('colorscheme one-nvim')

-- COQ fast as fuck
vim.g.coq_settings = {
  auto_start='shut-up'
}
