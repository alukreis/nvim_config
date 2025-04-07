require('config.bootstrapLazy')
require('lazy').setup('plugins')
require('keymaps')

if vim.uv.os_uname().sysname == 'Windows_NT' then
  -- Change terminal shell to powershell on windows os
  vim.o.shell = 'powershell'
end
