function ReloadConfig()
	for name, _ in pairs(package.loaded) do
		if name:match('marcantondahmen') then
			package.loaded[name] = nil
		end
	end

	vim.cmd('source ~/.config/nvim/init.lua')
	vim.notify('Saved and reloaded', nil, { title = 'Configuration' })
end

function CompilePlugins()
	ReloadConfig()
	TreeClose()

	vim.cmd('PackerCompile')
end

function SyncPlugins()
	ReloadConfig()

	vim.cmd('PackerSync')
end

local function gitCmdStr(cmd)
	local config = vim.fn.stdpath('config')

	return 'git --git-dir=' .. config .. '/.git --work-tree=' .. config .. ' ' .. cmd .. ' 2>&1'
end

local function pullCallback(id, output, name)
	vim.notify(table.concat(output, '\n'), nil, { title = 'Update' })
	vim.fn.timer_start(500, SyncPlugins)
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

local function checkForUpdates()
	vim.fn.jobstart(gitCmdStr('fetch origin --dry-run'), {
		stdout_buffered = true,
		on_stdout = fetchCallback,
	})
end

local function initAutoReload()
	vim.api.nvim_create_autocmd('User', {
		pattern = 'PackerCompileDone',
		callback = ReloadConfig,
	})

	vim.cmd([[
	  augroup packer_user_config
		autocmd!
		autocmd BufWritePost ~/.config/nvim/lua/marcantondahmen/*.lua lua ReloadConfig()
		autocmd BufWritePost ~/.config/nvim/lua/marcantondahmen/plugins/*.lua lua CompilePlugins()
		autocmd BufWritePost ~/.config/nvim/lua/marcantondahmen/core/*.lua lua ReloadConfig()
	  augroup end
	]])
end

vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = checkForUpdates })
vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = initAutoReload })
