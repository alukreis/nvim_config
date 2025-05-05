-- These will get overridden by buffer options or .editorconfig
local function set_default_indent_size(size)
  vim.api.nvim_set_option_value('tabstop', size, {})
  vim.api.nvim_set_option_value('shiftwidth', size, {})
  vim.api.nvim_set_option_value('softtabstop', size, {})
end

-- This will get overridden by buffer options or .editorconfig
local function set_default_tabs_or_spaces(tabsOrSpaces)
  vim.api.nvim_set_option_value('expandtab', tabsOrSpaces == 'spaces', {})
end

local function set_default_shell_if_windows(shell)
  if vim.uv.os_uname().sysname == 'Windows_NT' then
    vim.api.nvim_set_option_value('shell', shell, {})
  end
end

local function set_mouse(isEnabled)
  local setting = ''
  if isEnabled then
    setting = 'a' -- Enabled in all modes
  end
  vim.api.nvim_set_option_value('mouse', setting, {})
end

local function set_numbers(isEnabled)
  vim.api.nvim_set_option_value('number', isEnabled, {})
end

local function toggle_numbers()
  local currentValue = vim.api.nvim_get_option_value('number', {})
  set_numbers(not currentValue)
end

return {
  set_mouse = set_mouse,
  set_numbers = set_numbers,
  toggle_numbers = toggle_numbers,
  set_default_indent_size = set_default_indent_size,
  set_default_tabs_or_spaces = set_default_tabs_or_spaces,
  set_default_shell_if_windows = set_default_shell_if_windows,
}
