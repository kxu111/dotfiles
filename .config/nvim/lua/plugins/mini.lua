vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
})

require("mini.icons").setup({
	extension = {
		["typ"] = { glyph = "", hl = "MiniIconsBlue" },
		["cpp"] = { glyph = "", hl = "MiniIconsBlue" },
		["hpp"] = { glyph = "󰫵", hl = "MiniIconsPurple" },
	},
})
vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		MiniIcons.mock_nvim_web_devicons()
		MiniIcons.tweak_lsp_kind()
	end,
})

require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.ai").setup()
require("mini.splitjoin").setup()
require("mini.align").setup()
require("mini.cmdline").setup({ autocomplete = { enable = false } })
require("mini.comment").setup()
require("mini.notify").setup()
require("mini.completion").setup()

require("mini.jump").setup({
	delay = {
		highlight = 0,
		idle_stop = 1000,
	},
})

-- require("mini.diff").setup({
-- 	view = {
-- 		style = "sign",
-- 		signs = { add = " ▍", change = " ▍", delete = " ▍" },
-- 	},
-- })

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
vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename)

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
