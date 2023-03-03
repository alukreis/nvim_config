local function lsp_config_wrapper(lspCmd, lsp_setup)
  if vim.fn.executable(lspCmd) == 1
  then
    lsp_setup()
  else
    print(string.format('lsp %s is not installed', lspCmd))
  end
end

local function on_attach(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  --local bufferOptions = { noremap=true, silent=true, buffer=bufnr }
end

lsp_config_wrapper(
  'lua-language-server',
  function ()
    require('lspconfig').lua_ls.setup({
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
    })
  end
)
