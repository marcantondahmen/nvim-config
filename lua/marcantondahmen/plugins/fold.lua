-- use treesitter for folding
local opt = vim.opt
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldlevel = 99
opt.fdc = '0'

local function init_fold()
	vim.fn.timer_start(5, function()
		vim.cmd([[normal zx]])
	end)
end

vim.api.nvim_create_autocmd({ 'BufReadPost, FileReadPost' }, {
	pattern = { '*.*' },
	callback = init_fold,
})
