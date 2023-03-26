local toggleterm_setup, toggleterm = pcall(require, 'toggleterm')
if not toggleterm_setup then
	return
end

toggleterm.setup({
	size = 20,
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
			border = 'Normal',
			background = 'Normal',
		},
	},
})

local Terminal = require('toggleterm.terminal').Terminal

local phpunit = Terminal:new({ cmd = 'phpunit', hidden = true, close_on_exit = false, direction = 'float' })

function PHPUNIT()
	phpunit:toggle()
end

local psalm = Terminal:new({ cmd = 'psalm', hidden = true, close_on_exit = false, direction = 'float' })

function PSALM()
	psalm:toggle()
end