local function parse_version_string(versionString)
  local splitArray = {}
  local index = 1
  for number in string.gmatch(versionString, '%d+') do
    splitArray[index] = tonumber(number)
    index = index + 1
  end
  return splitArray
end

local function get_python_executable()
  local runtimes = { 'python38', 'python3', 'python' }
  for _, runtime in ipairs(runtimes) do
    if vim.fn.executable(runtime) == 1 then
      return runtime
    end
  end

  return nil
end

local function is_minimum_coq_python_version()
  local pythonVersionOutput = vim.fn.system(string.format('%s --version', get_python_executable()))
  local pythonVersionString = string.match(pythonVersionOutput, '%d+.%d+.%d')

  local versionArray = parse_version_string(pythonVersionString)
  local major, minor, revision = versionArray[1], versionArray[2], versionArray[3]

  return major > 3 or (major == 3 and (minor > 8 or (minor == 8 and revision >= 4)))
end

local function are_coq_dependencies_installed()
  local isPythonInstalled = get_python_executable() ~= nil
  if isPythonInstalled then
    local isSqliteInstalled =
      vim.fn.executable('sqlite') == 1
      or vim.fn.executable('sqlite3') == 1
    return isSqliteInstalled and is_minimum_coq_python_version()
  end
end

return {
  parse_version_string = parse_version_string,
  are_coq_dependencies_installed = are_coq_dependencies_installed
}
