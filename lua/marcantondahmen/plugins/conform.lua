return {
	'stevearc/conform.nvim',
	config = function()
		local success, conform = pcall(require, 'conform')
		if not success then
			return
		end

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
				sql = { 'sql_formatter' },
				-- Use the "_" filetype to run formatters on filetypes that don't
				-- have other formatters configured.
				['_'] = { 'trim_whitespace' },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 5000,
			},
		})

		require('conform.formatters.sql_formatter').args = { '-l', 'mysql' }
	end,
}
