return {
	'L3MON4D3/LuaSnip',
	event = 'VimEnter',
	after = 'friendly-snippets',
	requires = {
		{
			'rafamadriz/friendly-snippets',
			event = 'VimEnter',
		},
	},
	config = function()
		local luasnipSuccess, luasnip = pcall(require, 'luasnip')
		if not luasnipSuccess then
			return
		end

		-- load vs-code like snippets from plugins (e.g. friendly-snippets)
		require('luasnip/loaders/from_vscode').lazy_load()

		local s = luasnip.snippet
		local t = luasnip.text_node
		local i = luasnip.insert_node

		luasnip.add_snippets('all', {
			s({ trig = '/**', name = 'Doc Block', dscr = 'Add a doc block comment' }, {
				t({ '/**' }),
				t({ '', ' * ' }),
				i(1),
				t({ '', ' */' }),
			}),
		})

		luasnip.add_snippets('php', {
			s({ trig = '<@', name = 'Automad Statement' }, {
				t({ '<@ ' }),
				i(1),
				t({ ' @>' }),
			}),
			s({ trig = '@', name = 'Automad Variable' }, {
				t({ '@{ ' }),
				i(1),
				t({ ' }' }),
			}),
			s({ trig = '#', name = 'Automad Comment' }, {
				t({ '<# ' }),
				i(1),
				t({ ' #>' }),
			}),
			s({ trig = '@pagelist', name = 'foreach in pagelist' }, {
				t({ '<@ foreach in pagelist @>', '	' }),
				i(1),
				t({ '', '<@ end @>' }),
			}),
			s({ trig = '@pagelistelse', name = 'foreach in pagelist else' }, {
				t({ '<@ foreach in pagelist @>', '	' }),
				i(1),
				t({ '', '<@ else @>', '	' }),
				i(2),
				t({ '', '<@ end @>' }),
			}),
			s({ trig = '@if', name = 'if ...' }, {
				t({ '<@ if ' }),
				i(1),
				t({ ' @>', '	' }),
				i(2),
				t({ '', '<@ end @>' }),
			}),
			s({ trig = '@ifelse', name = 'if ... else ...' }, {
				t({ '<@ if ' }),
				i(1),
				t({ ' @>', '	' }),
				i(2),
				t({ '', '<@ else @>', '	' }),
				i(3),
				t({ '', '<@ end @>' }),
			}),
			s({ trig = '@with', name = 'with ...' }, {
				t({ '<@ with ' }),
				i(1),
				t({ ' @>', '	' }),
				i(2),
				t({ '', '<@ end @>' }),
			}),
			s({ trig = '@withelse', name = 'with ... else ...' }, {
				t({ '<@ with ' }),
				i(1),
				t({ ' @>', '	' }),
				i(2),
				t({ '', '<@ else @>', '	' }),
				i(3),
				t({ '', '<@ end @>' }),
			}),
			s({ trig = '@for', name = 'for ... to ...' }, {
				t({ '<@ for ' }),
				i(1),
				t({ ' to ' }),
				i(2),
				t({ ' @>', '	' }),
				i(3),
				t({ '', '<@ end @>' }),
			}),
		})

		luasnip.add_snippets('typescript', {
			s(
				{ trig = 'class', name = 'HTML class attribute', dscr = 'Add class attribute', priority = 2000 },
				{ t('class="'), i(1), t('"') }
			),
			s(
				{ trig = 'clg', name = 'console.log()', dscr = 'Add "console.log()"' },
				{ t('console.log('), i(1), t(')') }
			),
		})

		vim.api.nvim_create_augroup('madLuasnip', { clear = true })
		vim.api.nvim_create_autocmd('ModeChanged', {
			group = 'madLuasnip',
			pattern = '*',
			callback = function()
				if
					((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
					and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
					and not require('luasnip').session.jump_active
				then
					require('luasnip').unlink_current()
				end
			end,
		})
	end,
}
