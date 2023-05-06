local status, luasnip = pcall(require, 'luasnip')
if not status then
	return
end

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

luasnip.add_snippets('typescript', {
	s(
		{ trig = 'class', name = 'HTML class attribute', dscr = 'Add class attribute', priority = 2000 },
		{ t('class="'), i(1), t('"') }
	),
	s({ trig = 'clg', name = 'console.log()', dscr = 'Add "console.log()"' }, { t('console.log('), i(1), t(')') }),
})

vim.api.nvim_create_autocmd('ModeChanged', {
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
