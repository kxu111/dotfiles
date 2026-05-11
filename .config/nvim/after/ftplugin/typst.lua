vim.cmd([[
	setlocal wrap
	setlocal linebreak
	setlocal spelllang "en_gb"
	setlocal spell
]])

vim.keymap.set("n", "<leader>p", ":TypstPreview<CR>", { desc = "Typst preview" })
