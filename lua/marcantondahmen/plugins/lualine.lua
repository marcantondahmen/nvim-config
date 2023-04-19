-- import lualine plugin safely
local status, lualine = pcall(require, 'lualine')
if not status then
	return
end

lualine.setup({
	-- https://github.com/nvim-lualine/lualine.nvim#component-options
	options = {
		theme = 'nord',
		component_separators = { left = '', right = '' },
		disabled_filetypes = {
			statusline = { 'NvimTree' },
			winbar = {},
		},
	},
	sections = {
		lualine_c = {
			{
				'filename',
				file_status = true, -- displays file status (readonly status, modified status)
				path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
			},
		},
	},
})
