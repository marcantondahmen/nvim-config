-- import nvim-tree plugin safely
local setup, nvimtree = pcall(require, 'nvim-tree')
if not setup then
	return
end

-- recommended settings from nvim-tree documentation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


-- configure nvim-tree
nvimtree.setup({
	-- change folder arrow icons
	renderer = {
		full_name = true,
		--group_empty = true,
		special_files = {},
		symlink_destination = false,
		indent_markers = {
			enable = true,
		},
		icons = {
			git_placement = 'after',
			modified_placement = 'after',
			show = {
				file = true,
				folder = true,
				folder_arrow = false,
				git = false,
				modified = true,
			},
			glyphs = {
				default = '',
				symlink = '',
				bookmark = '',
				modified = '●',
				folder = {
					arrow_closed = '',
					arrow_open = '',
					default = '',
					open = '',
					empty = '',
					empty_open = '',
					symlink = '',
					symlink_open = '',
				},
				git = {
					unstaged = '✗',
					staged = '✓',
					unmerged = '',
					renamed = '➜',
					untracked = '★',
					deleted = '',
					ignored = '◌',
				},
			},
		},
		highlight_opened_files = 'all', -- 'none' (default), 'icon', 'name' or 'all'
		highlight_modified = 'all',
		highlight_git = true,
	},
	-- disable window_picker for
	-- explorer to work well with
	-- window splits
	actions = {
		open_file = {
			window_picker = {
				enable = false,
			},
		},
	},
	filters = {
		custom = {
			'^.git$',
		},
		exclude = {},
		dotfiles = false,
		git_clean = false,
		no_buffer = false,
	},
	git = {
		enable = true,
		ignore = true,
		show_on_dirs = true,
		show_on_open_dirs = true,
		timeout = 400,
	},
	modified = {
		enable = true,
		show_on_dirs = true,
		show_on_open_dirs = true,
	},
})

-- open nvim-tree on setup

local function open_nvim_tree(data)
	-- buffer is a [No Name]
	local no_name = data.file == '' and vim.bo[data.buf].buftype == ''

	-- buffer is a directory
	local directory = vim.fn.isdirectory(data.file) == 1

	if not no_name and not directory then
		return
	end

	-- change to the directory
	if directory then
		vim.cmd.cd(data.file)
	end

	-- open the tree
	require('nvim-tree.api').tree.open()
end

vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = open_nvim_tree })
