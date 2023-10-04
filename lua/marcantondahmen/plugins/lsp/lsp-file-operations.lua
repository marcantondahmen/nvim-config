local status, fileOperations = pcall(require, 'lsp-file-operations')
if not status then
	return
end

fileOperations.setup({
	-- used to see debug logs in file `vim.fn.stdpath("cache") .. lsp-file-operations.log`
	debug = false,
	-- how long to wait (in milliseconds) for file rename information before cancelling
	timeout_ms = 10000,
})
