local diff_status, diff = pcall(require, 'diffview')
if not diff_status then
	return
end

local keymaps = {
	['q'] = '<cmd>DiffviewClose<cr>',
	['<esc>'] = '<cmd>DiffviewClose<cr>',
}

diff.setup({
	file_panel = {
		listing_style = 'tree', -- One of 'list' or 'tree'
		tree_options = { -- Only applies when listing_style is 'tree'
			flatten_dirs = true, -- Flatten dirs that only contain one single dir
			folder_statuses = 'only_folded', -- One of 'never', 'only_folded' or 'always'.
		},
		win_config = { -- See ':h diffview-config-win_config'
			position = 'left',
			width = 30,
			win_opts = {},
		},
	},
	hooks = {
		view_opened = function(view)
			vim.cmd('set showtabline=0')
		end,
		view_closed = function(view)
			vim.cmd('set showtabline=2')
		end,
	},
	keymaps = {
		view = keymaps,
		file_panel = keymaps,
		file_history_panel = keymaps,
	},
})
