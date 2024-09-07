return {
	'MeanderingProgrammer/render-markdown.nvim',
	after = { 'nvim-treesitter' },
	requires = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		local success, renderMarkdown = pcall(require, 'render-markdown')
		if not success then
			return
		end

		renderMarkdown.setup()
	end,
}
