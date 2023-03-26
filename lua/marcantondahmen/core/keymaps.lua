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
		t = {
			name = '+Terminal',
			p = {
				name = '+PHP',
				u = { '<cmd>lua PHPUNIT()<cr>', 'PHP Unit' },
				s = { '<cmd>lua PSALM()<cr>', 'Psalm' },
			},
		},
		q = { '<cmd>BufferClose<cr>', 'Close buffer' },
		w = { '<cmd>w<cr>', 'Save buffer' },
	},
})

-- set leader key to space
vim.g.mapleader = ' '

local keymap = vim.keymap
local options = { silent = true, noremap = true }

-- window management
keymap.set('n', '<c-k>', ':wincmd k<CR>', options)
keymap.set('n', '<c-j>', ':wincmd j<CR>', options)
keymap.set('n', '<c-h>', ':wincmd h<CR>', options)
keymap.set('n', '<c-l>', ':wincmd l<CR>', options)

-- barbar
keymap.set('n', '<S-TAB>', '<Cmd>BufferPrevious<CR>', options)
keymap.set('n', '<TAB>', '<Cmd>BufferNext<CR>', options)
keymap.set('n', '<C-,>', '<Cmd>BufferMovePrevious<CR>', options)
keymap.set('n', '<C-.>', '<Cmd>BufferMoveNext<CR>', options)

-- quit insert mode without esc
keymap.set('i', 'jk', '<ESC>', options)
keymap.set('i', 'kj', '<ESC>', options)

-- terminal
function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')