local testModule = require('helpers.go-to-definition-or-references')
local go_to_definition_or_references = testModule.go_to_definition_or_references

local function spy_on_get_at_pos(returnValue)
  vim.lsp.semantic_tokens.get_at_pos = function()
    return returnValue
  end
  spy.on(vim.lsp.semantic_tokens, 'get_at_pos')
end

local function stub_zero_param_function(parentTable, functionName)
  parentTable[functionName] = function() end
  stub(parentTable, functionName)
end

describe('go_to_definition_or_references', function()
  local default_function = function()
    error('Oops, you should replace me!')
  end
  _G.vim = {
    lsp = {
      buf = {
        definition = default_function,
        references = default_function,
      },
      semantic_tokens = {
        get_at_pos = default_function,
      },
    },
  }

  before_each(function()
    vim.lsp.buf.definition = default_function
    vim.lsp.buf.references = default_function
    vim.lsp.semantic_tokens.get_at_pos = default_function
  end)

  it('gets the token under the cursor', function()
    spy_on_get_at_pos({})
    stub_zero_param_function(vim.lsp.buf, 'definition')
    go_to_definition_or_references()
    assert.stub(vim.lsp.semantic_tokens.get_at_pos).called(1)
    assert.stub(vim.lsp.semantic_tokens.get_at_pos).called_with()
  end)

  it('opens reference panel if over a declaration token', function()
    spy_on_get_at_pos({
      {
        modifiers = {
          declaration = true,
        },
      },
    })
    stub_zero_param_function(vim.lsp.buf, 'references')
    go_to_definition_or_references()
    assert.stub(vim.lsp.semantic_tokens.get_at_pos).called(1)
    assert.stub(vim.lsp.semantic_tokens.get_at_pos).called_with()
    assert.stub(vim.lsp.buf.references).called(1)
    assert.stub(vim.lsp.buf.references).called_with()
  end)

  it('opens reference panel if over a definition token', function()
    spy_on_get_at_pos({
      {
        modifiers = {
          definition = true,
        },
      },
    })
    stub_zero_param_function(vim.lsp.buf, 'references')
    go_to_definition_or_references()
    assert.stub(vim.lsp.semantic_tokens.get_at_pos).called(1)
    assert.stub(vim.lsp.semantic_tokens.get_at_pos).called_with()
    assert.stub(vim.lsp.buf.references).called(1)
    assert.stub(vim.lsp.buf.references).called_with()
  end)

  it('goes to definition if not declaration or definition', function()
    spy_on_get_at_pos({
      {
        modifiers = {
          definition = false,
          declaration = false,
        },
      },
    })
    stub_zero_param_function(vim.lsp.buf, 'definition')
    go_to_definition_or_references()
    assert.stub(vim.lsp.semantic_tokens.get_at_pos).called(1)
    assert.stub(vim.lsp.semantic_tokens.get_at_pos).called_with()
    assert.stub(vim.lsp.buf.definition).called(1)
    assert.stub(vim.lsp.buf.definition).called_with()
  end)

  it('goes to definition if no token is found', function()
    spy_on_get_at_pos({})
    stub_zero_param_function(vim.lsp.buf, 'definition')
    go_to_definition_or_references()
    assert.stub(vim.lsp.semantic_tokens.get_at_pos).called(1)
    assert.stub(vim.lsp.semantic_tokens.get_at_pos).called_with()
    assert.stub(vim.lsp.buf.definition).called(1)
    assert.stub(vim.lsp.buf.definition).called_with()
  end)
end)
