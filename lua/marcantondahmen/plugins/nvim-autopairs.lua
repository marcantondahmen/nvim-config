return {
	'windwp/nvim-autopairs',
	requires = { 'hrsh7th/nvim-cmp' },
	config = function()
		local autopairsSuccess, autopairs = pcall(require, 'nvim-autopairs')
		if not autopairsSuccess then
			return
		end

		local completionSuccess, completion = pcall(require, 'nvim-autopairs.completion.cmp')
		if not completionSuccess then
			return
		end

		local cmpSuccess, cmp = pcall(require, 'cmp')
		if not cmpSuccess then
			return
		end

		autopairs.setup({
			check_ts = true, -- enable treesitter
			ts_config = {
				lua = { 'string' }, -- don't add pairs in lua string treesitter nodes
				javascript = { 'template_string' }, -- don't add pairs in javscript template_string treesitter nodes
				java = false, -- don't check treesitter on java
			},
		})

		-- make autopairs and completion work together
		cmp.event:on('confirm_done', completion.on_confirm_done())
	end,
}
