local has_value = require('helpers.has-value').has_value

describe('has_value', function()
  it('returns true if value is in array', function()
    local array = { 'value1', 'value2' }
    assert.is_true(has_value(array, 'value1'))
    assert.is_true(has_value(array, 'value2'))
  end)

  it('returns false if value is not in array', function()
    assert.is_false(has_value({}, 'value1'))
  end)
end)
