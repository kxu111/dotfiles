vim.cmd([[
	setlocal wrap
	setlocal linebreak
	setlocal spelllang=en_gb
	setlocal spell
]])

vim.api.nvim_set_hl(0, "@markup.link", { link = "Constant" })
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "@markup.link", { link = "Constant" })
	end,
})

vim.keymap.set("n", "<Leader>p", "<Cmd>TypstPreview<CR>", { desc = "Typst preview" })
