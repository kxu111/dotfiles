vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/aznhe21/actions-preview.nvim",
})

local telescope = require("telescope")
local actions = require("telescope.actions")
local layout_strategies = require("telescope.pickers.layout_strategies")
layout_strategies.vertical_fused = function(picker, max_columns, max_lines, layout_config)
	local layout = layout_strategies.vertical(picker, max_columns, max_lines, layout_config)

	layout.prompt.title = ""
	layout.results.title = ""

	if layout.preview then
		layout.preview.title = ""
		layout.preview.height = layout.preview.height + 1
		layout.preview.borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }

		layout.results.borderchars = { "─", "│", "─", "│", "├", "┤", "┤", "├" }
	else
		layout.results.borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
	end

	layout.results.height = layout.results.height + 1

	layout.prompt.borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }

	return layout
end
local builtin = require("telescope.builtin")

telescope.setup({
	defaults = {
		initial_mode = "insert",
		layout_strategy = "vertical_fused",
		layout_config = {
			preview_cutoff = 1,
			width = 0.50,
			height = 0.60,
		},
		prompt_prefix = "   ",
		selection_caret = "  ",
		path_display = { "truncate" },
		winblend = 0,
		color_devicons = false,
		sorting_strategy = "descending",
		mappings = {
			i = {
				["<C-s>"] = actions.select_vertical,
				["<C-x>"] = actions.select_horizontal,
			},
			n = {
				["<C-s>"] = actions.select_vertical,
				["<C-x>"] = actions.select_horizontal,
				["q"] = require("telescope.actions").close,
			},
		},
	},
})
telescope.load_extension("fzf")
require("actions-preview").setup({
	backend = { "telescope" },
	extensions = { "env" },
	telescope = vim.tbl_extend("force", require("telescope.themes").get_dropdown(), {}),
})

vim.keymap.set("n", "<C-p>", "<Cmd>Telescope find_files<CR>", { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>sl", "<Cmd>Telescope live_grep<CR>", { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>sg", "<Cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>sb", "<Cmd>Telescope buffers<CR>", { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>sh", "<Cmd>Telescope help_tags<CR>", { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fr", "<Cmd>Telescope lsp_references<CR>")
vim.keymap.set("n", "<leader>a", require("actions-preview").code_actions)
vim.keymap.set("n", "<leader>d", "<Cmd>Telescope diagnostics<CR>")
vim.keymap.set("n", "z=", "<Cmd>Telescope spell_suggest<CR>")
vim.keymap.set("n", "<leader>sc", "<Cmd>Telescope resume<CR>")
