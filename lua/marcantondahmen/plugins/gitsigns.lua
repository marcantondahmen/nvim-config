-- import gitsigns plugin safely
local setup, gitsigns = pcall(require, 'gitsigns')
if not setup then
	return
end

-- configure/enable gitsigns
gitsigns.setup({
	numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
})