local shallow_merge = require('helpers.shallow-merge')
local constants = require('config.constants')

local commonKeymapOptions = constants.commonKeymapOptions

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  lazy = true,
  keys = function()
    local telescopeApi = require('telescope.builtin')
    return {
      shallow_merge({
        '<leader>ff',
        telescopeApi.find_files,
        desc = 'Telescope find files',
      }, commonKeymapOptions),
      shallow_merge({
        '<leader>fg',
        telescopeApi.live_grep,
        desc = 'Telescope live grep',
      }, commonKeymapOptions),
      shallow_merge({
        '<leader>fb',
        telescopeApi.buffers,
        desc = 'Telescope buffers',
      }, commonKeymapOptions),
      shallow_merge({
        '<leader>fh',
        telescopeApi.help_tags,
        desc = 'Telescope help tags',
      }, commonKeymapOptions),
    }
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
}
