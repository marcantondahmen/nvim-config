return {
	'folke/which-key.nvim',
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300

		local success, wk = pcall(require, 'which-key')
		if not success then
			return
		end

		wk.setup()
	end,
}
