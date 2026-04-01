local shallow_merge = require('helpers.shallow-merge')
local load_text_file = require('helpers.load_text_file')

local sharedSessionOptions = {
  key_hl = 'Constant',
  desc_hl = 'String',
  icon_hl = 'Label',
}

local loadLastSession = shallow_merge({
  key = 'l',
  icon = '  ',
  desc = 'Load last session',
  action = function()
    require('persistence').load({ last = true })
  end,
}, sharedSessionOptions)

local selectSession = shallow_merge({
  key = 's',
  icon = '  ',
  desc = 'Select a session to load',
  action = function()
    require('persistence').select()
  end,
}, sharedSessionOptions)

return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  opts = {
    theme = 'doom',
    config = {
      header = load_text_file(vim.fn.stdpath('config') .. '/splash.txt'),
      center = {
        loadLastSession,
        selectSession,
      },
    },
  },
  dependencies = {
    { 'folke/persistence.nvim' },
  },
}
