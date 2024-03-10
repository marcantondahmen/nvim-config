vim.g.isMaximized = false

function ToggleMaximize()
	if vim.g.isMaximized then
		vim.g.isMaximized = false
		vim.cmd('set showtabline=2')
	else
		vim.g.isMaximized = true
		vim.cmd('set showtabline=0')
	end

	vim.cmd('MaximizerToggle!')
end
