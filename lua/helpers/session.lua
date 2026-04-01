local sessionPrefix = 'SESSION_%s'
local treeOpen = string.format(sessionPrefix, 'tree_open')

local function wrapTreeCommandWithFlag(command)
  return function()
    command()
    vim.g[treeOpen] = require('nvim-tree.view').is_visible() and 1 or nil
  end
end

local function getSessionTreeOpen()
  return vim.g[treeOpen]
end

return {
  getSessionTreeOpen = getSessionTreeOpen,
  wrapTreeCommandWithFlag = wrapTreeCommandWithFlag,
}
