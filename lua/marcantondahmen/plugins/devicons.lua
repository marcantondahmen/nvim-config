local setup, icons = pcall(require, 'nvim-web-devicons')
if not setup then
	return
end

icons.setup({
	color_icons = false,
})