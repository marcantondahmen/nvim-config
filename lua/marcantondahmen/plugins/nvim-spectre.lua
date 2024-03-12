return {
	'nvim-pack/nvim-spectre',
	config = function()
		local spectreSuccess, spectre = pcall(require, 'spectre')
		if not spectreSuccess then
			return
		end

		spectre.setup({
			color_devicons = false,
			live_update = true,
			is_insert_mode = true,
		})

		vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
			pattern = '*',
			callback = function()
				spectre.close()
			end,
		})
	end,
}
