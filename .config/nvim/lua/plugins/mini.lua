vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
})

require("mini.pairs").setup()
require("mini.surround").setup({
	mappings = {
		add = "ys",
		delete = "ds",
		find = "gs",
		find_left = "gS",
		highlight = "gsh",
		replace = "cs",
	},
})

require("mini.ai").setup()
require("mini.splitjoin").setup()
require("mini.align").setup()
require("mini.cmdline").setup({ autocomplete = { enable = false } })
require("mini.comment").setup()
require("mini.notify").setup()

require("mini.jump").setup({
	delay = {
		highlight = 0,
		idle_stop = 1000,
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		require("mini.trailspace").trim()
	end,
})

require("mini.input").setup({
	handlers = {
		key = function(state, key)
			-- <C-a> - move caret to start of line
			if key == "\1" then
				state.caret = 1
				return
			else
				-- IMPORTANT: Fall back to processing as usual
				return MiniInput.default_key(state, key)
			end
		end,
	},
	scope = "cursor",
})

require("mini.operators").setup()
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)

require("mini.move").setup({
	mappings = {
		left = "H",
		right = "L",
		down = "J",
		up = "K",
	},
})

require("mini.files").setup({
	options = { permanent_delete = false },
	mappings = {
		go_in = "",
		go_in_plus = "l",
		synchronize = "<CR>",
		close = "<C-c>",
	},
	windows = {
		preview = true,
		width_preview = 50,
	},
	content = {
		prefix = function(fs_entry)
			if fs_entry.fs_type == "directory" then
				return " ", "MiniFilesDirectory"
			end
			if fs_entry.fs_type == "file" then
				return " ", "MiniFilesFile"
			end

			return MiniFiles.default_prefix(fs_entry)
		end,
	},
})

vim.keymap.set("n", "<C-e>", function()
	if not MiniFiles.close() then
		MiniFiles.open(vim.api.nvim_buf_get_name(0))
	end
end)

local hi_words = require("mini.extra").gen_highlighter.words
require("mini.hipatterns").setup({
	highlighters = {
		hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
		fixme = hi_words({ "FIXME" }, "MiniHipatternsFixme"),
		todo = hi_words({ "TODO", "todo" }, "MiniHipatternsTodo"),
		note = hi_words({ "NOTE" }, "MiniHipatternsNote"),
		hack = hi_words({ "HACK" }, "MiniHipatternsHack"),
	},
})

require("mini.extra").setup()
require("mini.pick").setup()
vim.keymap.set("n", "<C-p>", "<Cmd>Pick files<CR>")
vim.keymap.set("n", "<Leader>sh", "<Cmd>Pick help<CR>")
vim.keymap.set("n", "<Leader>sb", "<Cmd>Pick buffers<CR>")
vim.keymap.set("n", "<C-g>", "<Cmd>Pick grep_live<CR>")
vim.keymap.set("n", "<Leader>sp", "<Cmd>Pick hipatterns<CR>")
vim.keymap.set("n", "<Leader>sm", "<Cmd>Pick manpages<CR>")
vim.keymap.set("n", "z=", "<Cmd>Pick spellsuggest<CR>")
vim.keymap.set("n", "<Leader>a", vim.lsp.buf.code_action)
vim.keymap.set("n", "<Leader>d", "<Cmd>Pick diagnostic<CR>")
vim.keymap.set("n", "<Leader>sc", "<Cmd>Pick resume<CR>")
vim.keymap.set("n", "<Leader>fr", "<Cmd>lua MiniExtra.pickers.lsp({ scope = 'references' })<CR>")
