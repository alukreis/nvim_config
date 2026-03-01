local lazyPath = require('config.constants').lazyPath

local function echoErrorAndExitOnKeyPress(errorMsg)
  vim.api.nvim_echo({
    { 'Failed to clone lazy.nvim: \n', 'ErrorMsg' },
    { errorMsg },
    { '\n' },
  }, false, {})
end

local function callSystemGitCloneAndWait()
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  return vim.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazyrepo,
    lazyPath,
  }, {
    -- Auto fail if git prompts for information
    env = { GIT_TERMINAL_PROMPT = "0" },
  }):wait()
end

local function bootstrapLazyPackageManager()
  local cloneResult = callSystemGitCloneAndWait()
  if cloneResult.code ~= 0 then
    echoErrorAndExitOnKeyPress(cloneResult.stderr)
  else
    vim.api.nvim_echo({
      { 'Lazy was bootstrapped successfully.\n' },
    }, false, {})
  end
end

local function echoLazyInstalledMessage()
  vim.api.nvim_echo({
    { 'Lazy package manager is already installed, you are good to go :).\n' },
  }, false, {})
end

local function bootstrapLazy()
  if not vim.uv.fs_stat(lazyPath) then
    bootstrapLazyPackageManager()
  else
    echoLazyInstalledMessage()
  end
end

return bootstrapLazy
