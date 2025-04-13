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

set_default_indent_size(2)
set_default_tabs_or_spaces('spaces')
set_default_shell_if_windows('powershell')
