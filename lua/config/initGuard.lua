local lazyPath = require('config.constants').lazyPath
local prompt_any_key_and_exit = require('helpers.prompts').prompt_any_key_and_exit

local minVersion = {
  major = 0,
  minor = 11,
  patch = 0,
}

local function format_nvim_version(version)
  return string.format('%d.%d.%d', version.major, version.minor, version.patch)
end

local function print_version_error_message()
  vim.api.nvim_echo(
    {
      { 'Neovim version is ' },
      { format_nvim_version(vim.version()) },
      { ' Minimum required version is ' },
      { format_nvim_version(minVersion) },
      { '\n' },
    },
    false,
    {
      err = true,
    }
  )
end

local function assert_nvim_version()
  if vim.version.lt(vim.version(), minVersion) then
    print_version_error_message()
    prompt_any_key_and_exit()
  end
end

local function print_no_lazy_error_message()
  local configPath = vim.fn.stdpath('config')
  vim.api.nvim_echo(
    {
      { 'Unable to find lazy installed at ' },
      { string.format("'%s'\n", lazyPath) },
      { string.format("Please run '%s/bootstrap.sh'\n", configPath) },
    },
    false,
    {
      err = true,
    }
  )
end

local function assert_lazy_install()
  if not vim.uv.fs_stat(lazyPath) then
    print_no_lazy_error_message()
    prompt_any_key_and_exit()
  end
end

assert_nvim_version()
assert_lazy_install()
