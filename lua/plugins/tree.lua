local session = require('helpers.session')

local function disableNativeFileNavigation()
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
end

local function generateTreeFindFile(nvimTreeApi)
  return function()
    nvimTreeApi.tree.find_file({
      open = true,
      focus = true,
      update_root = true,
    })
  end
end

local openNvimTreeCommand = '<leader>eo'
local closeNvimTreeCommand = '<leader>ec'
local openNvimTreeOnFileCommand = '<leader>ef'
local function mapNvimTreeCommands()
  local nvimTreeApi = require('nvim-tree.api')
  local commonKeymapOptions = require('config.constants').commonKeymapOptions
  vim.keymap.set(
    'n',
    openNvimTreeCommand,
    session.wrapTreeCommandWithFlag(nvimTreeApi.tree.focus),
    commonKeymapOptions
  )
  vim.keymap.set(
    'n',
    closeNvimTreeCommand,
    session.wrapTreeCommandWithFlag(nvimTreeApi.tree.close),
    commonKeymapOptions
  )
  vim.keymap.set(
    'n',
    openNvimTreeOnFileCommand,
    session.wrapTreeCommandWithFlag(generateTreeFindFile(nvimTreeApi)),
    commonKeymapOptions
  )
end

local function registerRestoreOnSessionLoad()
  vim.api.nvim_create_autocmd('User', {
    pattern = 'PersistenceLoadPost',
    callback = function()
      if session.getSessionTreeOpen() then
        require('nvim-tree.api').tree.toggle({
          focus = false,
        })
      end
    end,
  })
end

return {
  'nvim-tree/nvim-tree.lua',
  init = disableNativeFileNavigation,
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
    {
      openNvimTreeOnFileCommand,
      nil,
    },
  },
  lazy = true,
  event = 'User PersistenceLoadPre',
  config = function()
    require('nvim-tree').setup()
    mapNvimTreeCommands()
    registerRestoreOnSessionLoad()
  end,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'folke/persistence.nvim',
  },
}
