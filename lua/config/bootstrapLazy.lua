local lazyPath = require('config.constants').lazyPath

local function echo_error_and_exit_on_key_press(errorMsg)
  vim.api.nvim_echo({
    { 'Failed to clone lazy.nvim: \n', 'ErrorMsg' },
    { errorMsg },
    { '\n' },
  }, false, {})
end

local function call_system_git_clone_and_wait()
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  return vim
    .system({
      'git',
      'clone',
      '--filter=blob:none',
      '--branch=stable',
      lazyrepo,
      lazyPath,
    }, {
      -- Auto fail if git prompts for information
      env = { GIT_TERMINAL_PROMPT = '0' },
    })
    :wait()
end

local function bootstrap_lazy_package_manager()
  local cloneResult = call_system_git_clone_and_wait()
  if cloneResult.code ~= 0 then
    echo_error_and_exit_on_key_press(cloneResult.stderr)
  else
    vim.api.nvim_echo({
      { 'Lazy was bootstrapped successfully.\n' },
    }, false, {})
  end
end

local function echo_lazy_installed_message()
  vim.api.nvim_echo({
    { 'Lazy package manager is already installed, you are good to go :).\n' },
  }, false, {})
end

local function bootstrap_lazy()
  if not vim.uv.fs_stat(lazyPath) then
    bootstrap_lazy_package_manager()
  else
    echo_lazy_installed_message()
  end
end

return bootstrap_lazy
