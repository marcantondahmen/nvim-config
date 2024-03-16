return {
	'danymat/neogen',
	event = 'VimEnter',
	requires = 'nvim-treesitter/nvim-treesitter',
	config = function()
		local neogenSuccess, neogen = pcall(require, 'neogen')
		if not neogenSuccess then
			return
		end

		neogen.setup({
			snippet_engine = 'luasnip',
		})
	end,
}
