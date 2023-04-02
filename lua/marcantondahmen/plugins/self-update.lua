local function gitCmdStr(cmd)
	local config = vim.fn.stdpath('config')
	return 'git --git-dir=' .. config .. '/.git --work-tree=' .. config .. ' ' .. cmd .. ' 2>&1'
end

local function pullCallback(id, output, name)
	vim.notify(table.concat(output, '\n'))
	vim.fn.timer_start(500, function()
		require('packer').sync()
	end)
end

local function fetchCallback(id, output, name)
	local status = table.concat(output, ' ')

	if status == '' then
		vim.fn.timer_start(500, function()
			vim.fn.jobstart(gitCmdStr('pull'), {
				stdout_buffered = true,
				on_stdout = pullCallback,
			})
		end)
	end
end

local function checkForUpdates()
	vim.fn.jobstart(gitCmdStr('fetch origin --dry-run'), {
		stdout_buffered = true,
		on_stdout = fetchCallback,
	})
end

vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = checkForUpdates })
