return {
	'hrsh7th/nvim-cmp',
	requires = {
		'onsails/lspkind.nvim',
		'L3MON4D3/LuaSnip',
		'danymat/neogen',
	},
	config = function()
		local cmpSuccess, cmp = pcall(require, 'cmp')
		if not cmpSuccess then
			return
		end

		local luasnipSuccess, luasnip = pcall(require, 'luasnip')
		if not luasnipSuccess then
			return
		end

		local lspkindSuccess, lspkind = pcall(require, 'lspkind')
		if not lspkindSuccess then
			return
		end

		local neogenSuccess, neogen = pcall(require, 'neogen')
		if not neogenSuccess then
			return
		end

		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
		end

		-- load vs-code like snippets from plugins (e.g. friendly-snippets)
		require('luasnip/loaders/from_vscode').lazy_load()

		vim.opt.completeopt = 'menu,menuone,noselect'

		local border = cmp.config.window.bordered({
			border = 'single',
			winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
		})

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = border,
				documentation = border,
			},
			mapping = cmp.mapping.preset.insert({
				['<C-k>'] = cmp.mapping.select_prev_item(), -- previous suggestion
				['<C-j>'] = cmp.mapping.select_next_item(), -- next suggestion
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(), -- show completion suggestions
				['<C-e>'] = cmp.mapping.abort(), -- close completion window
				['<CR>'] = cmp.mapping.confirm({ select = false }),
				['<S-Down>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expandable() then
						luasnip.expand()
					elseif luasnip.jumpable(1) then
						luasnip.jump(1)
					elseif neogen.jumpable() then
						neogen.jump_next()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { 'i', 's' }),
				['<S-Up>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					elseif neogen.jumpable(true) then
						neogen.jump_prev()
					else
						fallback()
					end
				end, { 'i', 's' }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' }, -- lsp
				{ name = 'luasnip' }, -- snippets
				{ name = 'buffer' }, -- text within current buffer
				{ name = 'path' }, -- file system paths
			}),
			-- configure lspkind for vs-code like icons
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = '...',
				}),
			},
		})
	end,
}
