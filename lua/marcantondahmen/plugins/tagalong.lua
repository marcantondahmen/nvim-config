return {
	'AndrewRadev/tagalong.vim',
	event = 'InsertEnter',
	config = function()
		vim.g.tagalong_additional_filetypes = { 'ts' }
	end,
}
