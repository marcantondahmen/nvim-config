vim.g.nord_contrast = false
vim.g.nord_borders = true
vim.g.nord_disable_background = false
vim.g.nord_italic = false
vim.g.nord_uniform_diff_background = true
vim.g.nord_bold = false

-- Load the colorscheme
require('nord').set()

-- https://github.com/shaunsingh/nord.nvim/blob/master/lua/nord/theme.lua
vim.cmd([[
	colorscheme nord

	highlight FloatBorder guifg=#4C566A
	highlight TelescopePromptBorder guifg=#4C566A
	highlight TelescopeResultsBorder guifg=#4C566A
	highlight TelescopePreviewBorder guifg=#4C566A
	highlight NvimTreeIndentMarker guifg=#4C566A
	highlight LspFloatWinBorder guifg=#4C566A
	highlight LspSagaDefPreviewBorder guifg=#4C566A
	highlight LspSagaCodeActionBorder guifg=#4C566A
	highlight LspSagaLspFinderBorder guifg=#4C566A
	highlight DefinitionBorder guifg=#4C566A
	highlight LspSagaHoverBorder guifg=#4C566A
	highlight LspSagaRenameBorder guifg=#4C566A
	highlight LspSagaDiagnosticBorder guifg=#4C566A
	highlight LSOutlinePreviewBorder guifg=#4C566A
]])