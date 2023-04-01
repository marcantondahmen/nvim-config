-- use treesitter for folding
local opt = vim.opt
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.fdc = '0'

local function init_fold()
	vim.fn.timer_start(20, function()
		vim.cmd([[normal zx zR]])
	end)
end

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
	pattern = { '*' },
	callback = init_fold,
})
