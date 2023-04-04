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

-- add list of plugins to install
return packer.startup(function(use)
	-- packer can manage itself
	use('wbthomason/packer.nvim')

	-- lua functions that many plugins use
	use('nvim-lua/plenary.nvim')

	-- nord colorscheme
	use('shaunsingh/nord.nvim')

	-- dashboard
	use('goolord/alpha-nvim')

	-- terminal
	use({ 'akinsho/toggleterm.nvim', tag = '*' })

	-- auto session
	use('rmagatti/auto-session')

	-- maximizes and restores current window
	use('szw/vim-maximizer')

	-- commenting with gc
	use('numToStr/Comment.nvim')

	-- editorconfig
	use('gpanders/editorconfig.nvim')

	-- indent guides
	use('lukas-reineke/indent-blankline.nvim')

	-- file explorer
	use('nvim-tree/nvim-tree.lua')

	-- vs-code like icons
	use('nvim-tree/nvim-web-devicons')

	-- notify
	use('rcarriga/nvim-notify')

	-- statusline
	use('nvim-lualine/lualine.nvim')

	-- buffers and tabs
	use({ 'romgrk/barbar.nvim', requires = 'nvim-web-devicons', tag = 'v1.5.0', lock = true })

	-- fuzzy finding w/ telescope
	use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }) -- dependency for better sorting performance
	use({ 'nvim-telescope/telescope.nvim', branch = '0.1.x' }) -- fuzzy finder

	-- git diff
	use({ 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' })

	-- search and replace
	use({ 'windwp/nvim-spectre' })

	-- autocompletion
	use('hrsh7th/nvim-cmp') -- completion plugin
	use('hrsh7th/cmp-buffer') -- source for text in buffer
	use('hrsh7th/cmp-path') -- source for file system paths

	-- snippets
	use('L3MON4D3/LuaSnip') -- snippet engine
	use('saadparwaiz1/cmp_luasnip') -- for autocompletion
	use('rafamadriz/friendly-snippets') -- useful snippets

	-- managing & installing lsp servers, linters & formatters
	use('williamboman/mason.nvim') -- in charge of managing lsp servers, linters & formatters
	use('williamboman/mason-lspconfig.nvim') -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	use('neovim/nvim-lspconfig') -- easily configure language servers
	use('hrsh7th/cmp-nvim-lsp') -- for autocompletion
	use({
		'glepnir/lspsaga.nvim',
		branch = 'main',
		requires = {
			{ 'nvim-tree/nvim-web-devicons' },
			{ 'nvim-treesitter/nvim-treesitter' },
		},
	}) -- enhanced lsp uis
	use('jose-elias-alvarez/typescript.nvim') -- additional functionality for typescript server (e.g. rename file & update imports)
	use('onsails/lspkind.nvim') -- vs-code like icons for autocompletion

	-- navbuddy
	use({
		'SmiteshP/nvim-navbuddy',
		requires = {
			'neovim/nvim-lspconfig',
			'SmiteshP/nvim-navic',
			'MunifTanjim/nui.nvim',
		},
	})

	-- essential plugins
	use('tpope/vim-surround') -- add, delete, change surroundings (it's awesome)
	use('inkarkat/vim-ReplaceWithRegister') -- replace with register contents using motion (gr + motion)

	-- tag renaming
	use('AndrewRadev/tagalong.vim')

	-- formatting & linting
	use('jose-elias-alvarez/null-ls.nvim') -- configure formatters & linters
	use('jayp0521/mason-null-ls.nvim') -- bridges gap b/w mason & null-ls

	-- trouble
	use({
		'folke/trouble.nvim',
		requires = 'nvim-tree/nvim-web-devicons',
	})

	-- which-key
	use({
		'folke/which-key.nvim',
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require('which-key').setup()
		end,
	})

	-- treesitter configuration
	use({
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	})

	-- auto closing
	use('windwp/nvim-autopairs') -- autoclose parens, brackets, quotes, etc...
	use({ 'windwp/nvim-ts-autotag', after = 'nvim-treesitter' }) -- autoclose tags

	-- git integration
	use('lewis6991/gitsigns.nvim') -- show line modifications on left hand side

	if packer_bootstrap then
		require('packer').sync()
	end
end)
