local session = require('helpers.session')

local function disable_native_file_navigation()
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
end

local function generate_tree_find_file(nvimTreeApi)
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
local function map_nvim_tree_commands()
  local nvimTreeApi = require('nvim-tree.api')
  local commonKeymapOptions = require('config.constants').commonKeymapOptions
  vim.keymap.set(
    'n',
    openNvimTreeCommand,
    session.wrap_tree_command_with_flag(nvimTreeApi.tree.focus),
    commonKeymapOptions
  )
  vim.keymap.set(
    'n',
    closeNvimTreeCommand,
    session.wrap_tree_command_with_flag(nvimTreeApi.tree.close),
    commonKeymapOptions
  )
  vim.keymap.set(
    'n',
    openNvimTreeOnFileCommand,
    session.wrap_tree_command_with_flag(generate_tree_find_file(nvimTreeApi)),
    commonKeymapOptions
  )
end

local function register_restore_on_session_load()
  vim.api.nvim_create_autocmd('User', {
    pattern = 'PersistenceLoadPost',
    callback = function()
      if session.get_session_tree_open() then
        require('nvim-tree.api').tree.toggle({
          focus = false,
        })
      end
    end,
  })
end

return {
  'nvim-tree/nvim-tree.lua',
  init = disable_native_file_navigation,
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
    map_nvim_tree_commands()
    register_restore_on_session_load()
  end,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'folke/persistence.nvim',
  },
}
