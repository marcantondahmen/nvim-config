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

		-- Remove colors.
		for k, v in pairs(icons.get_icons()) do
			icons.set_icon({
				[k] = { icon = v.icon, color = 'NONE', cterm_color = 1, name = v.name },
			})
		end
	end,
}
