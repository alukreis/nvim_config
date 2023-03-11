-- My files
require('options') -- Always do this first, often other plugins require the options are set
require('paq-enable')
require('lazy')
require('keymaps')
require('lsp-config')

-- Plugins
require('lualine').setup({})
require('nvim-tree').setup({})
require('leap').add_default_mappings()
require('trouble').setup({})
