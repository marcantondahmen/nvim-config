return {
	'stevearc/conform.nvim',
	config = function()
		local success, conform = pcall(require, 'conform')
		if not success then
			return
		end

		vim.env.PHP_CS_FIXER_IGNORE_ENV = 1

		conform.setup({
			formatters_by_ft = {
				javascript = { 'prettier' },
				typescript = { 'prettier' },
				javascriptreact = { 'prettier' },
				typescriptreact = { 'prettier' },
				svelte = { 'prettier' },
				css = { 'prettier' },
				less = { 'prettier' },
				scss = { 'prettier' },
				html = { 'prettier' },
				json = { 'prettier' },
				yaml = { 'prettier' },
				markdown = { 'prettier' },
				lua = { 'stylua' },
				php = { 'php_cs_fixer' },
				sh = { 'shfmt' },
				sql = { 'pg_format' },
				blade = { 'blade-formatter' },
				-- Use the "_" filetype to run formatters on filetypes that don't
				-- have other formatters configured.
				['_'] = { 'trim_whitespace' },
			},
			format_on_save = function(bufnr)
				-- Disable with a global or buffer-local variable.
				-- see https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end

				return {
					lsp_fallback = true,
					async = false,
					timeout_ms = 5000,
				}
			end,
			-- Don't notify on errors since the sql formatter will always fail on postgresql files.
			notify_on_error = false,
		})

		-- Disable/enable format on save.
		-- see https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
		vim.api.nvim_create_user_command('FormatDisable', function(args)
			if args.bang then
				-- FormatDisable! will disable formatting just for this buffer
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
		end, {
			desc = 'Disable autoformat-on-save',
			bang = true,
		})

		vim.api.nvim_create_user_command('FormatEnable', function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = 'Re-enable autoformat-on-save',
		})
	end,
}
