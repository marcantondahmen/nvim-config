return {
	'stevearc/conform.nvim',
	config = function()
		local success, conform = pcall(require, 'conform')
		if not success then
			return
		end

		local sqlConfig = vim.fn.stdpath('config') .. '/config/sql-formatter.config.json'

		conform.setup({
			formatters_by_ft = {
				javascript = { 'prettier' },
				typescript = { 'prettier' },
				javascriptreact = { 'prettier' },
				typescriptreact = { 'prettier' },
				svelte = { 'prettier' },
				css = { 'prettier' },
				less = { 'prettier' },
				html = { 'prettier' },
				json = { 'prettier' },
				yaml = { 'prettier' },
				markdown = { 'prettier' },
				lua = { 'stylua' },
				php = { 'php_cs_fixer' },
				sh = { 'shfmt' },
				sql = { 'postgresql', 'mysql' },
				-- Use the "_" filetype to run formatters on filetypes that don't
				-- have other formatters configured.
				['_'] = { 'trim_whitespace' },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 5000,
			},
			-- Define customized sql formatters for different languages, mysql or postgresql.
			formatters = {
				mysql = { command = 'sql-formatter', args = { '-l', 'mysql', '-c', sqlConfig } },
				postgresql = { command = 'sql-formatter', args = { '-l', 'postgresql', '-c', sqlConfig } },
			},
			-- Don't notify on errors since the sql formatter will always fail on postgresql files.
			notify_on_error = false,
		})
	end,
}
