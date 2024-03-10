vim.cmd([[
	set nocompatible
	filetype plugin on

	let g:pencil#textwidth = 74

	augroup pencil
	autocmd!
	autocmd FileType markdown call pencil#init()
	autocmd FileType text call pencil#init()
	augroup END
]])
