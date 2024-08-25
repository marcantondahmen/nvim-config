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
				left = '<S-Left>',
				down = '<S-Down>',
				up = '<S-Up>',
				right = '<S-Right>',
			},
		})
	end,
}
