vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz")
vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz")

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+y$')

vim.keymap.set("n", "<leader>v", "<Cmd>vertical split<CR>")

vim.keymap.set({ "n", "v" }, "<C-s>", [[:s/\V]])
vim.keymap.set("n", "<C-t>", "<C-w>T")
for i = 1, 9 do
	vim.keymap.set("n", "<leader>" .. i, "<Cmd>tabnext " .. i .. "<CR>")
end

vim.keymap.set("n", "<C-q>", function()
	local qf_open = false
	for _, win in ipairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 and win.winnr == vim.fn.winnr() then
			qf_open = true
			break
		end
	end
	if qf_open then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end, { desc = "Toggle quickfix window" })
vim.keymap.set("n", "<leader>cq", function()
	vim.fn.setqflist({}, "r")
	vim.cmd("cclose")
end, { desc = "Clear quickfix list" })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.keymap.set("n", "dd", function()
			local linenr = vim.fn.line(".")
			local items = vim.fn.getqflist()
			table.remove(items, linenr)
			vim.fn.setqflist(items, "r")
			vim.fn.cursor(linenr, 1)
		end, { buffer = true, desc = "Delete quickfix item" })
	end,
})

vim.keymap.set("n", "<C-j>", "<Cmd>cnext<CR>")
vim.keymap.set("n", "<C-k>", "<Cmd>cprev<CR>")

vim.keymap.set("v", "<C-s>", [[:s/\V]])
