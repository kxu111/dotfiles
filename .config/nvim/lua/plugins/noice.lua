vim.pack.add({
	"https://github.com/folke/noice.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
})

require("noice").setup({
	cmdline = {
		view = "cmdline",
		format = { cmdline = { icon = ":" } },
	},
	format = { level = { icons = false } },
	views = { mini = { win_options = { winblend = 0 } } },
})
