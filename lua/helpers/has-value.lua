local function has_value(array, value)
  for _, j in pairs(array) do
    if j == value then
      return true
    end
  end

  return false
end

return {
  has_value = has_value,
}
