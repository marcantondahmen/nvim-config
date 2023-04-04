local status, autosession = pcall(require, 'auto-session')
if not status then
	return
end

autosession.setup({
	auto_restore_enabled = false,
})
