return {
	'mason-org/mason-lspconfig.nvim',
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
				-- Note that currently the typescript-tools.nvim package is used as a replacement fot ts_ls
				-- 'ts_ls',
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
			-- prevent duplicate attaching of server with default settings
			automatic_enable = false,
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})
	end,
}
