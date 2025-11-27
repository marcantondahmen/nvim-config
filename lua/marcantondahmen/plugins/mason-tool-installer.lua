return {
	'WhoIsSethDaniel/mason-tool-installer.nvim',
	config = function()
		local masonToolInstallerSuccess, masonToolInstaller = pcall(require, 'mason-tool-installer')
		if not masonToolInstallerSuccess then
			return
		end

		masonToolInstaller.setup({
			ensure_installed = {
				'prettier',
				'stylua',
				'php-cs-fixer',
				'shfmt',
				'pgformatter',
				'blade-formatter',
			},
		})
	end,
}
