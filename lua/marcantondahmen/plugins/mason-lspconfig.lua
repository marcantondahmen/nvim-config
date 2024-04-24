return {
	'williamboman/mason-lspconfig.nvim',
	after = { 'mason.nvim' },
	config = function()
		local masonLspconfigSuccess, masonLspconfig = pcall(require, 'mason-lspconfig')
		if not masonLspconfigSuccess then
			return
		end

		masonLspconfig.setup({
			-- list of servers for mason to install
			-- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
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
				'svelte',
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})
	end,
}
