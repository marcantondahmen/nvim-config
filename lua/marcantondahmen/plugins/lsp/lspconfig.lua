-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status then
	return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_nvim_lsp_status then
	return
end

-- import typescript plugin safely
local typescript_setup, typescript = pcall(require, 'typescript')
if not typescript_setup then
	return
end

local wk_setup, wk = pcall(require, 'which-key')
if not wk_setup then
	return
end

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	-- set keybinds
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
			f = { '<cmd>Lspsaga lsp_finder<CR>', 'Show definition, references' },
			D = { '<Cmd>lua vim.lsp.buf.declaration()<CR>', 'See definition and make edits in window' },
			d = { '<cmd>Lspsaga peek_definition<CR>', 'Peek definition' },
			i = { '<cmd>lua vim.lsp.buf.implementation()<CR>', 'Go to implementation' },
			k = { '<cmd>Lspsaga hover_doc<CR>', 'Show documentation for what is under cursor' },
		},
	})

	client.server_capabilities.semanticTokensProvider = nil

	-- typescript specific keymaps (e.g. rename file and update imports)
	if client.name == 'tsserver' then
		wk.register({
			['<leader>'] = {
				name = 'Rename/Remove',
				rf = { ':TypescriptRenameFile<CR>', 'Rename file and update imports' },
				ru = { ':TypescriptRemoveUnused<CR>', 'Remove unused variables' },
			},
		})
	end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

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
typescript.setup({
	server = {
		capabilities = capabilities,
		on_attach = on_attach,
	},
})

-- configure css server
lspconfig['cssls'].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure tailwindcss server
lspconfig['tailwindcss'].setup({
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