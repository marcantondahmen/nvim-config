local status, ibl = pcall(require, 'ibl')
if not status then
	return
end

ibl.setup({
	indent = { highlight = { 'LineNr' } },
	scope = { enabled = true, highlight = { 'NonText' } },
})
