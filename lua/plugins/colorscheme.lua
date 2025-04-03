return {
  {
    'rebelot/kanagawa.nvim',
    lazy = false, -- make sure we load this during startup
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      local callStatus, _ = pcall(vim.cmd.colorscheme, 'kanagawa-wave')
      if not callStatus then
        print('Unable to load colorscheme')
      end
    end,
    init = function()
      vim.o.termguicolors = true
    end
  }
}
