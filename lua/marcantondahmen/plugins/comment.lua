return {
	'numToStr/Comment.nvim',
	event = 'BufRead',
	config = function()
		local commentSuccess, comment = pcall(require, 'Comment')
		if not commentSuccess then
			return
		end

		comment.setup()
	end,
}
