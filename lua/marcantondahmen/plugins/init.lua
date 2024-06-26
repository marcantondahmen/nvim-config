local plugins = {
	-- Plugins that don't need configuration.
	'nvim-lua/plenary.nvim',
	'tpope/vim-surround',
	'inkarkat/vim-ReplaceWithRegister',
	'onsails/lspkind.nvim',
	{ 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
	{ 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
	{ 'hrsh7th/cmp-path', after = 'nvim-cmp' },
	{ 'windwp/nvim-ts-autotag', after = 'nvim-treesitter' },
}

for file in io.popen('ls ' .. vim.fn.stdpath('config') .. '/lua/marcantondahmen/plugins/*.lua'):lines() do
	local basename = string.gsub(file, '(.*/)(.*)', '%2')

	if basename ~= 'init.lua' then
		local module = 'marcantondahmen.plugins.' .. string.gsub(basename, '%.lua$', '')
		local plugin = require(module)

		if type(plugin) == 'table' then
			table.insert(plugins, plugin)
		end
	end
end

return plugins
