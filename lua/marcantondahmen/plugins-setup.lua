-- auto install packer if not installed
local bootstrap = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end

	return false
end

local isBootstrapped = bootstrap() -- true if packer was just installed

-- import packer safely
local status, packer = pcall(require, 'packer')
if not status then
	return
end

-- read lock file
local readLockFile = function()
	local path = vim.fn.stdpath('config') .. '/plugins-lock.json'
	local file = io.open(path, 'r')
	local snapshot = {}

	if file then
		local contents = file:read('*a')
		local decoded = vim.json.decode(contents)

		io.close(file)

		for key, value in pairs(decoded) do
			snapshot[key] = value.commit
		end

		return snapshot
	end

	return {}
end

local commits = readLockFile()
local lockPlugin

-- Add commit property from lock file recursively.
lockPlugin = function(plugin)
	if type(plugin) == 'string' then
		plugin = { plugin }
	end

	local name = string.gsub(plugin[1], '(.*/)(.*)', '%2')

	if plugin.as then
		name = plugin.as
	end

	if commits[name] then
		plugin['commit'] = commits[name]
	end

	if plugin.requires then
		if type(plugin.requires) == 'string' then
			plugin.requires = { plugin.requires }
		end

		local deps = {}

		for _, dep in ipairs(plugin.requires) do
			table.insert(deps, lockPlugin(dep))
		end

		plugin.requires = deps
	end

	return plugin
end

-- add list of plugins to install
local startup = function(use)
	use('wbthomason/packer.nvim')

	local plugins = require('marcantondahmen.plugins')

	for _, plugin in ipairs(plugins) do
		local locked = lockPlugin(plugin)

		if locked then
			use(locked)
		end
	end

	if isBootstrapped then
		packer.sync()
	end
end

return packer.startup({
	startup,
	config = {
		ensure_dependencies = true,
		max_jobs = 10,
		snapshot_path = vim.fn.stdpath('config'),
		profile = {
			enable = true,
		},
		display = {
			open_fn = function()
				return require('packer.util').float({
					border = 'single',
					style = 'minimal',
					zindex = 2,
				})
			end,
			title = '󰏗 packer.nvim',
			prompt_border = 'single',
			header_sym = ' ',
		},
	},
})
