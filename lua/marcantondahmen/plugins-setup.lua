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

	-- packer can manage itself
	use({ 'wbthomason/packer.nvim', commit = lock['packer.nvim'] })

	-- lua functions that many plugins use
	use({ 'nvim-lua/plenary.nvim', commit = lock['plenary.nvim'] })

	-- color schemes
	use({ 'gbprod/nord.nvim', commit = lock['nord.nvim'] })
	use({ 'folke/tokyonight.nvim', commit = lock['tokyonight.nvim'] })

	-- dashboard
	use({ 'goolord/alpha-nvim', commit = lock['alpha-nvim'] })

	-- terminal
	use({ 'akinsho/toggleterm.nvim', commit = lock['toggleterm.nvim'] })

	-- auto session
	use({ 'rmagatti/auto-session', commit = lock['auto-session'] })

	-- maximizes and restores current window
	use({ 'szw/vim-maximizer', commit = lock['vim-maximizer'] })

	-- tmux navigation
	use({ 'alexghergh/nvim-tmux-navigation', commit = lock['nvim-tmux-navigation'] })

	-- commenting with gc
	use({ 'numToStr/Comment.nvim', commit = lock['Comment.nvim'] })

	-- docblocks
	use({
		'danymat/neogen',
		requires = 'nvim-treesitter/nvim-treesitter',
		commit = lock['neogen'],
	})

	-- markdown preview
	use({
		'iamcco/markdown-preview.nvim',
		run = function()
			vim.fn['mkdp#util#install']()
		end,
		commit = lock['markdown-preview.nvim'],
	})

	-- indent guides
	use({ 'lukas-reineke/indent-blankline.nvim', commit = lock['indent-blankline.nvim'] })

	-- highlight colors
	use({ 'brenoprata10/nvim-highlight-colors', commit = lock['nvim-highlight-colors'] })

	-- file explorer
	use({ 'nvim-tree/nvim-tree.lua', commit = lock['nvim-tree.lua'] })

	-- vs-code like icons
	use({ 'nvim-tree/nvim-web-devicons', commit = lock['nvim-web-devicons'] })

	-- notify
	use({ 'rcarriga/nvim-notify', commit = lock['nvim-notify'] })

	-- statusline
	use({ 'nvim-lualine/lualine.nvim', commit = lock['lualine.nvim'] })

	-- buffers and tabs
	use({ 'romgrk/barbar.nvim', requires = 'nvim-web-devicons', commit = lock['barbar.nvim'] })

	-- fuzzy finding w/ telescope
	use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', commit = lock['telescope-fzf-native.nvim'] }) -- dependency for better sorting performance
	use({ 'nvim-telescope/telescope.nvim', branch = '0.1.x', commit = lock['telescope.nvim'] }) -- fuzzy finder

	-- git diff
	use({ 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim', commit = lock['diffview.nvim'] })

	-- search and replace
	use({ 'windwp/nvim-spectre', commit = lock['nvim-spectre'] })

	-- autocompletion
	use({ 'hrsh7th/nvim-cmp', commit = lock['nvim-cmp'] }) -- completion plugin
	use({ 'hrsh7th/cmp-buffer', commit = lock['cmp-buffer'] }) -- source for text in buffer
	use({ 'hrsh7th/cmp-path', commit = lock['cmp-path'] }) -- source for file system paths

	-- snippets
	use({ 'L3MON4D3/LuaSnip', commit = lock['LuaSnip'] }) -- snippet engine
	use({ 'saadparwaiz1/cmp_luasnip', commit = lock['cmp_luasnip'] }) -- for autocompletion
	use({ 'rafamadriz/friendly-snippets', commit = lock['friendly-snippets'] }) -- useful snippets

	-- managing & installing lsp servers, linters & formatters
	use({ 'williamboman/mason.nvim', commit = lock['mason.nvim'] }) -- in charge of managing lsp servers, linters & formatters
	use({ 'williamboman/mason-lspconfig.nvim', commit = lock['mason-lspconfig.nvim'] }) -- bridges gap b/w mason & lspconfig
	use({ 'WhoIsSethDaniel/mason-tool-installer.nvim', commit = lock['mason-tool-installer.nvim'] })

	-- formatter configs
	use({ 'stevearc/conform.nvim', commit = lock['conform.nvim'] })

	-- configuring lsp servers
	use({ 'neovim/nvim-lspconfig', commit = lock['nvim-lspconfig'] }) -- easily configure language servers
	use({ 'hrsh7th/cmp-nvim-lsp', commit = lock['cmp-nvim-lsp'] }) -- for autocompletion
	use({
		'glepnir/lspsaga.nvim',
		branch = 'main',
		requires = {
			{ 'nvim-tree/nvim-web-devicons' },
			{ 'nvim-treesitter/nvim-treesitter' },
		},
		commit = lock['lspsaga.nvim'],
	}) -- enhanced lsp uis
	use({ 'jose-elias-alvarez/typescript.nvim', commit = lock['typescript.nvim'] }) -- additional functionality for typescript server (e.g. rename file & update imports)
	use({ 'onsails/lspkind.nvim', commit = lock['lspkind.nvim'] }) -- vs-code like icons for autocompletion

	-- signature help
	use({ 'ray-x/lsp_signature.nvim', commit = lock['lsp_signature.nvim'] })

	-- navbuddy
	use({
		'SmiteshP/nvim-navbuddy',
		requires = {
			'neovim/nvim-lspconfig',
			'SmiteshP/nvim-navic',
			'MunifTanjim/nui.nvim',
		},
		commit = lock['nvim-navbuddy'],
	})

	-- essential plugins
	use({ 'tpope/vim-surround', commit = lock['vim-surround'] }) -- add, delete, change surroundings (it's awesome)
	use({ 'inkarkat/vim-ReplaceWithRegister', commit = lock['vim-ReplaceWithRegister'] }) -- replace with register contents using motion (gr + motion)

	-- tag renaming
	use({ 'AndrewRadev/tagalong.vim', commit = lock['tagalong.vim'] })

	-- trouble
	use({
		'folke/trouble.nvim',
		requires = 'nvim-tree/nvim-web-devicons',
		commit = lock['trouble.nvim'],
	})

	-- which-key
	use({
		'folke/which-key.nvim',
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require('which-key').setup()
		end,
		commit = lock['which-key.nvim'],
	})

	-- treesitter configuration
	use({
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
		commit = lock['nvim-treesitter'],
	})

	-- auto closing
	use({ 'windwp/nvim-autopairs', commit = lock['nvim-autopairs'] }) -- autoclose parens, brackets, quotes, etc...
	use({ 'windwp/nvim-ts-autotag', after = 'nvim-treesitter', commit = lock['nvim-ts-autotag'] }) -- autoclose tags

	-- git integration
	use({ 'lewis6991/gitsigns.nvim', commit = lock['gitsigns.nvim'] }) -- show line modifications on left hand side

	if packer_bootstrap then
		require('packer').sync()
	end
end

return packer.startup({
	startup,
	config = {
		max_jobs = 10,
		snapshot_path = vim.fn.stdpath('config'),
	},
})
