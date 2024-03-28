return {
	'lukas-reineke/headlines.nvim',
	after = 'nvim-treesitter',
	ft = 'markdown',
	config = function()
		local success, headlines = pcall(require, 'headlines')
		if not success then
			return
		end

		headlines.setup()

		-- Toggle markdown headlines on insert enter/leave
		-- see https://github.com/LazyVim/LazyVim/commit/0ba731a87977e98f2420e2c6d2c4cabbcedaff60
		local md = headlines.config.markdown

		vim.api.nvim_create_augroup('madHeadlines', { clear = true })
		vim.api.nvim_create_autocmd({ 'InsertEnter', 'InsertLeave' }, {
			group = 'madHeadlines',
			callback = function(data)
				if vim.bo.filetype == 'markdown' then
					headlines.config.markdown = data.event == 'InsertLeave' and md or nil
					headlines.refresh()
				end
			end,
		})
	end,
}
