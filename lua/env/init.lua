local keyValueRegex = [[^([%a_][%w_]*)%s*=%s*['"]?(.-)['"]?%s*$]]

local M = {
  _isEnvLoaded = false,
  _statusTable = { error = 'Setup not Run' },
}

M.setup = function()
  local fileContents = M._readEnvFile()
  if M.is_loaded() then
    M._loadEnvFileContents(fileContents)

    if vim.tbl_count(M._statusTable.loadedVars) == 0 then
      M._apply_empty_vars_state()
    end
  end
end

M._readEnvFile = function()
  local isEnvLoaded, fileContentsOrError =
    pcall(vim.fn.readfile, vim.fn.stdpath('config') .. '/.env')
  M._isEnvLoaded = isEnvLoaded
  M._statusTable = isEnvLoaded and { loadedVars = {}, badVars = {} }
    or { error = fileContentsOrError }

  return fileContentsOrError
end

M._loadEnvFileContents = function(fileContents)
  for lineIndex, line in ipairs(fileContents) do
    local isEmptyLine = line:match([[^%s*$]]) and true or false

    if not isEmptyLine then
      M._loadValidLineEnv(lineIndex, line)
    end
  end
end

M._loadValidLineEnv = function(lineIndex, line)
  local key, val = line:match(keyValueRegex)
  if key ~= nil then
    vim.env[key] = val
    M._statusTable.loadedVars[key] = val
  else
    table.insert(M._statusTable.badVars, string.format('%d: %s', lineIndex, line))
  end
end

M._apply_empty_vars_state = function()
  M._isEnvLoaded = false
  M._statusTable = {
    error = string.format(
      'None of the key/value pairs were valid:\n%s',
      vim.inspect(M._statusTable.badVars)
    ),
  }
end

M.is_loaded = function()
  return M._isEnvLoaded
end

M.get_status = function()
  return M._statusTable
end

return M
