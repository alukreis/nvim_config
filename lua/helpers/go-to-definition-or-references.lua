local function is_declaration_or_definition(token)
  local modifiers = token.modifiers
  return modifiers.declaration or modifiers.definition
end

local function go_to_definition_or_references()
  local tokens = vim.lsp.semantic_tokens.get_at_pos()
  if tokens ~= nil then
    local firstToken = tokens[1]
    if firstToken ~= nil and is_declaration_or_definition(firstToken) then
      vim.lsp.buf.references()
    else
      vim.lsp.buf.definition()
    end
  end
end

return {
  go_to_definition_or_references = go_to_definition_or_references,
}
