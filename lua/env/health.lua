local env = require('env')

local M = {}

M.check = function ()
  vim.health.start("User Environment")
  local errorOrContents = env.get_status()
  if env.is_loaded() then
    vim.health.ok("User environment file '.env' loaded successfully")
    vim.health.info(vim.inspect(errorOrContents))
  else
    vim.health.warn("User environment file '.env' not loaded\n", errorOrContents.error)
  end
end

return M
