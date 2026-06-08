local parsers = {
	"lua",
	"nix",
	"c",
	"cpp",
	"rust",
	"markdown_inline",
	"markdown",
	"typst",
	"python",
	"svelte",
	"html",
	"typescript",
	"css",
}

vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
})

require("nvim-treesitter").install(parsers)

vim.api.nvim_create_autocmd("FileType", {
	pattern = parsers,
	callback = function()
		vim.treesitter.start()
	end,
})
