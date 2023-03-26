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

	highlight NormalMode guifg=#4C566A guibg=#D8DEE9
	highlight ReplaceMode guifg=#4C566A guibg=#D8DEE9
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
	highlight BufferCurrent guibg=#81A1C1 guifg=#2E3440
	highlight BufferCurrentMod guibg=#81A1C1 guifg=#4C566A
	highlight BufferCurrentIcon guibg=#81A1C1 guifg=#2E3440
	highlight BufferCurrentSign guibg=#81A1C1 guifg=#2E3440
	highlight BufferCurrentHINT guibg=#81A1C1 guifg=#BF616A
	highlight BufferCurrentERROR guibg=#81A1C1 guifg=#BF616A
	highlight BufferVisible guibg=#3B4252 guifg=#81A1C1
	highlight BufferVisibleMod guibg=#3B4252 guifg=#8FBCBB
	highlight BufferVisibleIcon guibg=#3B4252 guifg=#81A1C1
	highlight BufferVisibleSign guibg=#3B4252 guifg=#81A1C1
	highlight BufferVisibleHINT guibg=#3B4252 guifg=#BF616A
	highlight BufferVisibleERROR guibg=#3B4252 guifg=#BF616A
	highlight BufferInactive guibg=#3B4252 guifg=#81A1C1
	highlight BufferInactiveMod guibg=#3B4252 guifg=#8FBCBB
	highlight BufferInactiveIcon guibg=#3B4252 guifg=#81A1C1
	highlight BufferInactiveSign guibg=#3B4252 guifg=#81A1C1
	highlight BufferInactiveHINT guibg=#3B4252 guifg=#BF616A
	highlight BufferInactiveERROR guibg=#3B4252 guifg=#BF616A
]])

-- set global color variable to be used by other plugins
vim.g.custom_colors = {
	border = '#4C566A',
}