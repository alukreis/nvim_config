local function terminal_has_name(name)
  return function(terminal)
    return terminal.display_name == name
  end
end

local function get_term_by_name(name)
  local termModule = require('toggleterm.terminal')
  local Terminal = termModule.Terminal

  return termModule.find(terminal_has_name(name))
    or Terminal:new({
      display_name = name,
    })
end

local function toggle_general_term()
  get_term_by_name('General'):toggle()
end

local function toggle_testing_term()
  get_term_by_name('Testing'):toggle()
end

return {
  get_term_by_name = get_term_by_name,
  toggle_general_term = toggle_general_term,
  toggle_testing_term = toggle_testing_term,
}
