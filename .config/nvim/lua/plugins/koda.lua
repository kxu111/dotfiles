vim.pack.add({
	"https://github.com/oskarnurm/koda.nvim",
})

require("koda").setup({ transparent = true })
vim.cmd("colorscheme koda")
