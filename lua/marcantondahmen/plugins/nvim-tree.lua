-- import nvim-tree plugin safely
local tree_status, nvimtree = pcall(require, 'nvim-tree')
if not tree_status then
	return
end

local conf_status, config = pcall(require, 'nvim-tree.config')
if not conf_status then
	return
end

local api_status, api = pcall(require, 'nvim-tree.api')
if not api_status then
	return
end

local bufferline_status, bufferline = pcall(require, 'bufferline.api')
if not bufferline_status then
	return
end

-- recommended settings from nvim-tree documentation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local tree_cb = config.nvim_tree_callback
local width = 40

function TreeFocus()
	bufferline.set_offset(width + 1, 'Files', 'BufferVisible')
	api.tree.find_file({ open = true, focus = true, update_root = false })
end

function TreeClose()
	api.tree.close()
	print('test')
	bufferline.set_offset(0)
end

local function on_attach(bufnr)
	local function opts(desc)
		return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	api.config.mappings.default_on_attach(bufnr)

	-- user mappings
	vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
	vim.keymap.set('n', 'q', TreeClose, opts('Close'))
end

-- configure nvim-tree
nvimtree.setup({
	on_attach = on_attach,
	hijack_cursor = true,
	view = {
		width = width,
		mappings = {
			custom_only = false,
			list = {
				{ key = 'v', cb = tree_cb('vsplit') },
				{ key = 's', cb = tree_cb('split') },
			},
		},
	},
	renderer = {
		full_name = false,
		group_empty = false,
		special_files = {},
		symlink_destination = false,
		indent_markers = {
			enable = true,
		},
		icons = {
			webdev_colors = false,
			git_placement = 'after',
			modified_placement = 'after',
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
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
		highlight_opened_files = 'none', -- 'none' (default), 'icon', 'name' or 'all'
		highlight_modified = 'all',
		highlight_git = true,
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		show_on_open_dirs = true,
		debounce_delay = 50,
		severity = {
			min = vim.diagnostic.severity.HINT,
			max = vim.diagnostic.severity.ERROR,
		},
		icons = {
			hint = '',
			info = '',
			warning = '',
			error = '',
		},
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

	if no_name or directory then
		return
	end

	-- Found here:
	-- https://github.com/nvim-tree/nvim-tree.lua/discussions/1517#discussion-4317419
	if vim.fn.expand('%:p') ~= '' then
		vim.api.nvim_del_autocmd(data.id)

		vim.schedule(function()
			TreeFocus()
			vim.cmd('wincmd p')
		end)
	end
end

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufReadPost' }, { callback = open_nvim_tree })
