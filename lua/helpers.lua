local function parse_version_string(string)
  local splitArray = {}
  local index = 1
  for number in string.gmatch(string, '%d+') do
    splitArray[index] = tonumber(number)
    index = index + 1
  end
  return splitArray
end

local function is_minimum_coq_python_version()
  -- TODO: use correct executable to determine python version
  local pythonVersionOutput = vim.fn.system('python --version')
  local pythonVersionString = string.match(pythonVersionOutput, '%d+.%d+.%d')
  local versionArray = parse_version_string(pythonVersionString)
  local major, minor, revision = versionArray[1], versionArray[2], versionArray[3]

  return major > 3 or (major == 3 and (minor > 8 or (minor == 8 and revision >= 4)))
end

local function are_coq_dependencies_installed()
  local isPythonInstalled =
    vim.fn.executable('python') == 1
    or vim.fn.executable('python3') == 1
    or vim.fn.executable('python38') == 1
  if isPythonInstalled then
    local isSqliteInstalled =
      vim.fn.executable('sqlite') == 1
      or vim.fn.executable('sqlite3') == 1
    return isSqliteInstalled and is_minimum_coq_python_version()
  end
end

return {
  are_coq_dependencies_installed = are_coq_dependencies_installed
}
