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

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, 'packer')
if not status then
	return
end

-- configure plugin list
local plugins = {
	-- packer can manage itself
	{
		'wbthomason/packer.nvim',
		as = 'packer.nvim', -- skip name normalization
	},

	-- lua functions that many plugins use
	{ 'nvim-lua/plenary.nvim' },
	{ 'MunifTanjim/nui.nvim' },

	-- color schemes
	-- { 'gbprod/nord.nvim' },
	{ 'folke/tokyonight.nvim' },

	-- treesitter configuration
	{
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	},

	-- dashboard
	{ 'goolord/alpha-nvim' },

	-- terminal
	{ 'akinsho/toggleterm.nvim' },

	-- auto session
	{ 'rmagatti/auto-session' },

	-- maximizes and restores current window
	{ 'szw/vim-maximizer' },

	-- tmux navigation
	{ 'alexghergh/nvim-tmux-navigation' },

	-- commenting with gc
	{ 'numToStr/Comment.nvim' },

	-- docblocks
	{
		'danymat/neogen',
		requires = 'nvim-treesitter/nvim-treesitter',
	},

	-- markdown
	{ 'preservim/vim-pencil' },
	{ 'mzlogin/vim-markdown-toc' },
	{
		'iamcco/markdown-preview.nvim',
		as = 'markdown-preview.nvim', -- skip name normalization
		run = function()
			vim.fn['mkdp#util#install']()
		end,
	},

	-- indent guides
	{ 'lukas-reineke/indent-blankline.nvim' },

	-- highlight colors
	{ 'brenoprata10/nvim-highlight-colors' },

	-- file explorer
	{ 'nvim-tree/nvim-tree.lua' },

	-- vs-code like icons
	{ 'nvim-tree/nvim-web-devicons' },

	-- notify
	{ 'rcarriga/nvim-notify' },

	-- statusline
	{ 'nvim-lualine/lualine.nvim' },

	-- buffers and tabs
	{ 'romgrk/barbar.nvim', requires = 'nvim-web-devicons' },

	-- winbar
	{
		'utilyre/barbecue.nvim',
		requires = {
			'SmiteshP/nvim-navic',
			'nvim-tree/nvim-web-devicons', -- optional dependency
		},
	},

	-- fuzzy finding w/ telescope
	{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }, -- dependency for better sorting performance
	{ 'nvim-telescope/telescope.nvim' }, -- fuzzy finder

	-- git diff
	{ 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' },

	-- search and replace
	{ 'nvim-pack/nvim-spectre' },

	-- autocompletion
	{ 'hrsh7th/nvim-cmp' }, -- completion plugin
	{ 'hrsh7th/cmp-buffer' }, -- source for text in buffer
	{ 'hrsh7th/cmp-path' }, -- source for file system paths

	-- snippets
	{ 'L3MON4D3/LuaSnip' }, -- snippet engine
	{ 'saadparwaiz1/cmp_luasnip' }, -- for autocompletion
	{ 'rafamadriz/friendly-snippets' }, -- useful snippets

	-- managing & installing lsp servers, linters & formatters
	{ 'williamboman/mason.nvim' }, -- in charge of managing lsp servers, linters & formatters
	{ 'williamboman/mason-lspconfig.nvim' }, -- bridges gap b/w mason & lspconfig
	{ 'WhoIsSethDaniel/mason-tool-installer.nvim' },

	-- formatter configs
	{ 'stevearc/conform.nvim' },

	-- configuring lsp servers
	{ 'neovim/nvim-lspconfig' }, -- easily configure language servers
	{ 'hrsh7th/cmp-nvim-lsp' }, -- for autocompletion
	{
		'glepnir/lspsaga.nvim',
		requires = {
			'nvim-tree/nvim-web-devicons',
			'nvim-treesitter/nvim-treesitter',
		},
	}, -- enhanced lsp uis
	{
		'antosha417/nvim-lsp-file-operations',
		requires = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-tree.lua',
		},
	},
	{ 'onsails/lspkind.nvim' }, -- vs-code like icons for autocompletion
	{ 'pmizio/typescript-tools.nvim' },

	-- signature help
	{ 'ray-x/lsp_signature.nvim' },

	-- navbuddy
	{
		'SmiteshP/nvim-navbuddy',
		requires = {
			'neovim/nvim-lspconfig',
			'SmiteshP/nvim-navic',
		},
	},

	-- essential plugins
	{ 'tpope/vim-surround' }, -- add, delete, change surroundings (it's awesome)
	{ 'inkarkat/vim-ReplaceWithRegister' }, -- replace with register contents using motion (gr + motion)

	-- tag renaming
	{ 'AndrewRadev/tagalong.vim' },

	-- trouble
	{
		'folke/trouble.nvim',
		requires = 'nvim-tree/nvim-web-devicons',
	},

	-- which-key
	{
		'folke/which-key.nvim',
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require('which-key').setup()
		end,
	},

	-- auto closing
	{ 'windwp/nvim-autopairs' }, -- autoclose parens, brackets, quotes, etc...
	{ 'windwp/nvim-ts-autotag', after = 'nvim-treesitter' }, -- autoclose tags

	-- git integration
	{ 'lewis6991/gitsigns.nvim' }, -- show line modifications on left hand side
}

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
local registered = {}
local normalizePlugin

-- Normalize plugin names and add commit property from lock file recursively.
-- In order to skip the name normalization, the original name has to be applied
-- using the 'as' property (see packer.nvim spec on top).
normalizePlugin = function(plugin)
	if type(plugin) == 'string' then
		plugin = { plugin }
	end

	local basename = string.gsub(plugin[1], '(.*/)(.*)', '%2')
	local name = string.gsub(string.lower(basename), '%.%w+$', '')

	name = string.gsub(name, '_', '-')

	if plugin.as then
		name = plugin.as
	else
		plugin.as = name
	end

	if registered[name] then
		return nil
	end

	plugin['commit'] = commits[name]
	registered[name] = true

	if plugin.requires then
		if type(plugin.requires) == 'string' then
			plugin.requires = { plugin.requires }
		end

		local deps = {}

		for _, dep in ipairs(plugin.requires) do
			local _dep = normalizePlugin(dep)

			table.insert(deps, _dep)
		end

		plugin.requires = deps
	end

	return plugin
end

-- add list of plugins to install
local startup = function(use)
	for _, plugin in ipairs(plugins) do
		local normalized = normalizePlugin(plugin)

		if normalized then
			use(normalized)
		end
	end

	if packer_bootstrap then
		require('packer').sync()
	end
end

return packer.startup({
	startup,
	config = {
		max_jobs = 10,
		snapshot_path = vim.fn.stdpath('config'),
		profile = {
			enable = true,
		},
	},
})
