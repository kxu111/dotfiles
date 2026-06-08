vim.cmd.packadd("nvim.undotree")
vim.keymap.set("n", "<Leader>u", "<Cmd>Undotree<CR>")

vim.cmd.packadd("nohlsearch")
vim.keymap.set("n", "<ESC>", "<Cmd>nohlsearch<CR>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.hl_op({ higroup = "IncSearch", timeout = 300 })
	end,
})
vim.api.nvim_create_autocmd("TextPutPost", {
	callback = function()
		vim.hl.hl_op({ higroup = "IncSearch", timeout = 300 })
	end,
})
