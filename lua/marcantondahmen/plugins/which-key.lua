return {
	'folke/which-key.nvim',
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300

		local maps = require('marcantondahmen.core.keymaps')
		local success, wk = pcall(require, 'which-key')
		if not success then
			return
		end

		wk.setup()
		wk.register(maps.whichKeyMaps)
	end,
}
