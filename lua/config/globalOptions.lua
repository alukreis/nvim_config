local function configure_leader_characters()
  vim.g.mapleader = ' '
  vim.g.maplocalleader = '\\'
end

local function configure_headless_mode()
  if #vim.api.nvim_list_uis() == 0 then
    vim.g.is_headless = true
  else
    vim.g.is_headless = false
  end
end

local function configure_enable_plugins()
  if vim.g.enable_plugins == nil then
    vim.g.enable_plugins = true
  end
end

configure_headless_mode()

if not vim.g.is_headless then
  configure_enable_plugins()
  configure_leader_characters()
end
