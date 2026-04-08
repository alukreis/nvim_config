require('env').setup()
require('config.globalOptions')
if not vim.g.is_headless then
  if vim.g.enable_plugins then
    require('config.initGuard')
    require('config.paths')
    require('lazy').setup('plugins')
  end

  require('config.editorconfig')
  require('config.keymaps')
  require('config.options')
end
