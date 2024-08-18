local function reloadConfig()
	for name, _ in pairs(package.loaded) do
		if string.match(name, 'marcantondahmen.*') then
			package.loaded[name] = nil
			print('󰑓 Purged module cache for: ' .. name)
		end
	end

	print('󰑓 Reloading config ...')
	vim.cmd('luafile ~/.config/nvim/lua/marcantondahmen/init.lua')
end

local function syncPlugins()
	reloadConfig()

	vim.defer_fn(function()
		print('󰏗 Running PackerSync ...')
		vim.cmd('PackerSync')
	end, 500)
end

local function gitCmdStr(cmd)
	local config = vim.fn.stdpath('config')

	return 'git --git-dir=' .. config .. '/.git --work-tree=' .. config .. ' ' .. cmd .. ' 2>&1'
end

local function pullCallback(id, output, name)
	print(' Pulling changes ...')
	print(table.concat(output, '\n'))
	vim.fn.timer_start(500, syncPlugins)
end

local function fetchCallback(id, output, name)
	local status = table.concat(output, ' ')

	if status ~= '' then
		vim.fn.timer_start(500, function()
			vim.fn.jobstart(gitCmdStr('pull'), {
				stdout_buffered = true,
				on_stdout = pullCallback,
			})
		end)
	else
		print(' Config is up to date')
	end
end

vim.api.nvim_create_augroup('madConfigUpdate', { clear = true })

-- Check for new updates on start.
vim.api.nvim_create_autocmd('UIEnter', {
	group = 'madConfigUpdate',
	callback = function()
		vim.fn.jobstart(gitCmdStr('fetch origin --dry-run'), {
			stdout_buffered = true,
			on_stdout = fetchCallback,
		})
	end,
})

-- Compile plugins when plugin config files are saved.
vim.api.nvim_create_autocmd('BufWritePost', {
	group = 'madConfigUpdate',
	pattern = {
		'*/nvim/lua/marcantondahmen/*.lua',
		'*/nvim/lua/marcantondahmen/core/*.lua',
		'*/nvim/lua/marcantondahmen/plugins/*.lua',
	},
	callback = function()
		vim.schedule(syncPlugins)
	end,
})
