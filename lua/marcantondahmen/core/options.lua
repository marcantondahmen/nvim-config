vim.api.nvim_exec('language en_US', true)

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

vim.cmd([[
	augroup cmdline
		autocmd!
		autocmd CmdlineLeave : echo ''
	augroup end
]])
