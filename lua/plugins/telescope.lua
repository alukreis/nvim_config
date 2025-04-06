local helpers = require('../helpers')
local constants = require('../config.constants')

local shallow_merge = helpers.shallow_merge
local commonKeymapOptions = constants.commonKeymapOptions

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  lazy = true,
  keys = function ()
    local telescopeApi = require('telescope.builtin')
    return {
      shallow_merge({
        '<leader>tf',
        telescopeApi.find_files,
        desc = 'Telescope find files'
      }, commonKeymapOptions),
      shallow_merge({
        '<leader>tg',
        telescopeApi.live_grep,
        desc = 'Telescope live grep'
      }, commonKeymapOptions),
      shallow_merge({
        '<leader>tb',
        telescopeApi.buffers,
        desc = 'Telescope buffers'
      }, commonKeymapOptions),
      shallow_merge({
        '<leader>th',
        telescopeApi.help_tags,
        desc = 'Telescope help tags'
      }, commonKeymapOptions)
    }
  end,
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
}
