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
			return 15
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
	close_on_exit = false,
	direction = 'float',
})

function Tig()
	tig:toggle()
end

vim.cmd('autocmd! TermOpen term://* nnoremap <buffer><LeftRelease> <LeftRelease>i')
vim.cmd('autocmd! BufEnter term://* startinsert')
