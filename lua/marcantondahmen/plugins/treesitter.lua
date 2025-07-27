return {
	'nvim-treesitter/nvim-treesitter',
	event = 'BufEnter',
	run = function()
		local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
		ts_update()
	end,
	config = function()
		local treesitterSuccess, treesitter = pcall(require, 'nvim-treesitter.configs')
		if not treesitterSuccess then
			return
		end

		local parsers = require('nvim-treesitter.parsers').get_parser_configs()
		if not parsers then
			return
		end

		parsers.automad = {
			install_info = {
				url = 'https://github.com/automadcms/tree-sitter-automad', -- local path or git repo
				files = { 'src/parser.c' }, -- note that some parsers also require src/scanner.c or src/scanner.cc
			},
		}

		parsers.blade = {
			install_info = {
				url = 'https://github.com/EmranMR/tree-sitter-blade',
				files = { 'src/parser.c' },
				branch = 'main',
			},
			filetype = 'blade',
		}

		vim.filetype.add({
			pattern = {
				['.*%.blade%.php'] = 'blade',
			},
		})

		treesitter.setup({
			-- enable syntax highlighting
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			-- enable indentation
			indent = { enable = true },
			-- enable autotagging (w/ nvim-ts-autotag plugin)
			autotag = { enable = true, enable_close_on_slash = false },
			-- ensure these language parsers are installed
			ensure_installed = {
				'automad',
				'blade',
				'json',
				'javascript',
				'typescript',
				'tsx',
				'jsdoc',
				'yaml',
				'html',
				'css',
				'markdown',
				'markdown_inline',
				'bash',
				'lua',
				'vim',
				'dockerfile',
				'gitignore',
				'regex',
				'php',
				'phpdoc',
			},
			-- auto install above language parsers
			auto_install = true,
		})

		vim.treesitter.language.register('css', 'less')
		vim.treesitter.language.register('css', 'scss')
	end,
}
