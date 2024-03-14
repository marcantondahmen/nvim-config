return {
	'goolord/alpha-nvim',
	config = function()
		local success, alpha = pcall(require, 'alpha')
		if not success then
			return
		end

		local dashboard = require('alpha.themes.dashboard')

		dashboard.section.header.val = {
			'                                            ',
			'                    ....                    ',
			"                  .:   '':.                 ",
			"                  ::::     ':..             ",
			"                  ::.         ''..          ",
			"       .:'.. ..':.:::'    . :.   '':.       ",
			"      :.   ''     ''     '. ::::.. ..:      ",
			"      ::::.        ..':.. .''':::::  .      ",
			"      :::::::..    '..::::  :. ::::  :      ",
			"      ::'':::::::.    ':::.'':.::::  :      ",
			"      :..   ''::::::....':     ''::  :      ",
			"      :::::.    ':::::   :     .. '' .      ",
			"   .''::::::::... ':::.''   ..''  :.''''.   ",
			"   :..:::'':::::  :::::...:''        :..:   ",
			"   ::::::. '::::  ::::::::  ..::        .   ",
			"   ::::::::.::::  ::::::::  :'':.::   .''   ",
			"   ::: '::::::::.' '':::::  :.' '':  :      ",
			"   :::   :::::::::..' ::::  ::...'   .      ",
			"   :::  .::::::::::   ::::  ::::  .:'       ",
			"    '::'  '':::::::   ::::  : ::  :         ",
			"              '::::   ::::  :''  .:         ",
			"               ::::   ::::    ..''          ",
			"               :::: ..:::: .:''             ",
			"                 ''''  '''''                ",
			'                                            ',
		}

		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button('s', '     Restore Session', ':SessionRestore<CR>'),
			dashboard.button('r', '     Recent Files   ', ':Telescope oldfiles<CR>'),
			dashboard.button('f', '     Find File      ', ':Telescope find_files<CR>'),
			dashboard.button('t', '󱎸     Find Text      ', ':Telescope live_grep<CR>'),
			dashboard.button('q', '     Quit           ', ':qa<CR>'),
		}

		local cwd = vim.fn.getcwd()

		dashboard.section.footer.val = {
			' ',
			'  ' .. cwd,
		}

		alpha.setup(dashboard.opts)

		vim.cmd([[
			augroup madAlpha
				autocmd FileType alpha setlocal nofoldenable
				autocmd User AlphaReady set showtabline=0  
				autocmd User AlphaReady autocmd BufEnter <buffer> setlocal showtabline=0
				autocmd User AlphaReady autocmd BufUnload <buffer> set showtabline=2 
			augroup end
		]])
	end,
}
