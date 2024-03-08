local toggleterm_setup, toggleterm = pcall(require, 'toggleterm')
if not toggleterm_setup then
	return
end

local terminal_setup, toggletermTerminal = pcall(require, 'toggleterm.terminal')
if not terminal_setup then
	return
end

toggleterm.setup({
	size = function(term)
		if term.direction == 'horizontal' then
			return vim.o.lines * 0.5
		elseif term.direction == 'vertical' then
			return vim.o.columns * 0.4
		end
	end,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 0,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = 'float',
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = 'single',
		winblend = 0,
		highlights = {
			border = 'FloatBorder',
			background = 'Normal',
		},
	},
	highlights = {
		FloatBorder = {
			link = 'FloatBorder',
		},
	},
	on_close = function()
		vim.cmd('NvimTreeRefresh')
	end,
})

local Terminal = toggletermTerminal.Terminal

local phpunit = Terminal:new({
	cmd = 'phpunit',
	hidden = false,
	close_on_exit = false,
	direction = 'vertical',
})

function PHPUnit()
	phpunit:toggle()
end

local psalm = Terminal:new({
	cmd = 'psalm',
	hidden = false,
	close_on_exit = false,
	direction = 'vertical',
})

function Psalm()
	psalm:toggle()
end

local gitui = Terminal:new({
	cmd = 'gitui',
	hidden = false,
	close_on_exit = true,
	direction = 'float',
})

function GitUI()
	gitui:toggle()
end

local lazydocker = Terminal:new({
	cmd = 'lazydocker',
	hidden = false,
	close_on_exit = true,
	direction = 'float',
})

function LazyDocker()
	lazydocker:toggle()
end

local tig = Terminal:new({
	cmd = 'tig',
	hidden = false,
	close_on_exit = true,
	direction = 'float',
})

function Tig()
	tig:toggle()
end

local function sad(search)
	local replace = vim.fn.input('Replace: ')

	local sadTerm = Terminal:new({
		cmd = 'fd --type f | '
			.. 'sad -u 0 '
			.. '--fzf="--header-first --header=\'Replace '
			.. search
			.. ' with '
			.. replace
			.. "' --layout=reverse --preview-window='50%,border-left' --bind='ctrl-a:toggle-all'\" "
			.. '-p="bat --color=always --theme=base16 --style=plain --tabs=4" "'
			.. search
			.. '" "'
			.. replace
			.. '"',
		hidden = false,
		close_on_exit = true,
		direction = 'horizontal',
	})

	sadTerm:toggle()
end

function Sad()
	local search = vim.fn.input('Search: ')

	sad(search)
end

function SadWord()
	local word = vim.fn.expand('<cword>')

	sad(word)
end

function SadVisual()
	local orig = vim.fn.getreg('r')
	local mode = vim.fn.mode()

	if mode ~= 'v' and mode ~= 'V' then
		vim.cmd([[normal! gv]])
	end

	vim.cmd([[silent! normal! "rygv]])

	local selection = vim.fn.getreg('r')

	vim.fn.setreg('r', orig)

	sad(selection)
end

vim.cmd('autocmd! TermOpen term://* nnoremap <buffer><LeftRelease> <LeftRelease>i')
vim.cmd('autocmd! BufEnter term://* startinsert')
