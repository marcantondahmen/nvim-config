return {
	'ray-x/lsp_signature.nvim',
	event = 'BufRead',
	config = function()
		local lspSignatureSuccess, lspSignature = pcall(require, 'lsp_signature')
		if not lspSignatureSuccess then
			return
		end

		lspSignature.setup({
			handler_opts = {
				border = 'single', -- double, rounded, single, shadow, none, or a table of borders
			},
			hint_prefix = '',
		})
	end,
}
