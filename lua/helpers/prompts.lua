local function promptAnyKeyAndExit()
  vim.api.nvim_echo({
    { 'Press any key to exit.\n' },
  }, false, {})
  vim.fn.getchar()
  os.exit(1)
end

return {
  promptAnyKeyAndExit = promptAnyKeyAndExit,
}
