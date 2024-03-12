return {
	'brenoprata10/nvim-highlight-colors',
	config = function()
		local hcSuccess, hc = pcall(require, 'nvim-highlight-colors')
		if not hcSuccess then
			return
		end

		hc.setup({
			render = 'background', -- or 'foreground', 'background' or 'first_column'
			enable_named_colors = true,
			enable_tailwind = true,
		})
	end,
}
