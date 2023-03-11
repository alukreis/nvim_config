local helpers = require('helpers')
local c = require('constants')

if helpers.are_coq_dependencies_installed() then
  vim.g.coq_settings = {
    auto_start='shut-up'
  }

  -- Get COQ out if available
  vim.cmd(string.format('packadd %s', c.COQ_NVIM_NAME))
  vim.cmd(string.format('packadd %s', c.COQ_ARTIFACTS_NAME))
else
  vim.g.completeopt='menu,menuone,noselect'

  -- Otherwise fallback to nvim-cmp
  vim.cmd(string.format('packadd %s', c.NVIM_CMP))
  vim.cmd(string.format('packadd %s', c.NVIM_CMP_LSP))
  vim.cmd(string.format('packadd %s', c.NVIM_CMP_BUFFER))
  vim.cmd(string.format('packadd %s', c.NVIM_CMP_PATH))
  vim.cmd(string.format('packadd %s', c.NVIM_CMP_VSNIP))
  vim.cmd(string.format('packadd %s', c.NVIM_CMP_VIM_VSNIP))

  local nvimCmp = require("cmp")

  nvimCmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end
    },
  --window = {
  --  completion = nvimCmp.config.window.bordered(),
  --  documentation = nvimCmp.config.window.bordered(),
  --})
    mapping = nvimCmp.mapping.preset.insert({
      --['<C-d>'] = nvimCmp.mapping.scroll_docs(-4),
      --['<C-f>'] = nvimCmp.mapping.scroll_docs(4),
      ['<S-Tab>'] = nvimCmp.mapping.select_prev_item(),
      ['<Tab>'] = nvimCmp.mapping.select_next_item(),
      ['<C-Space>'] = nvimCmp.mapping.complete(),
      ['<CR>'] = nvimCmp.mapping.confirm({ select = true }),
    }),
    sources = nvimCmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, { name='buffer' })
  })
end
