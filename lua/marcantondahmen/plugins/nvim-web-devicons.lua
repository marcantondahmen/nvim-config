return {
	'nvim-tree/nvim-web-devicons',
	config = function()
		local iconsSuccess, icons = pcall(require, 'nvim-web-devicons')
		if not iconsSuccess then
			return
		end

		-- Remove colors.
		for k, v in pairs(icons.get_icons()) do
			icons.set_icon({
				[k] = { icon = v.icon, color = '#737aa2', name = v.name },
			})
		end
	end,
}
