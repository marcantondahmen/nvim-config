return {
	'antosha417/nvim-lsp-file-operations',
	requires = {
		'nvim-lua/plenary.nvim',
		'nvim-tree/nvim-tree.lua',
	},
	config = function()
		local lfoSuccess, lfo = pcall(require, 'lsp-file-operations')
		if not lfoSuccess then
			return
		end

		lfo.setup({
			-- used to see debug logs in file `vim.fn.stdpath("cache") .. lsp-file-operations.log`
			debug = false,
			-- how long to wait (in milliseconds) for file rename information before cancelling
			timeout_ms = 10000,
		})
	end,
}
