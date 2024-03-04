local status, spectre = pcall(require, 'spectre')
if not status then
	return
end

spectre.setup({
	color_devicons = false,
	live_update = true,
	is_insert_mode = true,
})

vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
	pattern = '*',
	callback = function()
		spectre.close()
	end,
})
