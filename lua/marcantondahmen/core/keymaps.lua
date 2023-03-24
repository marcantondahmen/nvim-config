local wk_setup, wk = pcall(require, 'which-key')
if not wk_setup then
	return
end

wk.register({
	gR = { '<cmd>TroubleToggle lsp_references<cr>', 'Trouble toggle references' },
	['<leader>'] = {
		e = { ':NvimTreeToggle<CR>', 'Toggle file explorer' },
		f = {
			name = '+Telescope',
			f = { '<cmd>Telescope find_files<cr>', 'Find file' },
			s = { '<cmd>Telescope live_grep<cr>', 'Find text' },
			c = { '<cmd>Telescope grep_string<cr>', 'Find string under cursor' },
			b = { '<cmd>Telescope buffers<cr>', 'List open buffers' },
			r = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
		},
		x = {
			name = '+Trouble',
			x = { '<cmd>TroubleToggle<cr>', 'Toggle diagnostics' },
			w = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'Toggle workspace diagnostics' },
			d = { '<cmd>TroubleToggle document_diagnostics<cr>', 'Toggle document diagnostics' },
			l = { '<cmd>TroubleToggle loclist<cr>', 'Toggle loclist' },
			q = { '<cmd>TroubleToggle quickfix<cr>', 'Toggle quickfix' },
		},
		g = {
			name = '+Git',
			u = { '<cmd>Gitui<cr>', 'Open Gitui' },
			p = { '<cmd>Gitsigns preview_hunk<cr>', 'Preview hunk' },
			r = { '<cmd>Gitsigns reset_hunk<cr>', 'Reset hunk' },
			h = { '<cmd>DiffviewFileHistory %<cr>', 'View history of current file' },
			d = { '<cmd>DiffviewOpen<cr>', 'Open diff view' },
			c = { '<cmd>DiffviewClose<cr>', 'Close view' },
		},
		p = {
			name = '+Panes',
			m = { ':MaximizerToggle<CR>', 'Maximize current pane' },
			v = { '<C-w>v', 'Split vertically' },
			h = { '<C-w>s', 'Split horizontally' },
			e = { '<C-w>=', 'Make panes equal width and height' },
			x = { ':close<CR>', 'Close current pane' },
		},
		s = {
			name = '+Spectre',
			s = { '<cmd>lua require("spectre").open()<CR>', 'Open spectre' },
			w = { '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', 'Search current word' },
			f = {
				'<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
				'Search word in current file',
			},
		},
	},
})

-- set leader key to space
vim.g.mapleader = ' '

local keymap = vim.keymap

-- window management
keymap.set('n', '<c-k>', ':wincmd k<CR>', { silent = true, noremap = true })
keymap.set('n', '<c-j>', ':wincmd j<CR>', { silent = true, noremap = true })
keymap.set('n', '<c-h>', ':wincmd h<CR>', { silent = true, noremap = true })
keymap.set('n', '<c-l>', ':wincmd l<CR>', { silent = true, noremap = true })

-- barbar
keymap.set('n', '<A-,>', '<Cmd>BufferPrevious<CR>', { silent = true, noremap = true })
keymap.set('n', '<A-.>', '<Cmd>BufferNext<CR>', { silent = true, noremap = true })
keymap.set('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', { silent = true, noremap = true })
keymap.set('n', '<A->>', '<Cmd>BufferMoveNext<CR>', { silent = true, noremap = true })