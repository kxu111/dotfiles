-- NOTE: I USE GITSIGNS OVER MINI.DIFF BECAUSE IT PRIORITISES DIAGNOSTICS IN THE SIGNCOLUMN OVER DIFFS

vim.pack.add({
	"https://github.com/lewis6991/gitsigns.nvim",
})

require("gitsigns").setup({
	signcolumn = true,
	numhl = false,
	linehl = false,
	word_diff = false,
	current_line_blame = false,
	signs = {
		add = { text = "▍" },
		change = { text = "▍" },
		untracked = { text = "▍" },
		delete = { text = "▍" },
		topdelete = { text = "▍" },
		changedelete = { text = "▍" },
	},
	signs_staged = {
		add = { text = "▍" },
		change = { text = "▍" },
		untracked = { text = "▍" },
		delete = { text = "▍" },
		topdelete = { text = "▍" },
		changedelete = { text = "▍" },
	},
})
