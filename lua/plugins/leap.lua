local leapBackdropConfig = {
  fg = '#FF7119', -- a rust colour
}
local function setLeapBackdropHighlight()
  vim.api.nvim_set_hl(0, 'LeapBackdrop', leapBackdropConfig)
end

local function unsetLeapExtraKeybinds()
  vim.keymap.del({ 'x', 'o' }, 'x')
  vim.keymap.del({ 'x', 'o' }, 'X')
end

return {
  'ggandor/leap.nvim',
  lazy = true,
  keys = {
    {
      's',
      nil,
    },
    {
      'S',
      nil,
    },
    {
      'gs',
      nil,
    },
  },
  config = function()
    require('leap').add_default_mappings()
    setLeapBackdropHighlight()
    unsetLeapExtraKeybinds()
  end,
}
