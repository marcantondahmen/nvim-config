return {
	'nvim-tree/nvim-web-devicons',
	config = function()
		local iconsSuccess, icons = pcall(require, 'nvim-web-devicons')
		if not iconsSuccess then
			return
		end

		icons.setup({
			color_icons = false,
			default = true,
		})

		vim.api.nvim_set_hl(0, 'DevIconDefault', { link = '@none' })
	end,
}
