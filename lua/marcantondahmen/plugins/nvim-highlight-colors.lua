local status, colors = pcall(require, 'nvim-highlight-colors')
if not status then
	return
end

colors.setup({
	render = 'background', -- or 'foreground', 'background' or 'first_column'
	enable_named_colors = true,
	enable_tailwind = true,
})
