return {
	'nvim-tree/nvim-tree.lua',
	requires = { 'romgrk/barbar.nvim' },
	config = function()
		local nvimtreeSuccess, nvimtree = pcall(require, 'nvim-tree')
		if not nvimtreeSuccess then
			return
		end

		local api = require('nvim-tree.api')

		local barbarSuccess, barbar = pcall(require, 'barbar.api')
		if not barbarSuccess then
			return
		end

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		local width = 40

		function TreeFocus()
			api.tree.find_file({ open = true, focus = true, update_root = false })
			barbar.set_offset(width + 1, '', 'BufferVisible')
			vim.g.TREEOPEN = true
		end

		function TreeClose()
			api.tree.close()
			barbar.set_offset(0)
			vim.g.TREEOPEN = false
		end

		function TreeFocusOrClose()
			if api.tree.is_tree_buf() then
				TreeClose()
			else
				TreeFocus()
			end
		end

		local function on_attach(bufnr)
			local function opts(desc)
				return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			api.config.mappings.default_on_attach(bufnr)

			-- user mappings
			vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
			vim.keymap.set('n', 'h', api.tree.toggle_hidden_filter, opts('Toggle hidden filter'))
			vim.keymap.set('n', 'i', api.tree.toggle_gitignore_filter, opts('Toggle gitignore filter'))
			vim.keymap.set('n', 'q', TreeClose, opts('Close'))

			-- remove default for H
			vim.keymap.del('n', 'H', { buffer = bufnr })
			vim.keymap.del('n', 'L', { buffer = bufnr })
		end

		-- configure nvim-tree
		nvimtree.setup({
			on_attach = on_attach,
			hijack_cursor = true,
			reload_on_bufenter = true,
			update_focused_file = {
				enable = true,
			},
			view = {
				width = width,
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
						bookmark = '󰆤',
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
			actions = {
				file_popup = {
					open_win_config = {
						col = 1,
						row = 1,
						relative = 'cursor',
						border = 'single',
						style = 'minimal',
					},
				},
				open_file = {
					-- disable window_picker for
					-- explorer to work well with
					-- window splits
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

		vim.g.TREEOPEN = false

		-- open nvim-tree on setup
		local function open_nvim_tree(data)
			if vim.fn.argc() > 0 then
				return
			end

			if vim.g.isRestoredSession then
				if vim.g.TREEOPEN == false then
					return
				end
			end

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

		vim.api.nvim_create_augroup('madNvimTree', { clear = true })
		vim.api.nvim_create_autocmd(
			{ 'BufNewFile', 'BufReadPost' },
			{ group = 'madNvimTree', callback = open_nvim_tree }
		)
		vim.api.nvim_create_autocmd({ 'FocusGained' }, {
			group = 'madNvimTree',
			callback = function()
				api.tree.git.reload()
			end,
		})
	end,
}
