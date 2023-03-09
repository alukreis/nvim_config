local helpers = require('helpers')
local c = require('constants')

if helpers.are_coq_dependencies_installed() then
  -- Get COQ out if available
  vim.cmd(string.format('packadd %s', c.COQ_NVIM_NAME))
  vim.cmd(string.format('packadd %s', c.COQ_ARTIFACTS_NAME))
else
  -- Otherwise fallback to nvim-cmp
  vim.cmd(string.format('packadd %s', c.NVIM_CMP))
  vim.cmd(string.format('packadd %s', c.NVIM_CMP_LSP))
  vim.cmd(string.format('packadd %s', c.NVIM_CMP_BUFFER))
  vim.cmd(string.format('packadd %s', c.NVIM_CMP_PATH))
  vim.cmd(string.format('packadd %s', c.NVIM_CMP_VSNIP))
  vim.cmd(string.format('packadd %s', c.NVIM_CMP_VIM_VSNIP))
end
