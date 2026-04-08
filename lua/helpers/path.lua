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
  elseif basePath ~= fullPath and fullPath:match(('^%s/'):format(basePath)) == nil then
    error(("Full path '%s' does not start with base '%s'"):format(fullPath, basePath))
  end
end

local function get_relative_path(basePath, fullPath)
  local normalisedBasePath = vim.fs.normalize(basePath)
  validate_paths(normalisedBasePath, fullPath)
  return basePath == fullPath and '.' or vim.fs.relpath(basePath, fullPath)
end

return {
  get_relative_path = get_relative_path,
}
