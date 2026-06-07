vim.cmd([[
	setlocal wrap
	setlocal linebreak
	setlocal spelllang=en_gb
	setlocal spell
]])

vim.keymap.set("n", "<Leader>tp", "<Cmd>TypstPreview<CR>", { desc = "Typst preview" })

-- vim.api.nvim_set_hl(0, "@markup.link", { link = "Constant" })
