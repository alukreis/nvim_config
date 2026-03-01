local leapBackdropConfig = {
  fg = '#FF7119', -- a rust colour
}

local function setLeapBackdropHighlight()
  vim.api.nvim_set_hl(0, 'LeapBackdrop', leapBackdropConfig)
end

local function setLeapKeybinds()
  vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
  vim.keymap.set('n', 'gs', '<Plug>(leap-from-window)')
end

return {
  'https://codeberg.org/andyg/leap.nvim',
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
    setLeapKeybinds();
    setLeapBackdropHighlight()
  end,
}
