-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status then
	return
end

local parsers = require('nvim-treesitter.parsers').get_parser_configs()
parsers.automad = {
	install_info = {
		url = 'https://github.com/automadcms/tree-sitter-automad', -- local path or git repo
		files = { 'src/parser.c' }, -- note that some parsers also require src/scanner.c or src/scanner.cc
	},
}

-- configure treesitter
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
