local function prompt_any_key_and_exit()
  vim.api.nvim_echo({
    { 'Press any key to exit.\n' },
  }, false, {})
  vim.fn.getchar()
  os.exit(1)
end

return {
  prompt_any_key_and_exit = prompt_any_key_and_exit,
}
