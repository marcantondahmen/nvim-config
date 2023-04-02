-- use treesitter for folding
local opt = vim.opt
opt.foldmethod = 'indent'
opt.fdc = '0'

local function init_fold()
	vim.fn.timer_start(5, function()
		vim.cmd([[normal zR]])
	end)
end

vim.api.nvim_create_autocmd({ 'BufReadPost, FileReadPost' }, {
	pattern = { '*.*' },
	callback = init_fold,
})
