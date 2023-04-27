local status, signature = pcall(require, 'lsp_signature')
if not status then
	return
end

signature.setup({
	handler_opts = {
		border = 'single', -- double, rounded, single, shadow, none, or a table of borders
	},
})
