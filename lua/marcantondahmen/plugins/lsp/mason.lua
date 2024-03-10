-- import mason plugin safely
local masonStatus, mason = pcall(require, 'mason')
if not masonStatus then
	return
end

-- import mason-lspconfig plugin safely
local masonLspconfigStatus, masonLspconfig = pcall(require, 'mason-lspconfig')
if not masonLspconfigStatus then
	return
end

local masonToolInstallerStatus, masonToolInstaller = pcall(require, 'mason-tool-installer')
if not masonToolInstallerStatus then
	return
end

-- enable mason
mason.setup({
	ui = {
		border = 'single',
	},
})

masonLspconfig.setup({
	-- list of servers for mason to install
	ensure_installed = {
		'tsserver',
		'html',
		'cssls',
		'tailwindcss',
		'lua_ls',
		'emmet_ls',
		'intelephense',
		'psalm',
		'prismals',
	},
	-- auto-install configured servers (with lspconfig)
	automatic_installation = true, -- not the same as ensure_installed
})

masonToolInstaller.setup({
	ensure_installed = {
		'prettier',
		'stylua',
		'php-cs-fixer',
		'shfmt',
		'sql-formatter',
		'mdformat',
	},
})
