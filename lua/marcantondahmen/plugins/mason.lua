return {
	'mason-org/mason.nvim',
	config = function()
		local masonSuccess, mason = pcall(require, 'mason')
		if not masonSuccess then
			return
		end

		mason.setup({
			ui = {
				border = 'single',
				backdrop = 100,
			},
		})
	end,
}
