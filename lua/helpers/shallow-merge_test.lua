local shallow_merge = require('helpers.shallow-merge')

describe('shallow_merge', function()
  it('merges single level tables', function()
    local table1 = { key1 = 'value1', key2 = 'value2' }
    local table2 = { key1 = 'value1', key2 = 'value2New' }
    local table3 = { key2 = 'value2Other' }
    assert.are.same({ key1 = 'value1', key2 = 'value2New' }, shallow_merge(table1, table2))
    assert.are.same({ key1 = 'value1', key2 = 'value2' }, shallow_merge(table2, table1))
    assert.are.same({ key1 = 'value1', key2 = 'value2Other' }, shallow_merge(table1, table3))
  end)
end)
