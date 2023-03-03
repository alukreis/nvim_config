local function clone_paq()
  local path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
  print(vim.fn.empty(vim.fn.glob(path)))
  local isInstalled = vim.fn.empty(vim.fn.glob(path)) == 0
  if not isInstalled then
    vim.fn.system({ 'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', path })
    return true
  end
end

local function bootstrap_paq(packages)
  local firstInstall = clone_paq()
  vim.cmd.packadd('paq-nvim')
  local paq = require('paq')
  if firstInstall then
    vim.notify('Installing plugins... If prompted, hit Enter to continue.')
  end

  -- Read and install packages
  paq(packages)
  paq.install()
end

local function headless_paq()
  local paqConfig = require('paq-config')
  -- Set to exit nvim after installing plugins
  vim.cmd('autocmd User PaqDoneInstall quit')
  bootstrap_paq(paqConfig)
end

return {
  headless_paq = headless_paq,
}
