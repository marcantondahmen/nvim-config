local wk_setup, wk = pcall(require, 'which-key')
if not wk_setup then
	return
end

wk.register({
	gR = { '<cmd>TroubleToggle lsp_references<cr>', 'Trouble toggle references' },
	['<leader>'] = {
		a = { ':Neogen<cr>', 'Generate docblock' },
		b = {
			name = '+Buffers',
			p = { ':BufferPin<cr>', 'Pin/unpin buffer' },
			q = { ':BufferClose<cr>', 'Close current buffer' },
			c = { ':BufferCloseAllButCurrentOrPinned<cr>', 'Close all but current or pinned' },
			r = { ':BufferCloseBuffersRight<cr>', 'Close all to the right' },
		},
		e = { ':lua TreeFocusOrClose()<CR>', 'Focus or close file explorer' },
		f = {
			name = '+Telescope',
			f = { '<cmd>Telescope find_files<cr>', 'Find file' },
			s = { '<cmd>Telescope live_grep<cr>', 'Find text' },
			c = { '<cmd>Telescope grep_string<cr>', 'Find string under cursor' },
			b = { '<cmd>Telescope buffers<cr>', 'List open buffers' },
			r = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
			n = { '<cmd>Telescope notify<cr>', 'Notify history' },
			x = { '<cmd>Telescope scripts<cr>', 'Run script' },
			k = { '<cmd>Telescope keymaps<cr>', 'List keymaps' },
		},
		x = {
			name = '+Trouble',
			x = { '<cmd>Trouble<cr>', 'Focus/open diagnostics' },
			c = { '<cmd>TroubleClose<cr>', 'Close diagnostics' },
			w = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'Toggle workspace diagnostics' },
			d = { '<cmd>TroubleToggle document_diagnostics<cr>', 'Toggle document diagnostics' },
			l = { '<cmd>TroubleToggle loclist<cr>', 'Toggle loclist' },
			q = { '<cmd>TroubleToggle quickfix<cr>', 'Toggle quickfix' },
		},
		g = {
			name = '+Git',
			u = { '<cmd>lua GitUI()<cr>', 'Open Gitui' },
			l = { '<cmd>lua Tig()<cr>', 'Open Tig log' },
			p = { '<cmd>Gitsigns preview_hunk<cr>', 'Preview hunk' },
			r = { '<cmd>Gitsigns reset_hunk<cr>', 'Reset hunk' },
			h = { '<cmd>DiffviewFileHistory %<cr>', 'View history of current file' },
			d = { '<cmd>DiffviewOpen<cr>', 'Open diff view' },
			c = { '<cmd>DiffviewClose<cr>', 'Close view' },
			s = { '<cmd>Telescope git_status<cr>', 'Status' },
		},
		p = {
			name = '+Panes',
			m = { ':lua ToggleMaximize()<CR>', 'Maximize current pane' },
			v = { '<C-w>v', 'Split vertically' },
			h = { '<C-w>s', 'Split horizontally' },
			e = { '<C-w>=', 'Make panes equal width and height' },
			x = { ':close<CR>', 'Close current pane' },
		},
		r = {
			r = { '*:%s///gc<left><left><left>', 'Replace word in buffer' },
		},
		s = {
			name = '+Search/Replace',
			d = { '<cmd>lua Sad()<cr>', 'Run sad' },
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
				u = { '<cmd>lua PHPUnit()<cr>', 'PHP Unit' },
				s = { '<cmd>lua Psalm()<cr>', 'Psalm' },
			},
			d = { '<cmd>lua LazyDocker()<cr>', 'Lazydocker' },
		},
		q = { '<cmd>BufferClose<cr>', 'Close buffer' },
		w = { '<cmd>w<cr>', 'Save buffer' },
		m = { '<cmd>MarkdownPreview<cr>', 'Markdown preview' },
		n = { '<cmd>Navbuddy<cr>', 'Open Navbuddy' },
	},
})

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
