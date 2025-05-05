return {
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      sections = {
        lualine_c = {
          {
            'filename',
            path = 1,
          },
        },
      },
    },
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
    lazy = false,
  },
  {
    'folke/trouble.nvim',
    opts = {},
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
    lazy = false,
  },
}
