vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
})

require("mini.pairs").setup()
require("mini.surround").setup()
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

local gen_loader = require("mini.snippets").gen_loader
require("mini.snippets").setup({
	snippets = {
		gen_loader.from_file("~/.config/nvim/snippets/global.json"),
		gen_loader.from_lang(),
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
require("mini.pick").setup({
	mappings = {
		mark_and_choose = {
			char = "<C-q>",
			func = function()
				-- Get current picker state
				local matches = MiniPick.get_picker_matches()
				if not matches then
					return
				end
				-- Get all matched items
				if not matches.all or #matches.all == 0 then
					return
				end

				-- Mark all items by setting marked indexes to all matched indexes
				MiniPick.set_picker_match_inds(matches.all_inds, "marked")

				local source = MiniPick.get_picker_opts().source
				-- Call choose_marked with all marked items
				if source.choose_marked then
					-- Get the updated marked items
					local updated_matches = MiniPick.get_picker_matches()
					source.choose_marked(updated_matches.marked)
				end

				-- Stop the picker
				return true
			end,
		},
	},
})

vim.keymap.set("n", "<C-p>", "<Cmd>Pick files<CR>")
vim.keymap.set("n", "<Leader>sh", "<Cmd>Pick help<CR>")
vim.keymap.set("n", "<Leader>sb", "<Cmd>Pick buffers<CR>")
vim.keymap.set("n", "<Leader>sl", "<Cmd>Pick grep_live<CR>")
vim.keymap.set("n", "<Leader>sp", "<Cmd>Pick hipatterns<CR>")
vim.keymap.set("n", "<Leader>sm", "<Cmd>Pick manpages<CR>")
vim.keymap.set("n", "z=", "<Cmd>Pick spellsuggest<CR>")
vim.keymap.set("n", "<Leader>a", vim.lsp.buf.code_action)
vim.keymap.set("n", "<Leader>d", "<Cmd>Pick diagnostic<CR>")
vim.keymap.set("n", "<Leader>sc", "<Cmd>Pick resume<CR>")
vim.keymap.set("n", "<Leader>fr", "<Cmd>lua MiniExtra.pickers.lsp({ scope = 'references' })<CR>")
