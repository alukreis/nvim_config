local function get_error_msg(params)
  local system, pathType, path = params.system, params.pathType, params.path
  return string.format("Invalid %s %s path '%s'", system, pathType, path)
end

local function get_system_info()
  local sysname = vim.uv.os_uname().sysname

  return sysname == 'Windows_NT' and {
    system = 'windows',
    validRegex = '^[A-Z]:/',
  } or {
    system = 'unix',
    validRegex = '^/',
  }
end

local function does_start_with(basePath, fullPath)
  local escapedBase = basePath:gsub('%-', '%%-')
  local baseMatch = ('^%s/'):format(escapedBase)
  return fullPath:match(baseMatch) ~= nil
end

local function validate_paths(basePath, fullPath)
  local systemInfo = get_system_info()
  local system, validRegex = systemInfo.system, systemInfo.validRegex
  if basePath:match(validRegex) == nil then
    error(get_error_msg({
      path = basePath,
      system = system,
      pathType = 'base',
    }))
  elseif fullPath:match(validRegex) == nil then
    error(get_error_msg({
      path = fullPath,
      system = system,
      pathType = 'full',
    }))
  elseif basePath ~= fullPath and not does_start_with(basePath, fullPath) then
    error(("Full path '%s' does not start with base '%s'"):format(fullPath, basePath))
  end
end

local function get_relative_path(basePath, fullPath)
  local systemInfo = get_system_info()
  local normalisedBasePath = vim.fs.normalize(basePath, { win = systemInfo.system == 'windows'})
  local normalisedFullPath = vim.fs.normalize(fullPath, { win = systemInfo.system == 'windows'})
  vim.print(normalisedBasePath)
  vim.print(normalisedFullPath)
  validate_paths(normalisedBasePath, normalisedFullPath)
  return basePath == fullPath and '.' or vim.fs.relpath(normalisedBasePath, normalisedFullPath)
end

return {
  get_relative_path = get_relative_path,
}
