local function checkForUpdates()
	local check = io.popen('(cd ~/.config/nvim/ && git fetch origin --dry-run)')
	local output = check:read('*a')

	check:close()

	if output ~= '' then
		PULL_CONFIG()
		require('packer').sync()
	end
end

vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = checkForUpdates })
