return {
	'rmagatti/auto-session',
	config = function()
		local success, autoSession = pcall(require, 'auto-session')
		if not success then
			return
		end

		autoSession.setup({
			auto_restore_enabled = false,
		})
	end,
}
