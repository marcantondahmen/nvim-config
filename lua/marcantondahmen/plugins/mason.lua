return {
	'williamboman/mason.nvim',
	config = function()
		local masonSuccess, mason = pcall(require, 'mason')
		if not masonSuccess then
			return
		end

		mason.setup({
			ui = {
				border = 'single',
			},
		})
	end,
}
