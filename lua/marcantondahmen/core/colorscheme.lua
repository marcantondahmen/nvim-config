local status, nord = pcall(require, 'nord')
if not status then
	return
end

nord.setup({
	transparent = false, -- Enable this to disable setting the background color
	terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
	diff = { mode = 'fg' }, -- enables/disables colorful backgrounds when used in diff mode. values : [bg|fg]
	borders = true, -- Enable the border between verticaly split windows visible
	errors = { mode = 'fg' }, -- Display mode for errors and diagnostics
	-- values : [bg|fg|none]
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value for `:help nvim_set_hl`
		comments = { italic = false },
		keywords = {},
		functions = {},
		variables = {},

		-- To customize lualine/bufferline
		bufferline = {
			current = {},
			modified = { italic = true },
		},
	},

	-- colorblind mode
	-- see https://github.com/EdenEast/nightfox.nvim#colorblind
	-- simulation mode has not been implemented yet.
	colorblind = {
		enable = false,
		preserve_background = false,
		severity = {
			protan = 0.0,
			deutan = 0.0,
			tritan = 0.0,
		},
	},

	-- You can override specific highlights to use other groups or a hex color
	-- function will be called with all highlights and the colorScheme table
	on_highlights = function(highlights, colors) end,
})

-- run ":so $VIMRUNTIME/syntax/hitest.vim" to see all highlight groups
vim.cmd([[
	colorscheme nord

	highlight NormalMode guifg=#4C566A guibg=#D8DEE9
	highlight ReplaceMode guifg=#4C566A guibg=#D8DEE9
	highlight FloatBorder guifg=#4C566A
	highlight DefinitionBorder guifg=#4C566A

	highlight NvimTreeNormal guifg=#81A1C1 
	highlight NvimTreeNormalNC guifg=#81A1C1 
	highlight NvimTreeSpecialFile guifg=#81A1C1 
	highlight NvimTreeImageFile guifg=#81A1C1 
	highlight NvimTreeFolderName guifg=#81A1C1 
	highlight NvimTreeOpenFolderName guifg=#81A1C1 
	highlight NvimTreeOpenedFolderName guifg=#81A1C1 
	highlight NvimTreeEmptyFolderName guifg=#81A1C1 
	highlight NvimTreeStatusLineNC guifg=#4C566A
	highlight NvimTreeIndentMarker guifg=#4C566A
	highlight NvimTreeRootFolder guifg=#81A1C1

	highlight TelescopePromptBorder guifg=#4C566A
	highlight TelescopeResultsBorder guifg=#4C566A
	highlight TelescopePreviewBorder guifg=#4C566A
	highlight TelescopeNormal guifg=#81A1C1
	highlight TelescopeTitle guifg=#4C566A
	highlight TelescopeSelection guibg=#3B4252 guifg=#D8DEE9

	highlight LspFloatWinBorder guifg=#4C566A
	highlight LspSagaDefPreviewBorder guifg=#4C566A
	highlight LspSagaCodeActionBorder guifg=#4C566A
	highlight LspSagaLspFinderBorder guifg=#4C566A
	highlight LspSagaHoverBorder guifg=#4C566A
	highlight LspSagaRenameBorder guifg=#4C566A
	highlight LspSagaDiagnosticBorder guifg=#4C566A
	highlight LSOutlinePreviewBorder guifg=#4C566A

	highlight BufferCurrent guibg=#3B4252 guifg=#D8DEE9
	highlight BufferCurrentMod guibg=#3B4252 guifg=#D8DEE9
	highlight BufferCurrentIcon guibg=#3B4252 guifg=#D8DEE9
	highlight BufferCurrentSign guibg=#3B4252 guifg=#D8DEE9
	highlight BufferCurrentHINT guibg=#3B4252 guifg=#81A1C1
	highlight BufferCurrentERROR guibg=#3B4252 guifg=#BF616A
	highlight BufferVisible guibg=#2E3440 guifg=#616E88 
	highlight BufferVisibleMod guibg=#2E3440 guifg=#616E88
	highlight BufferVisibleIcon guibg=#2E3440 guifg=#616E88
	highlight BufferVisibleSign guibg=#2E3440 guifg=#616E88
	highlight BufferVisibleHINT guibg=#2E3440 guifg=#81A1C1
	highlight BufferVisibleERROR guibg=#2E3440 guifg=#BF616A
	highlight BufferInactive guibg=#2E3440 guifg=#616E88 
	highlight BufferInactiveMod guibg=#2E3440 guifg=#616E88  
	highlight BufferInactiveIcon guibg=#2E3440 guifg=#616E88 
	highlight BufferInactiveSign guibg=#2E3440 guifg=#616E88 
	highlight BufferInactiveHINT guibg=#2E3440 guifg=#81A1C1
	highlight BufferInactiveERROR guibg=#2E3440 guifg=#BF616A

	highlight QuickFixLine guibg=#D8DEE9 guifg=#4C566A
	highlight Folded guibg=#2E3440 guifg=#616E88 gui=italic
]])

-- set global color variable to be used by other plugins
vim.g.custom_colors = {
	border = '#4C566A',
}
