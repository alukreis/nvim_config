local function lsp_config_wrapper(lspCmd, lsp_setup)
  if vim.fn.executable(lspCmd) == 1
  then
    lsp_setup()
  else
    print(string.format('lsp %s is not installed', lspCmd))
  end
end

lsp_config_wrapper(
  'lua-language-server',
  function ()
    require('lspconfig').lua_ls.setup({
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
