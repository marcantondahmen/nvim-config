return {
	'williamboman/mason.nvim',
	requires = {
		'williamboman/mason-lspconfig.nvim', -- bridges gap b/w mason & lspconfig
		'WhoIsSethDaniel/mason-tool-installer.nvim',
	},
	config = function()
		local masonSuccess, mason = pcall(require,'mason')
		if not masonSuccess then
			return
		end

		local masonLspconfigSuccess, masonLspconfig = pcall(require,'mason-lspconfig')
		if not masonLspconfigSuccess then
			return
		end

		local masonToolInstallerSuccess, masonToolInstaller = pcall(require,'mason-tool-installer')
		if not masonToolInstallerSuccess then
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
	end,
}
