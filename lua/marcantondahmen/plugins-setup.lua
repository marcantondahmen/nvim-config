-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and compiles plugin configs
-- when a file is saved in the plugins directory
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost ~/.config/nvim/lua/marcantondahmen/plugins/*.lua source <afile> | PackerCompile
  augroup end
]])

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
local normalizePlugin

-- Normalize plugin names and add commit property from lock file recursively.
-- In order to skip the name normalization, the original name has to be applied
-- using the 'as' property (see packer.nvim spec on top).
normalizePlugin = function(plugin)
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
			table.insert(deps, normalizePlugin(dep))
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
		local normalized = normalizePlugin(plugin)

		if normalized then
			use(normalized)
		end
	end

	if packer_bootstrap then
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
		log = { level = 'info' },
	},
})
