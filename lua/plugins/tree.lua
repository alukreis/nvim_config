local function disableNativeFileNavigation()
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
end

local openNvimTreeCommand = '<leader>eo'
local closeNvimTreeCommand = '<leader>ec'
local function mapNvimTreeCommands()
  local nvimTreeApi = require('nvim-tree.api')
  local commonKeymapOptions = require('config.constants').commonKeymapOptions
  vim.keymap.set('n', openNvimTreeCommand, nvimTreeApi.tree.focus, commonKeymapOptions)
  vim.keymap.set('n', closeNvimTreeCommand, nvimTreeApi.tree.close, commonKeymapOptions)
end

return {
  'nvim-tree/nvim-tree.lua',
  lazy = true,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  init = disableNativeFileNavigation,
  config = function()
    require('nvim-tree').setup()
    mapNvimTreeCommands()
  end,
  -- So Lazy knows to load on these keys but they are implemented in config
  keys = {
    {
      openNvimTreeCommand,
      nil,
    },
    {
      closeNvimTreeCommand,
      nil,
    },
  },
}
