return function(path)
  local lines = {}
  for line in io.lines(path) do
    table.insert(lines, line)
  end
  return lines
end
