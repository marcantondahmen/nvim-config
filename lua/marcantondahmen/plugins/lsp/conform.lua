local status, conform = pcall(require, 'conform')
if not status then
	return
end

conform.setup({
	formatters_by_ft = {
		javascript = { 'prettierd' },
		typescript = { 'prettierd' },
		javascriptreact = { 'prettierd' },
		typescriptreact = { 'prettierd' },
		css = { 'prettierd' },
		less = { 'prettierd' },
		html = { 'prettierd' },
		json = { 'prettierd' },
		yaml = { 'prettierd' },
		markdown = { 'prettierd' },
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
		timeout_ms = 1000,
	},
})

require('conform.formatters.sql_formatter').args = { '-l', 'postgresql' }
