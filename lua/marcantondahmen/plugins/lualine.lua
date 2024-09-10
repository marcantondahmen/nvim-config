return {
	'nvim-lualine/lualine.nvim',
	after = { 'trouble.nvim' },
	requires = { 'folke/trouble.nvim' },
	config = function()
		local lualineSuccess, lualine = pcall(require, 'lualine')
		if not lualineSuccess then
			return
		end

		local troubleConfigSuccess, troubleConfig = pcall(require, 'trouble.config')
		if not troubleConfigSuccess then
			return
		end

		local ssh = {
			'string.gsub(vim.fn.hostname(), "([^.]*).*", "%1")',
			icon = '',
			color = { fg = '#1f2335', bg = '#a9b1d6' },
			padding = { left = 1, right = 1 },
			cond = function()
				if vim.env.SSH_TTY then
					return true
				end

				return false
			end,
		}
		local pwd = 'string.gsub(vim.fn.getcwd(), "(.*/)(.*)", "%2")'
		local gitInfo = { { 'branch', icon = '󰘬' }, { 'diff', padding = { left = 0, right = 1 } } }
		local nofile = {
			sections = {
				lualine_a = { ssh, 'mode' },
				lualine_b = gitInfo,
				lualine_c = { '' },
				lualine_x = { 'filetype' },
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
			local opts = troubleConfig.options
			local words = vim.split(opts.mode, '[%W]')

			for i, word in ipairs(words) do
				words[i] = word:sub(1, 1):upper() .. word:sub(2)
			end

			return table.concat(words, ' ')
		end

		local trouble = {
			sections = {
				lualine_a = nofile.sections.lualine_a,
				lualine_b = nofile.sections.lualine_b,
				lualine_c = { troubleMode },
				lualine_x = nofile.sections.lualine_x,
				lualine_y = nofile.sections.lualine_y,
				lualine_z = nofile.sections.lualine_z,
			},
			filetypes = { 'Trouble' },
		}

		lualine.setup({
			-- https://github.com/nvim-lualine/lualine.nvim#component-options
			options = {
				theme = 'tokyonight',
				component_separators = { left = '', right = '' },
				section_separators = { left = '', right = '' },
				globalstatus = true,
				disabled_filetypes = {
					statusline = { 'alpha', 'packer' },
					winbar = {},
				},
			},
			sections = {
				lualine_a = { ssh, 'mode' },
				lualine_b = gitInfo,
				lualine_c = {
					{
						'filename',
						file_status = true, -- displays file status (readonly status, modified status)
						path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path, 3: Absolute path, with tilde as the home directory, 4: Filename and parent dir, with tilde as the home directory
						symbols = {
							modified = '●', -- Text to show when the file is modified.
							readonly = '󰍶', -- Text to show when the file is non-modifiable or readonly.
							unnamed = '', -- Text to show for unnamed buffers.
							newfile = 'New', -- Text to show for newly created file before first write
						},
					},
					'diagnostics',
				},
				lualine_x = { 'filetype' },
				lualine_y = { pwd },
				lualine_z = { 'progress' },
			},
			extensions = { nofile, trouble },
		})
	end,
}
