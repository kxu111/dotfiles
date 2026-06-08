vim.pack.add({
	"https://github.com/oskarnurm/koda.nvim",
})

require("koda").setup()
vim.cmd("colorscheme koda")

vim.api.nvim_set_hl(0, "TabLine", { link = "NormalNC" })
