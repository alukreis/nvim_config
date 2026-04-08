local terminals = require('helpers.terminals')
local get_relative_path = require('helpers.path').get_relative_path

local function get_test_file_from_file(file, suffix)
  local fileNoSuffix = vim.fn.fnamemodify(file, ':r')
  return fileNoSuffix .. suffix
end

local function get_relative_file_path(bufNumber, commandParams)
  local baseDirectory = commandParams.base_directory
  local fullPath = vim.api.nvim_buf_get_name(bufNumber)
  local basePath = vim.uv.cwd() .. (baseDirectory and '/' .. baseDirectory or '')

  return pcall(get_relative_path, basePath, fullPath)
end

local function get_test_path(relativeFilePath, testSuffix)
  local hasFileSuffix = relativeFilePath:match(testSuffix .. '$') ~= nil
  return hasFileSuffix and relativeFilePath or get_test_file_from_file(relativeFilePath, testSuffix)
end

local function test_valid_path_in_terminal(params)
  local fullCommand =
    params.command:format(get_test_path(params.relativeFilePath, params.testSuffix))

  local term = terminals.get_term_by_name('Testing')
  if not term:is_open() then
    term:open()
  end
  term:send(fullCommand)
end

local function test_current_file(bufNumber, commandParams)
  local command, testSuffix = commandParams.command, commandParams.file_suffix
  local isValidPath, relativePathOrError = get_relative_file_path(bufNumber, commandParams)

  if isValidPath then
    test_valid_path_in_terminal({
      command = command,
      testSuffix = testSuffix,
      relativeFilePath = relativePathOrError,
    })
  else
    vim.api.nvim_echo({
      { relativePathOrError, 'ErrorMsg' },
      { '\n' },
    }, true, {})
  end
end

--[[
  val = {
    command: string,
    file_suffix: string,
    base_directory: string | nil
  }
--]]
local function generate_validate_test_file_command(bufNumber, val)
  local get_command_params, loadError = loadstring(('return %s'):format(val))

  return function()
    if get_command_params ~= nil then
      test_current_file(bufNumber, get_command_params())
    else
      vim.api.nvim_echo({
        { 'Unable to parse test command: \n', 'ErrorMsg' },
        { loadError, 'ErrorMsg' },
        { '\n' },
      }, true, {})
    end
  end
end

return generate_validate_test_file_command

