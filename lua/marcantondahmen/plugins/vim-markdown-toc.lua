return {
	'mzlogin/vim-markdown-toc',
	ft = 'markdown',
	config = function()
		vim.cmd([[
			let g:vmt_list_item_char = '-'
			let g:vmt_min_level = 2
			let g:vmt_list_indent_text = '  '
		]])
	end,
}
