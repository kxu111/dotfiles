vim.pack.add({
	"https://github.com/chomosuke/typst-preview.nvim",
})

vim.cmd([[
	setlocal wrap
	setlocal linebreak
	setlocal spelllang=en_gb
	setlocal spell
]])

vim.keymap.set("n", "<Leader>tp", "<Cmd>TypstPreview<CR>", { desc = "Typst preview" })
