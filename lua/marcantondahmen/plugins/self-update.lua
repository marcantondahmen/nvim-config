local config = vim.fn.stdpath('config')

local function git(dir, cmd)
	local handle = io.popen('git --git-dir=' .. dir .. '/.git --work-tree=' .. dir .. ' ' .. cmd .. ' 2>&1')
	local output = handle:read('*a')

	handle:close()

	return output
end

local function checkForUpdates()
	local status = git(config, 'fetch origin --dry-run')

	if status == '' then
		vim.fn.timer_start(500, function()
			local pull = git(config, 'pull')
			vim.notify(pull, 'info')
			require('packer').sync()
		end)
	end
end

vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = checkForUpdates })
