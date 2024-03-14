return {
	'preservim/vim-pencil',
	ft = 'markdown',
	config = function()
		vim.cmd([[
			set nocompatible
			filetype plugin on

			augroup madPencil
				autocmd!
				autocmd FileType markdown call pencil#init({'wrap': 'soft'})
				autocmd FileType text call pencil#init({'wrap': 'soft'})
			augroup end
		]])
	end,
}
