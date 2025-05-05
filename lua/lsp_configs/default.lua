local shallow_merge = require('helpers.shallow-merge')
local commonKeymapOptions = require('config.constants').commonKeymapOptions
local go_to_definition_or_references =
  require('helpers.go-to-definition-or-references').go_to_definition_or_references

return {
  on_attach = function(_, bufferNumber)
    local keyMapOptions = shallow_merge(commonKeymapOptions, {
      desc = 'Go to definition if on a reference, else show references for a definition or declaration',
      buffer = bufferNumber,
    })
    vim.keymap.set('n', '<C-]>', go_to_definition_or_references, keyMapOptions)
  end,
}
