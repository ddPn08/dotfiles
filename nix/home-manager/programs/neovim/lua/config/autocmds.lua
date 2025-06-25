vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
	pattern = { "*" },
	command = "silent! wall",
	nested = true,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	pattern = { "*" },
	command = "if mode() != 'c' | checktime | endif",
	nested = true,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
	pattern = { "*" },
	command = "echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None",
	nested = true,
})
