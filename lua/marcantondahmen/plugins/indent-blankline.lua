return {
	'lukas-reineke/indent-blankline.nvim',
	config = function()
		local iblSuccess, ibl = pcall(require, 'ibl')
		if not iblSuccess then
			return
		end

		ibl.setup({
			indent = { highlight = { 'LineNr' } },
			scope = { enabled = true, highlight = { 'NonText' } },
		})
	end,
}
