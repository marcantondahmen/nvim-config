return {
	'utilyre/barbecue.nvim',
	requires = {
		'SmiteshP/nvim-navic',
		'nvim-tree/nvim-web-devicons', -- optional dependency
	},
	config = function()
		local barbecueSuccess, barbecue = pcall(require, 'barbecue')
		if not barbecueSuccess then
			return
		end

		-- https://github.com/utilyre/barbecue.nvim#-configuration
		barbecue.setup({
			exclude_filetypes = { 'toggleterm', '' },
			show_dirname = true,
			show_basename = true,
			show_modified = true,
			context_follow_icon_color = true,
			lead_custom_section = function()
				return '  '
			end,
			theme = {
				basename = { bold = false },
			},
		})
	end,
}
