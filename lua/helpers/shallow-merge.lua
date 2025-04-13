local shallow_copy = require('helpers.shallow-copy')

local function shallow_merge(originalTable, newKeyTable)
  local mergeTable = shallow_copy(originalTable)
  for key, value in pairs(newKeyTable) do
    mergeTable[key] = value
  end
  return mergeTable
end

return shallow_merge
