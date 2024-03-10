local status, tmuxnav = pcall(require, 'nvim-tmux-navigation')
if not status then
	return
end

tmuxnav.setup({
	disable_when_zoomed = true,
	keybindings = {
		left = '<A-Left>',
		down = '<A-Down>',
		up = '<A-Up>',
		right = '<A-Right>',
	},
})
