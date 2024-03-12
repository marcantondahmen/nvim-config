return {
	'numToStr/Comment.nvim',
	config = function()
		local commentSuccess, comment = pcall(require, 'Comment')
		if not commentSuccess then
			return
		end

		comment.setup()
	end,
}
