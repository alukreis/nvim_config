-- https://cmp.saghen.dev/configuration/general.html
return {
  'saghen/blink.cmp',
  version = '1.*',
  opts = {
    keymap = {
      preset = 'enter',
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
      ['<Right>'] = { 'snippet_forward', 'fallback' },
      ['<Left>'] = { 'snippet_backward', 'fallback' },
      ['<Up>'] = {},
      ['<Down>'] = {},
    },
    appearance = {
      nerd_font_variant = 'mono',
    },
    completion = {
      menu = {
        draw = {
          columns = {
            { 'kind_icon', gap = 1 },
            { 'label', 'label_description', gap = 1 },
            { 'source_name' },
          },
        },
      },
      documentation = {
        auto_show = false,
      },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = {
      implementation = 'prefer_rust_with_warning',
    },
  },
  opts_extend = { 'sources.default' },
}
