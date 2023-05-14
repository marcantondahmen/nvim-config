local status, colorizer = pcall(require, 'colorizer')
if not status then
	return
end

local options = {
	css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
	mode = 'background', -- Set the display mode. Available modes: foreground, background.
}

colorizer.setup({
	'css',
	'less',
}, options)
