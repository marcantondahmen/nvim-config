local status, notify = pcall(require, 'notify')
if not status then
	return
end

notify.setup({
	stages = 'static',
	render = 'default',
	max_width = 60,
	min_width = 60,
})

vim.notify = notify
