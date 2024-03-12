return {
	'rcarriga/nvim-notify',
	config = function()
		local notifySuccess, notify = pcall(require, 'notify')
		if not notifySuccess then
			return
		end

		notify.setup({
			stages = 'static',
			render = 'default',
			max_width = 60,
			min_width = 60,
		})

		vim.notify = notify
	end,
}
