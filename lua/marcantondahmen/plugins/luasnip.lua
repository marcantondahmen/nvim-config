local status, luasnip = pcall(require, 'luasnip')
if not status then
	return
end

local t = luasnip.text_node
local i = luasnip.insert_node

luasnip.add_snippets('all', {
	luasnip.snippet({ trig = '/**', name = 'Doc Block', dscr = 'Add a doc block comment' }, {
		t({ '/**' }),
		t({ '', ' * ' }),
		i(1),
		t({ '', ' */' }),
	}),
})
