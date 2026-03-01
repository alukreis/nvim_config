local lazyPath = require('config.constants').lazyPath
local promptAnyKeyAndExit = require('helpers.prompts').promptAnyKeyAndExit

local minVersion = {
  major = 0,
  minor = 11,
  patch = 0,
}

local function formatNvimVersion(version)
  return string.format('%d.%d.%d', version.major, version.minor, version.patch)
end

local function printVersionErrorMessage()
  vim.api.nvim_echo(
    {
      { 'Neovim version is ' },
      { formatNvimVersion(vim.version()) },
      { ' Minimum required version is ' },
      { formatNvimVersion(minVersion) },
      { '\n' },
    },
    false,
    {
      err = true,
    }
  )
end

local function assertNvimVersion()
  if vim.version.lt(vim.version(), minVersion) then
    printVersionErrorMessage()
    promptAnyKeyAndExit()
  end
end

local function printNoLazyErrorMessage()
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

local function assertLazyInstall()
  if not vim.uv.fs_stat(lazyPath) then
    printNoLazyErrorMessage()
    promptAnyKeyAndExit()
  end
end

assertNvimVersion()
assertLazyInstall()
