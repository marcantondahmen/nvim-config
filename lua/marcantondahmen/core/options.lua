local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indents
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = false
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- folding
opt.foldmethod = 'indent'
opt.foldlevel = 99
opt.fdc = '0'

-- search
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = 'dark'
opt.signcolumn = 'yes'

-- backspace
opt.backspace = 'indent,eol,start'

-- clipboard
opt.clipboard:append('unnamedplus')

-- split windows
opt.splitright = true
opt.splitbelow = true

-- word char
opt.iskeyword:append('-')

-- other
opt.scrolloff = 8 -- minimal number of screen lines to keep above and below the cursor
opt.showmode = false
opt.swapfile = false
opt.fixeol = true

-- Automad filetypes
vim.filetype.add({
	filename = {
		data = 'json',
		index = 'json',
	},
})

-- reload buffer when entering or gaining focus and clear command line
vim.cmd([[
	augroup madCoreOptions
		autocmd!
		autocmd FocusGained,BufEnter * checktime
		autocmd CmdlineLeave : echo ''
	augroup end
]])
