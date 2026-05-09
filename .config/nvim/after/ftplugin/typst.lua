vim.cmd([[
	setlocal linebreak
	setlocal spell
	setlocal wrap
]])

vim.keymap.set("n", "<leader>p", ":TypstPreview<CR>", { desc = "Typst preview" })
