local setup, icons = pcall(require, 'nvim-web-devicons')
if not setup then
	return
end

icons.setup({
	color_icons = false,
})

vim.api.nvim_set_hl(0, 'DevIconDefault', { link = '@none' })
