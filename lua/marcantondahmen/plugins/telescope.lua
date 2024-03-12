return {
	'nvim-telescope/telescope.nvim',
	requires = {
		{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
	},
	config = function()
		local telescopeSuccess, telescope = pcall(require, 'telescope')
		if not telescopeSuccess then
			return
		end

		local actions = require('telescope.actions')

		-- configure telescope
		telescope.setup({
			-- configure custom mappings
			defaults = {
				file_ignore_patterns = { 'node_modules' },
				mappings = {
					i = {
						['<C-k>'] = actions.move_selection_previous, -- move to prev result
						['<C-j>'] = actions.move_selection_next, -- move to next result
						['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist, -- send selected to quickfixlist
						['<esc>'] = actions.close,
					},
				},
				borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
				prompt_prefix = '󰁕 ',
				selection_caret = ' ',
				entry_prefix = '  ',
				multi_icon = '',
			},
		})

		pcall(telescope.load_extension, 'fzf')
		telescope.load_extension('scripts')
	end,
}
