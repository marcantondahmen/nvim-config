-- import lualine plugin safely
local status, lualine = pcall(require, 'lualine')
if not status then
	return
end

local pwd = 'string.gsub(vim.fn.getcwd(), "(.*/)(.*)", "%2")'

local nofile = {
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { '' },
		lualine_x = { '' },
		lualine_y = { pwd },
		lualine_z = { 'progress' },
	},
	filetypes = {
		'NvimTree',
		'TelescopePrompt',
		'spectre_panel',
		'toggleterm',
		'Navbuddy',
		'DiffviewFiles',
		'DiffviewFileHistory',
		'lspsagaoutline',
	},
}

local function troubleMode()
	local trouble_status, config = pcall(require, 'trouble.config')
	if not trouble_status then
		return ''
	end

	local opts = config.options

	local words = vim.split(opts.mode, '[%W]')
	for i, word in ipairs(words) do
		words[i] = word:sub(1, 1):upper() .. word:sub(2)
	end

	return table.concat(words, ' ')
end

local trouble = nofile
trouble.filetypes = { 'Trouble' }
trouble.sections.lualine_c = { troubleMode }

lualine.setup({
	-- https://github.com/nvim-lualine/lualine.nvim#component-options
	options = {
		theme = vim.g.theme_settings.LuaLineTheme,
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		globalstatus = true,
		disabled_filetypes = {
			statusline = { 'alpha' },
			winbar = {},
		},
	},
	sections = {
		lualine_c = {
			{
				'filename',
				file_status = true, -- displays file status (readonly status, modified status)
				path = 4, -- 0 = just filename, 1 = relative path, 2 = absolute path, 3: Absolute path, with tilde as the home directory, 4: Filename and parent dir, with tilde as the home directory
				symbols = {
					modified = '●', -- Text to show when the file is modified.
					readonly = '󰍶', -- Text to show when the file is non-modifiable or readonly.
					unnamed = '', -- Text to show for unnamed buffers.
					newfile = 'New', -- Text to show for newly created file before first write
				},
			},
		},
		lualine_x = { 'filetype' },
		lualine_y = { pwd },
		lualine_z = { 'progress' },
	},
	extensions = { nofile, trouble },
})
