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
	shading_factor = -10,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = 'horizontal',
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = 'curved',
		winblend = 0,
		highlights = {
			border = 'FloatBorder',
			background = 'Normal',
		},
	},
	highlights = {
		FloatBorder = {
			guifg = vim.g.custom_colors.border,
		},
	},
})

local Terminal = toggletermTerminal.Terminal

local phpunit = Terminal:new({
	cmd = 'phpunit',
	hidden = true,
	close_on_exit = false,
	direction = 'vertical',
})

function PHPUNIT()
	phpunit:toggle()
end

local psalm = Terminal:new({
	cmd = '/usr/local/bin/psalm',
	hidden = true,
	close_on_exit = false,
	direction = 'vertical',
})

function PSALM()
	psalm:toggle()
end

local gitui = Terminal:new({
	cmd = 'gitui',
	hidden = true,
	close_on_exit = true,
	direction = 'float',
})

function GITUI()
	gitui:toggle()
end

local selfUpdate = Terminal:new({
	cmd = '(cd ~/.config/nvim/ && git pull && nvim --headless -c "autocmd User PackerComplete quitall" -c "PackerSync")',
	hidden = true,
	close_on_exit = false,
	direction = 'horizontal',
})

function SELF_UPDATE()
	selfUpdate:toggle()
end
