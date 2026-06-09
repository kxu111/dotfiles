-- NOTE: I USE BUFFERLINE OVER MINI TABLINE BCZ IT HAS BETTER DEFAULTS AND NICHE FEATURES THAT ARE NOT IN MINI TABLINE

vim.pack.add({
	"https://github.com/akinsho/bufferline.nvim",
})

require("bufferline").setup({
	options = {
		mode = "buffers",
		separator_style = { "", "" },
		modified_icon = "  *  ",
		always_show_bufferline = true,
		sort_by = "insert_after_current",
		show_buffer_icons = false,
		show_buffer_close_icons = false,
		show_close_icon = false,
		tab_size = 0,
		groups = { items = { require("bufferline.groups").builtin.pinned:with({ icon = "  " }) } },
		diagnostics = false,
		indicator = {
			style = "none",
		},
		custom_filter = function(buf_number, _)
			if vim.bo[buf_number].filetype == "qf" then
				return false
			end

			return true
		end,
	},
})
vim.keymap.set("n", "<C-l>", "<Cmd>BufferLineCycleNext<CR>")
vim.keymap.set("n", "<C-h>", "<Cmd>BufferLineCyclePrev<CR>")
local br = require("utils.bufremove")
vim.keymap.set("n", "<C-x>", br.bufdelete_cur, { desc = "Delete" })
vim.keymap.set("n", "<C-o>", br.bufdelete_others, { desc = "Delete Others" })
vim.keymap.set("n", "<leader>W", br.bufwipeout_cur, { desc = "Wipeout!" })
vim.keymap.set("n", "<leader>h", br.bufdelete_left, { desc = "Delete Left" })
vim.keymap.set("n", "<leader>l", br.bufdelete_right, { desc = "Delete Right" })
vim.keymap.set("n", "<leader>p", function()
	vim.cmd("BufferLineTogglePin")
	require("utils.bufpin").toggle()
end)
