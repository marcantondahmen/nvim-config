local function reloadConfig()
	for name, _ in pairs(package.loaded) do
		if string.match(name, 'marc.*$') then
			package.loaded[name] = nil
		end
	end

	vim.cmd('luafile ~/.config/nvim/lua/marcantondahmen/init.lua')
	vim.notify('Config reloaded', nil, { timeout = 500 })
end

local function compilePlugins()
	reloadConfig()
	TreeClose()

	vim.cmd('PackerCompile')
end

local function syncPlugins()
	reloadConfig()

	vim.cmd('PackerSync')
end

local function gitCmdStr(cmd)
	local config = vim.fn.stdpath('config')

	return 'git --git-dir=' .. config .. '/.git --work-tree=' .. config .. ' ' .. cmd .. ' 2>&1'
end

local function pullCallback(id, output, name)
	vim.notify(table.concat(output, '\n'), nil, { title = 'Update', timeout = 10000 })
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
	end
end

vim.api.nvim_create_augroup('madConfigUpdate', { clear = true })

vim.api.nvim_create_autocmd('VimEnter', {
	group = 'madConfigUpdate',
	callback = function()
		vim.fn.jobstart(gitCmdStr('fetch origin --dry-run'), {
			stdout_buffered = true,
			on_stdout = fetchCallback,
		})
	end,
})

vim.api.nvim_create_autocmd('User', {
	group = 'madConfigUpdate',
	pattern = 'PackerCompileDone',
	callback = function()
		vim.schedule(reloadConfig)
	end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
	group = 'madConfigUpdate',
	pattern = { '*/nvim/lua/marcantondahmen/*.lua' },
	callback = function()
		vim.schedule(reloadConfig)
	end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
	group = 'madConfigUpdate',
	pattern = '*/nvim/lua/marcantondahmen/plugins/*.lua',
	callback = function()
		vim.schedule(compilePlugins)
	end,
})
