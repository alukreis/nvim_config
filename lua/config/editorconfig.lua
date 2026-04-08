local editorconfig = require('editorconfig')
local shallow_merge = require('helpers.shallow-merge')
local commonKeymapOptions = require('config.constants').commonKeymapOptions
local generate_validate_test_file_command = require('helpers.generate_validate_test_file_command')

editorconfig.properties.file_test_command = function(bufNumber, val)
  if val ~= nil then
    vim.keymap.set(
      'n',
      '<leader>v',
      generate_validate_test_file_command(bufNumber, val),
      shallow_merge(commonKeymapOptions, { buffer = bufNumber })
    )
  end
end

