return {
	'alexghergh/nvim-tmux-navigation',
	config = function()
		local success, tmux = pcall(require, 'nvim-tmux-navigation')
		if not success then
			return
		end

		tmux.setup({
			disable_when_zoomed = true,
			keybindings = {
				left = '<A-Left>',
				down = '<A-Down>',
				up = '<A-Up>',
				right = '<A-Right>',
			},
		})
	end,
}
