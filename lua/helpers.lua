local function shallow_copy(originalTable)
  local copyTable = {}
  for key, value in pairs(originalTable) do
    copyTable[key] = value
  end
  return copyTable
end

local function shallow_merge(originalTable, newKeyTable)
  local mergeTable = shallow_copy(originalTable)
  for key, value in pairs(newKeyTable) do
    mergeTable[key] = value
  end
  return mergeTable
end

return {
  shallow_copy = shallow_copy,
  shallow_merge = shallow_merge
}

