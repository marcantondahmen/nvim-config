return {
	'lukas-reineke/headlines.nvim',
	after = 'nvim-treesitter',
	ft = 'markdown',
	config = function()
		local success, headlines = pcall(require, 'headlines')
		if not success then
			return
		end

		headlines.setup()
	end,
}
