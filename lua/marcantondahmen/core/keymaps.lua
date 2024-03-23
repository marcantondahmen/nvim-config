local keymaps = {}

-- Keymaps that are handled by WhichKey
keymaps.whichKeyMaps = {
	gR = { ':TroubleToggle lsp_references<cr>', 'Trouble toggle references' },
	['<leader>'] = {
		a = { ':Neogen<cr>', 'Generate docblock' },
		b = {
			name = '+Buffers',
			p = { ':BufferPin<cr>', 'Pin/unpin buffer' },
			q = { ':BufferClose<cr>', 'Close current buffer' },
			c = { ':BufferCloseAllButCurrentOrPinned<cr>', 'Close all but current or pinned' },
			r = { ':BufferCloseBuffersRight<cr>', 'Close all to the right' },
		},
		e = { ':lua TreeFocusOrClose()<cr>', 'Focus or close file explorer' },
		f = {
			name = '+Telescope',
			f = { ':Telescope find_files<cr>', 'Find file' },
			s = { ':Telescope live_grep<cr>', 'Find text' },
			c = { ':Telescope grep_string<cr>', 'Find string under cursor' },
			b = { ':Telescope buffers<cr>', 'List open buffers' },
			r = { ':Telescope oldfiles<cr>', 'Open Recent File' },
			n = { ':Telescope notify<cr>', 'Notify history' },
			x = { ':Telescope scripts<cr>', 'Run script' },
			k = { ':Telescope keymaps<cr>', 'List keymaps' },
		},
		i = {
			name = '+Imports',
			-- Keymaps added by lsp
		},
		x = {
			name = '+Trouble',
			x = { ':Trouble<cr>', 'Focus/open diagnostics' },
			c = { ':TroubleClose<cr>', 'Close diagnostics' },
			w = { ':TroubleToggle workspace_diagnostics<cr>', 'Toggle workspace diagnostics' },
			d = { ':TroubleToggle document_diagnostics<cr>', 'Toggle document diagnostics' },
			l = { ':TroubleToggle loclist<cr>', 'Toggle loclist' },
			q = { ':TroubleToggle quickfix<cr>', 'Toggle quickfix' },
		},
		g = {
			name = '+Git',
			u = { ':lua GitUI()<cr>', 'Open Gitui' },
			l = { ':lua Tig()<cr>', 'Open Tig log' },
			p = { ':Gitsigns preview_hunk<cr>', 'Preview hunk' },
			r = { ':Gitsigns reset_hunk<cr>', 'Reset hunk' },
			h = { ':DiffviewFileHistory %<cr>', 'View history of current file' },
			d = { ':DiffviewOpen<cr>', 'Open diff view' },
			c = { ':DiffviewClose<cr>', 'Close view' },
			s = { ':Telescope git_status<cr>', 'Status' },
		},
		p = {
			name = '+Panes',
			m = { ':lua ToggleMaximize()<cr>', 'Maximize current pane' },
			v = { '<C-w>v', 'Split vertically' },
			h = { '<C-w>s', 'Split horizontally' },
			e = { '<C-w>=', 'Make panes equal width and height' },
			x = { ':close<cr>', 'Close current pane' },
		},
		r = {
			name = '+Replace',
			s = { ':lua Sad()<cr>', 'Search and replace in project' },
			w = { ':lua SadWord()<cr>', 'Replace current word in project' },
			r = { '*:%s///gc<left><left><left>', 'Replace word in buffer' },
		},
		s = {
			name = '+Spectre',
			s = { ':lua require("spectre").open()<cr>', 'Open spectre' },
			w = { ':lua require("spectre").open_visual({select_word=true})<cr>', 'Search current word' },
		},
		t = {
			name = '+Terminal',
			p = {
				name = '+PHP',
				u = { ':lua PHPUnit()<cr>', 'PHP Unit' },
				s = { ':lua Psalm()<cr>', 'Psalm' },
			},
			d = { ':lua LazyDocker()<cr>', 'Lazydocker' },
		},
		q = { ':BufferClose<cr>', 'Close buffer' },
		w = { ':w<cr>', 'Save buffer' },
		m = { ':MarkdownPreview<cr>', 'Markdown preview' },
		n = { ':Navbuddy<cr>', 'Open Navbuddy' },
	},
	['[d'] = { vim.diagnostic.goto_prev, 'Jump to previous diagnostic' },
	[']d'] = { vim.diagnostic.goto_next, 'Jump to next diagnostic' },
	['[g'] = { ':Gitsigns prev_hunk<cr>', 'Jump to previous Git hunk' },
	[']g'] = { ':Gitsigns next_hunk<cr>', 'Jump to next Git hunk' },
}

-- All other keymaps that are not handled by WhichKey
keymaps.set = function()
	-- set leader key to space
	vim.g.mapleader = ' '

	local map = vim.keymap.set
	local options = { silent = true, noremap = true }

	-- clear search highlight
	map('n', '<esc>', ':noh<cr>', options)

	-- move and center
	map('n', 'n', 'nzz', options)
	map('n', 'N', 'Nzz', options)
	map('n', 'H', 'Hzz', options)
	map('n', 'L', 'Lzz', options)
	map('n', '<c-d>', '<c-d>zz', options)
	map('n', '<c-u>', '<c-u>zz', options)

	-- move lines up and down
	map('n', '<a-s-up>', ':m-2<cr>', options)
	map('n', '<a-s-down>', ':m+1<cr>', options)

	-- barbar
	map('n', '<S-TAB>', '<Cmd>BufferPrevious<CR>', options)
	map('n', '<TAB>', '<Cmd>BufferNext<CR>', options)
	map('n', '<C-,>', '<Cmd>BufferMovePrevious<CR>', options)
	map('n', '<C-.>', '<Cmd>BufferMoveNext<CR>', options)

	-- quit insert mode without esc
	map('i', 'jk', '<ESC>', options)
	map('i', 'kj', '<ESC>', options)

	-- replace selection in buffer
	map('v', 'r', 'y:%s*<c-r>"**gc<left><left><left>', { silent = true, noremap = false })

	-- replace selection in project
	map('v', '<C-r>', '<esc><cmd>lua SadVisual()<CR>', { silent = true, noremap = false })
end

return keymaps
