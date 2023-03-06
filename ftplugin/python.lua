vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.expandtab = true

vim.lsp.start({
  name = 'python-lsp',
  cmd = {'pylsp'},
  root_dir = vim.fs.dirname(vim.fs.find({'main.py', 'PYTHON_PROJECT'}, {upward = true })[1]),
})
