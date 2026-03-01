local function configureLeaderCharacters()
  vim.g.mapleader = ' '
  vim.g.maplocalleader = '\\'
end

local function configureHeadlessMode()
  if #vim.api.nvim_list_uis() == 0 then
    vim.g.is_headless = true
  else
    vim.g.is_headless = false
  end
end

local function configureEnablePlugins()
  if vim.g.enable_plugins == nil then
    vim.g.enable_plugins = true
  end
end

configureHeadlessMode()

if not vim.g.is_headless then
  configureEnablePlugins()
  configureLeaderCharacters()
end
