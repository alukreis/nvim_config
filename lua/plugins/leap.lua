local leapBackdropConfig = {
  fg = '#FF7119', -- a rust colour
}

local function setLeapBackdropHighlight()
  vim.api.nvim_set_hl(0, 'LeapBackdrop', leapBackdropConfig)
end

return {
  'https://codeberg.org/andyg/leap.nvim',
  lazy = true,
  keys = {
    {
      's',
      '<Plug>(leap)',
      mode = { 'n', 'x', 'o' },
      desc = 'Leap within current window',
    },
    {
      'gs',
      '<Plug>(leap-from-window)',
      mode = 'n',
      desc = 'Leap to another window',
    },
  },
  config = function()
    setLeapBackdropHighlight()
  end,
}
