local helpers = require('helpers')

describe('helpers', function()
  describe('shallow_copy', function()
    local shallow_copy = helpers.shallow_copy

    it('can shallow copy', function()
      local emptyTable = {}
      local fullTable = { key1 = 'value1', key2 = 'value2' }
      local fullWithNestedTable = {
        key1 = 'value1',
        key2 = 'value2',
        key3 = {
          nestedKey = 'nestedValue'
        }
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

  describe('shallow_merge', function()
    local shallow_merge = helpers.shallow_merge
    it('merges single level tables', function()
      local table1 = { key1 = 'value1', key2 = 'value2' }
      local table2 = { key1 = 'value1', key2 = 'value2New' }
      local table3 = { key2 = 'value2Other' }
      assert.are.same(
        { key1 = 'value1', key2 = 'value2New' },
        shallow_merge(table1, table2)
      )
      assert.are.same(
        { key1 = 'value1', key2 = 'value2' },
        shallow_merge(table2, table1)
      )
      assert.are.same(
        { key1 = 'value1', key2 = 'value2Other' },
        shallow_merge(table1, table3)
      )
    end)
  end)
end)
