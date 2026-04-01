local sessionPrefix = 'SESSION_%s'
local treeOpen = string.format(sessionPrefix, 'tree_open')

local function wrap_tree_command_with_flag(command)
  return function()
    command()
    vim.g[treeOpen] = require('nvim-tree.view').is_visible() and 1 or nil
  end
end

local function get_session_tree_open()
  return vim.g[treeOpen]
end

return {
  get_session_tree_open = get_session_tree_open,
  wrap_tree_command_with_flag = wrap_tree_command_with_flag,
}
