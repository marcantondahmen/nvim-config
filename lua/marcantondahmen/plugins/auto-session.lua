return {
	'rmagatti/auto-session',
	config = function()
		local success, autoSession = pcall(require, 'auto-session')
		if not success then
			return
		end

		vim.g.isRestoredSession = false

		autoSession.setup({
			auto_restore_enabled = false,
			pre_restore_cmds = {
				function()
					vim.g.isRestoredSession = true
					print('Restoring session ...')
				end,
			},
		})
	end,
}
