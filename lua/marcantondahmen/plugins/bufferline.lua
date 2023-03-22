local setup, bufferline = pcall(require, 'bufferline')
if not setup then
	return
end

local highlights = require('nord').bufferline.highlights({
	italic = false,
	bold = false,
})

bufferline.setup({
	options = {
		offsets = {
			{
				filetype = 'NvimTree',
				text = ' ',
				text_align = 'left',
				separator = true,
			},
		},
		always_show_bufferline = false,
		separator_style = 'thin',
		highlights = highlights,
	},
})