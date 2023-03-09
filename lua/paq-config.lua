local c = require('constants')

return {
  'savq/paq-nvim',
  'Th3Whit3Wolf/one-nvim', -- colorscheme
  'neovim/nvim-lspconfig',
  'ggandor/leap.nvim',
  -- Lualine
  'kyazdani42/nvim-web-devicons',
  'nvim-lualine/lualine.nvim',
  -- Nvim Tree
  'nvim-tree/nvim-web-devicons',
  'nvim-tree/nvim-tree.lua',
  -- COQ stuff, only loaded if deps there
  {
    string.format('%s/%s', c.COQ_AUTHOR_NAME, c.COQ_NVIM_NAME), opt=true,
    run=function() local coqApi = require('coq'); coqApi.deps() end
  },
  { string.format('%s/%s', c.COQ_AUTHOR_NAME, c.COQ_ARTIFACTS_NAME), opt=true },
  -- Nvim cmp stuff
  { string.format('%s/%s', c.NVIM_CMP_AUTHOR_NAME, c.NVIM_CMP), opt=true },
  { string.format('%s/%s', c.NVIM_CMP_AUTHOR_NAME, c.NVIM_CMP_LSP), opt=true },
  { string.format('%s/%s', c.NVIM_CMP_AUTHOR_NAME, c.NVIM_CMP_BUFFER), opt=true },
  { string.format('%s/%s', c.NVIM_CMP_AUTHOR_NAME, c.NVIM_CMP_PATH), opt=true },
  { string.format('%s/%s', c.NVIM_CMP_AUTHOR_NAME, c.NVIM_CMP_VSNIP), opt=true },
  { string.format('%s/%s', c.NVIM_CMP_AUTHOR_NAME, c.NVIM_CMP_VIM_VSNIP), opt=true },
}
