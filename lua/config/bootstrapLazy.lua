local function echoErrorAndExitOnKeyPress(out)
  vim.api.nvim_echo({
    { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
    { out, "WarningMsg" },
    { "\nPress any key to exit..." },
  }, true, {})
  vim.fn.getchar()
  os.exit(1)
end

local function bootstrapLazyPackageManager(lazyPath)
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazyPath })
  if vim.v.shell_error ~= 0 then
    echoErrorAndExitOnKeyPress(out)
  end
end

local function configureLeaderCharacters()
  vim.g.mapleader = ' '
  vim.g.maplocalleader = '\\'
end

-- Starts Here
local lazyPath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazyPath) then
  bootstrapLazyPackageManager(lazyPath)
end
-- Prepend to run time path
vim.opt.rtp:prepend(lazyPath)

configureLeaderCharacters()
