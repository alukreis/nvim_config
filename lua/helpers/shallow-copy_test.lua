local shallow_copy = require('helpers.shallow-copy')

describe('shallow_copy', function()
  it('can shallow copy', function()
    local emptyTable = {}
    local fullTable = { key1 = 'value1', key2 = 'value2' }
    local fullWithNestedTable = {
      key1 = 'value1',
      key2 = 'value2',
      key3 = {
        nestedKey = 'nestedValue',
      },
    }

    local emptyTableCopy = shallow_copy(emptyTable)
    local fullTableCopy = shallow_copy(fullTable)
    local fullWithNestedTableCopy = shallow_copy(fullWithNestedTable)

    assert.are.same(emptyTable, emptyTableCopy)
    assert.are_not.equal(emptyTable, emptyTableCopy)

    assert.are.same(fullTable, fullTableCopy)
    assert.are_not.equal(fullTable, fullTableCopy)

    assert.are.same(fullWithNestedTable, fullWithNestedTableCopy)
    assert.are_not.equal(fullWithNestedTable, fullWithNestedTableCopy)
    -- Should only shallow copy
    assert.are.equal(fullWithNestedTable.key3, fullWithNestedTableCopy.key3)
  end)
end)
