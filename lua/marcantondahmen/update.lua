local function compilePlugins()
	vim.fn.jobstart("nvim --headless -c 'autocmd User PackerCompileDone quitall' -c 'PackerCompile'", {
		stdout_buffered = true,
		on_stdout = function()
			vim.notify('Compiled plugins!', nil, { title = 'Packer', timeout = 750 })
		end,
	})
end

local function reloadPluginConfigs()
	for name, _ in pairs(package.loaded) do
		if string.match(name, 'marc.*plugins') then
			package.loaded[name] = nil
			print('󰑓 Purged module cache for: ' .. name)
		end
	end

	print('󰑓 Reloading plugin setup ...')
	vim.cmd('luafile ~/.config/nvim/lua/marcantondahmen/plugins-setup.lua')
end

local function syncPlugins()
	reloadPluginConfigs()

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

-- Notify after plugins have been synced.
vim.api.nvim_create_autocmd('User', {
	group = 'madConfigUpdate',
	pattern = 'PackerComplete',
	callback = function()
		vim.notify('Please restart Neovim!', nil, { title = 'Update', timeout = false })
	end,
})

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
	pattern = '*/nvim/lua/marcantondahmen/plugins/*.lua',
	callback = function()
		vim.schedule(compilePlugins)
	end,
})
