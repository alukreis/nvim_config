return {
  'owallb/mason-auto-install.nvim',
  dependencies = {
    'mason-org/mason.nvim',
    'neovim/nvim-lspconfig',
  },
  opts = {
    packages = {
      'black',
      'stylua',
      'eslint_d',
      'prettierd',
      'rust-analyzer',
      'python-lsp-server',
      'lua-language-server',
      'bash-language-server',
      'angular-language-server',
      'sonarlint-language-server',
      'typescript-language-server',
      'tailwindcss-language-server',
    },
  },
}
