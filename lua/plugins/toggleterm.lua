local function terminal_has_name(name)
  return function(terminal)
    return terminal.display_name == name
  end
end

local function toggle_named_term(name)
  local termModule = require('toggleterm.terminal')
  local Terminal = termModule.Terminal

  local term = termModule.find(terminal_has_name(name))
    or Terminal:new({
      display_name = name,
    })

  term:toggle()
end

return {
  'akinsho/toggleterm.nvim',
  opts = {
    open_mapping = false,
  },
  keys = {
    {
      '<leader>tg',
      function()
        toggle_named_term('General')
      end,
      mode = 'n',
    },
    {
      '<leader>tt',
      function()
        toggle_named_term('Testing')
      end,
      mode = 'n',
    },
  },
}
