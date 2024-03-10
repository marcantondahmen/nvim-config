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
	{ 'wbthomason/packer.nvim' },

	-- lua functions that many plugins use
	{ 'nvim-lua/plenary.nvim' },
	{ 'MunifTanjim/nui.nvim' },

	-- color schemes
	-- { 'gbprod/nord.nvim' },
	{ 'folke/tokyonight.nvim', as = 'tokyonight' },

	-- dashboard
	{ 'goolord/alpha-nvim' },

	-- terminal
	{ 'akinsho/toggleterm.nvim', as = 'toggleterm' },

	-- auto session
	{ 'rmagatti/auto-session' },

	-- maximizes and restores current window
	{ 'szw/vim-maximizer' },

	-- tmux navigation
	{ 'alexghergh/nvim-tmux-navigation' },

	-- commenting with gc
	{ 'numToStr/Comment.nvim', as = 'comment' },

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
		run = function()
			vim.fn['mkdp#util#install']()
		end,
	},

	-- indent guides
	{ 'lukas-reineke/indent-blankline.nvim', as = 'indent-blankline' },

	-- highlight colors
	{ 'brenoprata10/nvim-highlight-colors' },

	-- file explorer
	{ 'nvim-tree/nvim-tree.lua', as = 'nvim-tree' },

	-- vs-code like icons
	{ 'nvim-tree/nvim-web-devicons' },

	-- notify
	{ 'rcarriga/nvim-notify' },

	-- statusline
	{ 'nvim-lualine/lualine.nvim', as = 'lualine' },

	-- buffers and tabs
	{ 'romgrk/barbar.nvim', as = 'barbar', requires = 'nvim-web-devicons' },

	-- winbar
	{
		'utilyre/barbecue.nvim',
		as = 'barbecue',
		requires = {
			'SmiteshP/nvim-navic',
			'nvim-tree/nvim-web-devicons', -- optional dependency
		},
	},

	-- fuzzy finding w/ telescope
	{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', as = 'telescope-fzf-native' }, -- dependency for better sorting performance
	{ 'nvim-telescope/telescope.nvim', as = 'telescope' }, -- fuzzy finder

	-- git diff
	{ 'sindrets/diffview.nvim', as = 'diffview', requires = 'nvim-lua/plenary.nvim' },

	-- search and replace
	{ 'nvim-pack/nvim-spectre' },

	-- autocompletion
	{ 'hrsh7th/nvim-cmp' }, -- completion plugin
	{ 'hrsh7th/cmp-buffer' }, -- source for text in buffer
	{ 'hrsh7th/cmp-path' }, -- source for file system paths

	-- snippets
	{ 'L3MON4D3/LuaSnip', as = 'luasnip' }, -- snippet engine
	{ 'saadparwaiz1/cmp_luasnip' }, -- for autocompletion
	{ 'rafamadriz/friendly-snippets' }, -- useful snippets

	-- managing & installing lsp servers, linters & formatters
	{ 'williamboman/mason.nvim', as = 'mason' }, -- in charge of managing lsp servers, linters & formatters
	{ 'williamboman/mason-lspconfig.nvim', as = 'mason-lspconfig' }, -- bridges gap b/w mason & lspconfig
	{ 'WhoIsSethDaniel/mason-tool-installer.nvim', as = 'mason-tool-installer' },

	-- formatter configs
	{ 'stevearc/conform.nvim', as = 'conform' },

	-- configuring lsp servers
	{ 'neovim/nvim-lspconfig' }, -- easily configure language servers
	{ 'hrsh7th/cmp-nvim-lsp' }, -- for autocompletion
	{
		'glepnir/lspsaga.nvim',
		as = 'lspsaga',
		requires = {
			{ 'nvim-tree/nvim-web-devicons' },
			{ 'nvim-treesitter/nvim-treesitter' },
		},
	}, -- enhanced lsp uis
	{
		'antosha417/nvim-lsp-file-operations',
		requires = {
			'nvim-lua/plenary.nvim',
			{ 'nvim-tree/nvim-tree.lua', as = 'nvim-tree' },
		},
	},
	{ 'onsails/lspkind.nvim', as = 'lspkind' }, -- vs-code like icons for autocompletion
	{ 'pmizio/typescript-tools.nvim', as = 'typescript-tools' },

	-- signature help
	{ 'ray-x/lsp_signature.nvim', as = 'lsp-signature' },

	-- navbuddy
	{ 'SmiteshP/nvim-navic' },
	{
		'SmiteshP/nvim-navbuddy',
		requires = {
			'neovim/nvim-lspconfig',
		},
	},

	-- essential plugins
	{ 'tpope/vim-surround' }, -- add, delete, change surroundings (it's awesome)
	{ 'inkarkat/vim-ReplaceWithRegister' }, -- replace with register contents using motion (gr + motion)

	-- tag renaming
	{ 'AndrewRadev/tagalong.vim', as = 'tagalong' },

	-- trouble
	{
		'folke/trouble.nvim',
		as = 'trouble',
		requires = 'nvim-tree/nvim-web-devicons',
	},

	-- which-key
	{
		'folke/which-key.nvim',
		as = 'which-key',
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require('which-key').setup()
		end,
	},

	-- treesitter configuration
	{
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	},

	-- auto closing
	{ 'windwp/nvim-autopairs' }, -- autoclose parens, brackets, quotes, etc...
	{ 'windwp/nvim-ts-autotag', after = 'nvim-treesitter' }, -- autoclose tags

	-- git integration
	{ 'lewis6991/gitsigns.nvim', as = 'gitsigns' }, -- show line modifications on left hand side
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

-- add list of plugins to install
local startup = function(use)
	local lock = readLockFile()

	for _, plugin in ipairs(plugins) do
		local name = string.gsub(plugin[1], '(.*/)(.*)', '%2')

		if plugin.as then
			name = plugin.as
		end

		plugin['commit'] = lock[name]
		use(plugin)
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
