local actions = require('telescope.actions')
local state = require('telescope.actions.state')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local themes = require('telescope.themes')
local Terminal = require('toggleterm.terminal').Terminal

local getNpmScripts = function()
	local filePath = vim.fn.getcwd() .. '/package.json'
	local file = io.open(filePath, 'rb')

	if file == nil then
		return {}
	end

	local jsonString = file:read('*a')

	file:close()

	local pkg = vim.fn.json_decode(jsonString)
	local scripts = {}

	if pkg['scripts'] ~= nil then
		for item, _ in pairs(pkg['scripts']) do
			table.insert(scripts, item)
		end
	end

	return scripts
end

local getShellScripts = function()
	local cwd = vim.fn.getcwd()
	local files = {}
	local fileList = io.popen('find ' .. cwd .. ' -maxdepth 2 -name "*.sh" | sed "s|' .. cwd .. '/||"')

	if fileList == nil then
		return {}
	end

	for file in fileList:lines() do
		table.insert(files, file)
	end

	fileList:close()

	return files
end

local getScripts = function()
	local scripts = {}
	local shell = getShellScripts()
	local npm = getNpmScripts()
	local cwd = vim.fn.getcwd()

	for _, item in ipairs(npm) do
		table.insert(scripts, { '  ' .. item, 'npm run ' .. item })
	end

	for _, item in ipairs(shell) do
		local short = item:gsub('^' .. cwd, '')
		table.insert(scripts, {
			'  ' .. short,
			'echo "  $(pwd)" && echo "  ' .. short .. '\n" && ' .. vim.o.shell .. ' ' .. item,
		})
	end

	return scripts
end

return require('telescope').register_extension({
	exports = {
		scripts = function(opts)
			opts = opts or {}

			local scripts = getScripts()
			local insertMode = function()
				vim.cmd('startinsert!')
			end

			local dropdown = themes.get_dropdown({
				borderchars = {
					prompt = { '─', '│', ' ', '│', '┌', '┐', '│', '│' },
					results = { '─', '│', '─', '│', '├', '┤', '┘', '└' },
					preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
				},
				layout_strategy = 'center',
				layout_config = {
					height = function(_, _, max_lines)
						return math.min(max_lines, 15)
					end,
					width = function(_, max_columns, _)
						return math.min(max_columns, 50)
					end,
				},
			})

			pickers
				.new(vim.tbl_deep_extend('force', opts, dropdown), {
					prompt_title = 'Scripts',
					finder = finders.new_table({
						results = scripts,
						entry_maker = function(entry)
							return {
								value = entry,
								display = entry[1],
								ordinal = entry[1],
							}
						end,
					}),
					sorting_strategy = 'ascending',
					sorter = sorters.get_generic_fuzzy_sorter(),
					attach_mappings = function(prompt_bufnr, map)
						local run = function()
							local selection = state.get_selected_entry(prompt_bufnr)
							actions.close(prompt_bufnr)
							Terminal:new({
								cmd = selection.value[2],
								hidden = false,
								close_on_exit = false,
								direction = 'float',
								on_stdout = insertMode,
								on_exit = insertMode,
							}):toggle()
						end

						map('i', '<CR>', run)
						map('n', '<CR>', run)

						return true
					end,
				})
				:find()
		end,
	},
})
