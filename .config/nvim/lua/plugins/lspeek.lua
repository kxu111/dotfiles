vim.pack.add({
	"https://github.com/r4ppz/lspeek.nvim",
})

local lspeek = require("lspeek")
lspeek.setup({
	window = {
		border = "single",
	},
})

vim.keymap.set("n", "gD", lspeek.peek_definition)
vim.keymap.set("n", "gT", lspeek.peek_type_definition)
