return {
	'lewis6991/gitsigns.nvim',
	event = 'BufRead',
	config = function()
		local gitSuccess, git = pcall(require, 'gitsigns')
		if not gitSuccess then
			return
		end

		git.setup({
			numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
			preview_config = {
				-- Options passed to nvim_open_win
				style = 'minimal',
				border = 'single',
				relative = 'cursor',
				row = 0,
				col = 1,
			},
		})
	end,
}
