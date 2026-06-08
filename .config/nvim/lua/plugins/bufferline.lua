vim.pack.add({
	"https://github.com/akinsho/bufferline.nvim",
})

local M = {}

local c = require("utils.hltools")

require("bufferline").setup({
	options = {
		mode = "buffers",
		separator_style = "thin",
		always_show_bufferline = true,
		sort_by = "insert_after_current",
		show_buffer_close_icons = false,
		show_close_icon = false,
		diagnostics = "nvim_lsp",
		groups = { items = { require("bufferline.groups").builtin.pinned:with({ icon = "  " }) } },
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
vim.keymap.set("n", "<Leader>x", br.bufdelete_cur, { desc = "Delete" })
vim.keymap.set("n", "<leader>o", br.bufdelete_others, { desc = "Delete Others" })
vim.keymap.set("n", "<leader>W", br.bufwipeout_cur, { desc = "Wipeout!" })
vim.keymap.set("n", "<leader>h", br.bufdelete_left, { desc = "Delete Left" })
vim.keymap.set("n", "<leader>l", br.bufdelete_right, { desc = "Delete Right" })
vim.keymap.set("n", "<leader>b", "<Cmd>BufferLinePick<CR>")
vim.keymap.set("n", "<leader>p", function()
	vim.cmd("BufferLineTogglePin")
	require("utils.bufpin").toggle()
end)

function M.bufferline_hl_groups()
	local base = c.hl("TabLine")
	local selected = c.hl("TabLineSel")
	vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { bg = selected.bg, fg = selected.fg, bold = true })
	vim.api.nvim_set_hl(0, "BufferLineBackground", { bg = base.bg, fg = base.fg })
	vim.api.nvim_set_hl(0, "BufferLineFill", { bg = base.bg, fg = base.fg })
	vim.api.nvim_set_hl(0, "BufferLineBufferVisible", { bg = base.bg, fg = base.fg })
	vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { bg = selected.bg, fg = selected.fg, bold = true })
	vim.api.nvim_set_hl(0, "BufferLineDuplicate", { bg = base.bg, fg = base.fg })
	vim.api.nvim_set_hl(0, "BufferLineDuplicateVisible", { bg = base.bg, fg = base.fg })
	vim.api.nvim_set_hl(0, "BufferLineDuplicateSelected", { bg = selected.bg, fg = selected.fg, bold = true })
	vim.api.nvim_set_hl(0, "BufferLineModified", { bg = base.bg, fg = c.fg_or_nil("DiagnosticWarn") or base.fg })
	vim.api.nvim_set_hl(0, "BufferLineModifiedVisible", { bg = base.bg, fg = c.fg_or_nil("DiagnosticWarn") or base.fg })
	vim.api.nvim_set_hl(
		0,
		"BufferLineModifiedSelected",
		{ bg = selected.bg, fg = c.fg_or_nil("DiagnosticWarn") or selected.fg }
	)
	vim.api.nvim_set_hl(0, "BufferLineSeparator", { bg = base.bg, fg = base.bg })
	vim.api.nvim_set_hl(0, "BufferLineSeparatorVisible", { bg = base.bg, fg = base.bg })
	vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected", { bg = selected.bg, fg = selected.bg })
	vim.api.nvim_set_hl(
		0,
		"BufferLineIndicatorSelected",
		{ bg = selected.bg, fg = c.fg_or_nil("Special") or selected.fg }
	)
	vim.api.nvim_set_hl(
		0,
		"BufferLineHintSelected",
		{ bg = selected.bg, fg = c.fg_or_nil("BufferLineHintSelected") or selected.fg, bold = true }
	)
	vim.api.nvim_set_hl(
		0,
		"BufferLineWarningSelected",
		{ bg = selected.bg, fg = c.fg_or_nil("BufferLineWarningSelected") or selected.fg, bold = true }
	)
	vim.api.nvim_set_hl(
		0,
		"BufferLineErrorSelected",
		{ bg = selected.bg, fg = c.fg_or_nil("BufferLineErrorSelected") or selected.fg, bold = true }
	)
	local mini_icons_colors = { "Azure", "Blue", "Grey", "Red", "Cyan", "Orange", "Green", "Yellow", "Purple" }
	for _, color in ipairs(mini_icons_colors) do
		local group_name = "BufferLineMiniIcons" .. color .. "Selected"
		vim.api.nvim_set_hl(0, group_name, {
			bg = selected.bg,
			fg = c.hl("MiniIcons" .. color).fg,
		})
	end
end

return M
