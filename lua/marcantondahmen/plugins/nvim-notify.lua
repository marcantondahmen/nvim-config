return {
	'rcarriga/nvim-notify',
	config = function()
		local notifySuccess, notify = pcall(require, 'notify')
		if not notifySuccess then
			return
		end

		notify.setup({
			stages = 'static',
			render = 'wrapped-compact',
			max_width = 80,
			min_width = 0,
		})

		vim.notify = notify
	end,
}
