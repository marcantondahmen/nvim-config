local M = {}

-- Keymaps that are handle by WhichKey
M.whichKeyMaps = {
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
}

-- All other keymaps that are not handled by WhichKey
M.set = function()
	-- set leader key to space
	vim.g.mapleader = ' '

	local keymap = vim.keymap
	local options = { silent = true, noremap = true }

	-- clear search highlight
	keymap.set('n', '<esc>', ':noh<cr>', options)

	-- move and center
	keymap.set('n', 'n', 'nzz', options)
	keymap.set('n', 'N', 'Nzz', options)
	keymap.set('n', 'H', 'Hzz', options)
	keymap.set('n', 'L', 'Lzz', options)
	keymap.set('n', '<c-d>', '<c-d>zz', options)
	keymap.set('n', '<c-u>', '<c-u>zz', options)

	-- barbar
	keymap.set('n', '<S-TAB>', '<Cmd>BufferPrevious<CR>', options)
	keymap.set('n', '<TAB>', '<Cmd>BufferNext<CR>', options)
	keymap.set('n', '<C-,>', '<Cmd>BufferMovePrevious<CR>', options)
	keymap.set('n', '<C-.>', '<Cmd>BufferMoveNext<CR>', options)

	-- quit insert mode without esc
	keymap.set('i', 'jk', '<ESC>', options)
	keymap.set('i', 'kj', '<ESC>', options)

	-- replace selection in buffer
	keymap.set('v', 'r', 'y:%s*<c-r>"**gc<left><left><left>', { silent = true, noremap = false })

	-- replace selection in project
	keymap.set('v', '<C-r>', '<esc><cmd>lua SadVisual()<CR>', { silent = true, noremap = false })
end

return M
