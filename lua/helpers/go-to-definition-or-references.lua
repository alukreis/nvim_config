local function go_to_definition_or_references()
  local tokens = vim.lsp.semantic_tokens.get_at_pos()
  if tokens ~= nil then
    local firstToken = tokens[1]
    if firstToken ~= nil then
      if firstToken.modifiers.declaration or firstToken.modifiers.definition then
        vim.lsp.buf.references()
      else
        vim.lsp.buf.definition()
      end
    end
  end
end

return {
  go_to_definition_or_references = go_to_definition_or_references,
}
