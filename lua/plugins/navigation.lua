local leapBackdropConfig = {
  fg = '#FF7119' -- a rust colour
}
local function setLeapBackdropHighlight()
  vim.api.nvim_set_hl(
    0,
    'LeapBackdrop',
    leapBackdropConfig
  )
end

local function unsetLeapExtraKeybinds()
  vim.keymap.del({ 'x', 'o' }, 'x')
  vim.keymap.del({ 'x', 'o' }, 'X')
end

local function disableNativeFileNavigation()
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
end

local openNvimTreeCommand = '<leader>eo'
local closeNvimTreeCommand = '<leader>ec'
local function mapNvimTreeCommands()
  local nvimTreeApi = require('nvim-tree.api')
  local commonKeymapOptions = require('../config.constants').commonKeymapOptions
  vim.keymap.set(
    'n',
    openNvimTreeCommand ,
    nvimTreeApi.tree.focus,
    commonKeymapOptions
  )
  vim.keymap.set(
    'n',
    closeNvimTreeCommand,
    nvimTreeApi.tree.close,
    commonKeymapOptions
  )
end

return {
  {
    'ggandor/leap.nvim',
    config = function ()
      require('leap').add_default_mappings()
      setLeapBackdropHighlight()
      unsetLeapExtraKeybinds()
    end,
    lazy = true,
    keys = {
      {
        's',
        nil
      },
      {
        'S',
        nil
      },
      {
        'gs',
        nil
      }
    }
  },
  {
    'nvim-tree/nvim-tree.lua',
    lazy = true,
    dependencies = {
      'nvim-tree/nvim-web-devicons'
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
        nil
      }
    }
  },
}
