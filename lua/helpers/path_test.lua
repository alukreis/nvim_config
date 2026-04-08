local path = require('helpers.path')
local shallow_merge = require('helpers.shallow-merge')

describe('get_relative_path', function()
  local get_relative_path = path.get_relative_path
  insulate('unix', function()
    it('returns an error with a nil result if either path does not start with a /', function()
      assert.error(function ()
        get_relative_path('base', '/full')
      end, "Invalid unix base path 'base'")

      assert.error(function ()
        get_relative_path('/base', 'full')
      end, "Invalid unix full path 'full'")

      assert.error(function ()
        get_relative_path('otherBase', 'full')
      end, "Invalid unix base path 'otherBase'")
    end)

    it('errors if full path does not start with base path', function()
      local basePath2 = '/current/woking/dir'
      local fullPath2 = '/current/working/dir/where/you/go'
      assert.error(function ()
        get_relative_path(basePath2, fullPath2)
      end, ("Full path '%s' does not start with base '%s'"):format(fullPath2, basePath2))

      local basePath3 = '/current/working/di'
      local fullPath3 = '/current/working/dir/where/you/go'
      assert.error(function ()
        get_relative_path(basePath3, fullPath3)
      end, ("Full path '%s' does not start with base '%s'"):format(fullPath3, basePath3))

      local basePath4 = '/current/working/d'
      local fullPath4 = '/current/working/dir'
      assert.error(function ()
        get_relative_path(basePath4, fullPath4)
      end, ("Full path '%s' does not start with base '%s'"):format(fullPath4, basePath4))
    end)

    it('returns a dot if both paths are the same', function()
      assert.are_equal('.', get_relative_path('/same', '/same'))
    end)

    it('returns the relative path', function()
      local basePath1 = '/current/working/dir'
      local fullPath1 = '/current/working/dir/with/extra/steps'
      assert.are_equal('with/extra/steps', get_relative_path(basePath1, fullPath1))

      local basePath2 = '/other/place/to/work/'
      local fullPath2 = '/other/place/to/work/with/others.lua'
      assert.are_equal('with/others.lua', get_relative_path(basePath2, fullPath2))
    end)
  end)

  insulate('windows', function()
    local osNameSpy

    before_each(function ()
      local originalUname = vim.uv.os_uname()
      osNameSpy = stub(vim.uv, 'os_uname', function()
        return shallow_merge(originalUname, { sysname = 'Windows_NT' })
      end)
    end)

    after_each(function ()
      osNameSpy:revert()
    end)

    it('also errors if invalid normalised path on windows', function()
      assert.error(function ()
        get_relative_path('wbase', 'C:/full')
      end, "Invalid windows base path 'wbase'")

      assert.error(function ()
        get_relative_path('D:/base', 'wfull')
      end, "Invalid windows full path 'wfull'")

      assert.error(function ()
        get_relative_path('wotherBase', 'full')
      end, "Invalid windows base path 'wotherBase'")
    end)

    it('errors if full path does not start with base path', function()
      local basePath1 = 'D:/current/working/dir'
      local fullPath1 = 'C:/current/working/dir/where/you/go'
      assert.error(function ()
        get_relative_path(basePath1, fullPath1)
      end, ("Full path '%s' does not start with base '%s'"):format(fullPath1, basePath1))
    end)

    it('returns a dot if both paths are the same', function()
      assert.are_equal('.', get_relative_path('E:/same', 'E:/same'))
    end)

    it('returns the relative path', function()
      local basePath = 'C:/current/working/dir'
      local fullPath = 'C:/current/working/dir/where/you/go'
      assert.are_equal('where/you/go', get_relative_path(basePath, fullPath))
    end)
  end)
end)
