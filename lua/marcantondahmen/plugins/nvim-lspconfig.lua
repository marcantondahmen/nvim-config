return {
	'neovim/nvim-lspconfig',
	event = 'BufRead',
	requires = {
		'hrsh7th/cmp-nvim-lsp', -- for autocompletion
		'onsails/lspkind.nvim', -- vs-code like icons for autocompletion
		'pmizio/typescript-tools.nvim',
		'folke/which-key.nvim',
	},
	after = { 'nvim-cmp', 'cmp-nvim-lsp', 'typescript-tools.nvim', 'which-key.nvim' },
	config = function()
		local lspconfigSuccess, lspconfig = pcall(require, 'lspconfig')
		if not lspconfigSuccess then
			return
		end

		local cmpNvimLspSuccess, cmpNvimLsp = pcall(require, 'cmp_nvim_lsp')
		if not cmpNvimLspSuccess then
			return
		end

		local tsToolsSuccess, tsTools = pcall(require, 'typescript-tools')
		if not tsToolsSuccess then
			return
		end

		local wkSuccess, wk = pcall(require, 'which-key')
		if not wkSuccess then
			return
		end

		local keymaps = function()
			wk.register({
				['<leader>'] = {
					c = { '<cmd>Lspsaga code_action<CR>', 'Code actions' },
					rn = { '<cmd>Lspsaga rename<CR>', 'Smart rename' },
					D = { '<cmd>Lspsaga show_line_diagnostics<CR>', 'Show line diagnostics' },
					d = { '<cmd>Lspsaga show_cursor_diagnostics<CR>', 'Show cursor diagnostics' },
					o = { '<cmd>Lspsaga outline<CR>', 'Toggle outline' },
				},
				g = {
					name = 'Code navigation',
					f = { '<cmd>Lspsaga finder<CR>', 'Show definition, references' },
					D = { '<Cmd>lua vim.lsp.buf.declaration()<CR>', 'See definition and make edits in window' },
					d = { '<cmd>Lspsaga peek_definition<CR>', 'Peek definition' },
					i = { '<cmd>lua vim.lsp.buf.implementation()<CR>', 'Go to implementation' },
					k = { '<cmd>Lspsaga hover_doc<CR>', 'Show documentation for what is under cursor' },
				},
			})
		end

		-- enable keybinds only for when lsp server available
		local on_attach = function(client, bufnr)
			keymaps()
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmpNvimLsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
		for type, icon in pairs(signs) do
			local hl = 'DiagnosticSign' .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
		end

		-- configure html server
		lspconfig['html'].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure typescript server with plugin
		tsTools.setup({
			capabilities = capabilities,
			on_attach = function()
				keymaps()

				wk.register({
					['<leader>'] = {
						name = 'Imports',
						ir = { ':TSToolsRemoveUnusedImports <CR>', 'Remove unused imports' },
						ia = { ':TSToolsAddMissingImports<CR>', 'Add missing imports' },
					},
				})
			end,
		})

		-- configure css server
		lspconfig['cssls'].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				css = { validate = true, lint = {
					unknownAtRules = 'ignore',
				} },
				scss = { validate = true, lint = {
					unknownAtRules = 'ignore',
				} },
				less = { validate = true, lint = {
					unknownAtRules = 'ignore',
				} },
			},
		})

		-- configure tailwindcss server
		lspconfig['tailwindcss'].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure PHP servers
		lspconfig['intelephense'].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				intelephense = {
					diagnostics = {
						undefinedConstants = false,
						undefinedTypes = false,
						typeErrors = false,
						unusedSymbols = false,
					},
				},
			},
			init_options = {
				globalStoragePath = os.getenv('HOME') .. '/.local/share/intelephense',
			},
		})

		lspconfig['psalm'].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure emmet language server
		lspconfig['emmet_ls'].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'svelte' },
		})

		-- configure lua server (with special settings)
		lspconfig['lua_ls'].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				-- custom settings for lua
				Lua = {
					-- make the language server recognize 'vim' global
					diagnostics = {
						globals = { 'vim' },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand('$VIMRUNTIME/lua')] = true,
							[vim.fn.stdpath('config') .. '/lua'] = true,
						},
					},
				},
			},
		})
	end,
}
