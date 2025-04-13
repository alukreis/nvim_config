local function shallow_copy(originalTable)
  local copyTable = {}
  for key, value in pairs(originalTable) do
    copyTable[key] = value
  end
  return copyTable
end

return shallow_copy
