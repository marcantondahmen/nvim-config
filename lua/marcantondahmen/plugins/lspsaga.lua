return {
	'glepnir/lspsaga.nvim',
	requires = {
		'nvim-tree/nvim-web-devicons',
		'nvim-treesitter/nvim-treesitter',
	},
	config = function()
		local lspsagaSuccess, lspsaga = pcall(require, 'lspsaga')
		if not lspsagaSuccess then
			return
		end

		lspsaga.setup({
			-- keybinds for navigation in lspsaga window
			scroll_preview = { scroll_down = '<C-f>', scroll_up = '<C-b>' },
			-- use enter to open file with definition preview
			definition = {
				keys = {
					edit = '<CR>',
				},
			},
			symbol_in_winbar = {
				enable = false,
			},
			ui = {
				border = 'single',
				code_action = '󰌵',
			},
		})

		vim.cmd('highlight SagaVirtLine guifg=#3b4261')
	end,
}
