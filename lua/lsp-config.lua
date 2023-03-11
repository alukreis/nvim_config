local helpers = require('helpers')

local function lsp_config_wrapper(lspCmd, lsp_setup)
  if vim.fn.executable(lspCmd) == 1
  then
    lsp_setup()
  else
    print(string.format('lsp %s is not installed', lspCmd))
  end
end

local function on_attach(_, bufnr)
  local bufferOptions = { noremap=true, silent=true, buffer=bufnr }

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufferOptions)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufferOptions)
end

lsp_config_wrapper(
  'lua-language-server',
  function ()
    require('lspconfig').lua_ls.setup(helpers.ensure_lsp_capabilities({
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = {'vim'},
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    }))
  end
)

lsp_config_wrapper(
  'pylsp',
  function ()
    require('lspconfig').pylsp.setup(helpers.ensure_lsp_capabilities({
      on_attach = on_attach,
    }))
  end
)
