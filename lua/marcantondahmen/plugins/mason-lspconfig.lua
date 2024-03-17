return {
	'williamboman/mason-lspconfig.nvim',
	config = function()
		local masonLspconfigSuccess, masonLspconfig = pcall(require, 'mason-lspconfig')
		if not masonLspconfigSuccess then
			return
		end

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
	end,
}
