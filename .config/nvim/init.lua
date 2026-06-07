-- stylua: ignore start
local servers = {
	"tree-sitter-cli",
	"lua_ls", "stylua",
	"nil", "alejandra",
	"clangd", "clang-format",
	"rust-analyzer",
	"tinymist",
	"pyright", "ruff",
	"svelte-language-server", "cssls"
}
local parsers = {
	"lua",
	"nix",
	"c", "cpp",
	"rust",
	"markdown_inline", "markdown",
	"typst",
	"python",
	"svelte", "html", "typescript", "css",
}
local formatters = {
	lua = { "stylua" },
	nix = { "alejandra" },
	c = { "clang-format" }, cpp = { "clang-format" },
	rs = { "rustfmt" },
	typ = { "typstyle" },
	py = { "ruff" },
}
-- stylua: ignore end

vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.swapfile = false
vim.o.winborder = "rounded"
vim.o.pumborder = "rounded"
vim.o.signcolumn = "yes"
vim.o.termguicolors = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.splitright = true
vim.o.undofile = true
vim.o.ruler = false
vim.o.laststatus = 0

vim.pack.add({
	"https://github.com/oskarnurm/koda.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/akinsho/bufferline.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/chomosuke/typst-preview.nvim",
})

require("koda").setup({ transparent = true })
vim.cmd("colorscheme koda")

local function hl(name)
	return vim.api.nvim_get_hl(0, { name = name, link = false })
end
local function fg_or_nil(group)
	local value = hl(group)
	return value and value.fg or nil
end

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({ auto_update = true, ensure_installed = servers })
require("nvim-treesitter").install(parsers)

require("mini.icons").setup({
	extension = {
		["typ"] = { glyph = "", hl = "MiniIconsBlue" },
		["cpp"] = { glyph = "", hl = "MiniIconsBlue" },
		["hpp"] = { glyph = "󰫵", hl = "MiniIconsPurple" },
		["svelte"] = { hl = "MiniIconsRed" },
		["toml"] = { hl = "MiniIconsRed" },
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
require("mini.jump").setup()

local key_handler = function(state, key)
	-- <C-a> - move caret to start of line
	if key == "\1" then
		state.caret = 1
		return
	else
		-- IMPORTANT: Fall back to processing as usual
		return MiniInput.default_key(state, key)
	end
end
require("mini.input").setup({ handlers = { key = key_handler } })

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

require("mini.files").setup({
	options = { permanent_delete = false },
	mappings = {
		go_in = "",
		go_in_plus = "l",
		synchronize = "<CR>",
	},
	windows = {
		preview = true,
		width_preview = 50,
	},
})
vim.keymap.set("n", "<Leader>e", function()
	if not MiniFiles.close() then
		MiniFiles.open(vim.api.nvim_buf_get_name(0))
	end
end)

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
vim.keymap.set("n", "<Leader>s", "<Cmd>Pick files<CR>")
vim.keymap.set("n", "<Leader>fh", "<Cmd>Pick help<CR>")
vim.keymap.set("n", "<Leader>fb", "<Cmd>Pick buffers<CR>")
vim.keymap.set("n", "<Leader>fl", "<Cmd>Pick grep_live<CR>")
vim.keymap.set("n", "<Leader>fp", "<Cmd>Pick hipatterns<CR>")
vim.keymap.set("n", "<Leader>fm", "<Cmd>Pick manpages<CR>")
vim.keymap.set("n", "z=", "<Cmd>Pick spellsuggest<CR>")
vim.keymap.set("n", "<Leader>a", vim.lsp.buf.code_action)
vim.keymap.set("n", "<Leader>fs", "<Cmd>lua MiniExtra.pickers.lsp({ scope = 'definition' })<CR>")
vim.keymap.set("n", "<Leader>fd", "<Cmd>Pick diagnostic<CR>")
vim.keymap.set("n", "<Leader>fc", "<Cmd>Pick resume<CR>")
vim.keymap.set("n", "<Leader>fr", "<Cmd>lua MiniExtra.pickers.lsp({ scope = 'references' })<CR>")

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
vim.keymap.set("n", "<Tab>", "<Cmd>bnext<CR>")
vim.keymap.set("n", "<S-Tab>", "<Cmd>bprev<CR>")
local br = require("bufremove")
vim.keymap.set("n", "<Leader>x", br.bufdelete_cur, { desc = "Delete" })
vim.keymap.set("n", "<leader>o", br.bufdelete_others, { desc = "Delete Others" })
vim.keymap.set("n", "<leader>W", br.bufwipeout_cur, { desc = "Wipeout!" })
vim.keymap.set("n", "<leader>h", br.bufdelete_left, { desc = "Delete Left" })
vim.keymap.set("n", "<leader>l", br.bufdelete_right, { desc = "Delete Right" })
vim.keymap.set("n", "<leader>b", "<Cmd>BufferLinePick<CR>")
vim.keymap.set("n", "<leader>p", function()
	vim.cmd("BufferLineTogglePin")
	require("bufpin").toggle()
end)

local base = hl("TabLine")
local selected = hl("TabLineSel")
vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { bg = selected.bg, fg = selected.fg, bold = true })
vim.api.nvim_set_hl(0, "BufferLineBackground", { bg = base.bg, fg = base.fg })
vim.api.nvim_set_hl(0, "BufferLineBufferVisible", { bg = base.bg, fg = base.fg })
vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { bg = selected.bg, fg = selected.fg, bold = true })
vim.api.nvim_set_hl(0, "BufferLineDuplicate", { bg = base.bg, fg = base.fg })
vim.api.nvim_set_hl(0, "BufferLineDuplicateVisible", { bg = base.bg, fg = base.fg })
vim.api.nvim_set_hl(0, "BufferLineDuplicateSelected", { bg = selected.bg, fg = selected.fg, bold = true })
vim.api.nvim_set_hl(0, "BufferLineModified", { bg = base.bg, fg = fg_or_nil("DiagnosticWarn") or base.fg })
vim.api.nvim_set_hl(0, "BufferLineModifiedVisible", { bg = base.bg, fg = fg_or_nil("DiagnosticWarn") or base.fg })
-- stylua: ignore
vim.api.nvim_set_hl( 0, "BufferLineModifiedSelected", { bg = selected.bg, fg = fg_or_nil("DiagnosticWarn") or selected.fg })
vim.api.nvim_set_hl(0, "BufferLineSeparator", { bg = base.bg, fg = base.bg })
vim.api.nvim_set_hl(0, "BufferLineSeparatorVisible", { bg = base.bg, fg = base.bg })
vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected", { bg = selected.bg, fg = selected.bg })
vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { bg = selected.bg, fg = fg_or_nil("Special") or selected.fg })
-- stylua: ignore start
vim.api.nvim_set_hl( 0, "BufferLineHintSelected", { bg = selected.bg, fg = fg_or_nil("BufferLineHintSelected") or selected.fg, bold = true })
vim.api.nvim_set_hl( 0, "BufferLineWarningSelected", { bg = selected.bg, fg = fg_or_nil("BufferLineWarningSelected") or selected.fg, bold = true })
vim.api.nvim_set_hl( 0, "BufferLineErrorSelected", { bg = selected.bg, fg = fg_or_nil("BufferLineErrorSelected") or selected.fg, bold = true })
-- stylua: ignore end
local mini_icons_colors = { "Azure", "Blue", "Grey", "Red", "Cyan", "Orange", "Green", "Yellow", "Purple" }
for _, color in ipairs(mini_icons_colors) do
	local group_name = "BufferLineMiniIcons" .. color .. "Selected"
	vim.api.nvim_set_hl(0, group_name, {
		bg = selected.bg,
		fg = hl("MiniIcons" .. color).fg,
	})
end

require("conform").setup({
	format_on_save = { lsp_format = "fallback", timeout_ms = 500 },
	formatters_by_ft = formatters,
})

vim.cmd.packadd("nvim.undotree")
vim.keymap.set("n", "<Leader>u", "<Cmd>Undotree<CR>")

vim.cmd.packadd("nohlsearch")
vim.keymap.set("n", "<ESC>", "<Cmd>nohlsearch<CR>", { noremap = true, silent = true })

vim.diagnostic.config({ virtual_text = true })

vim.cmd("filetype plugin indent on")

vim.keymap.set({ "n", "v" }, "<Leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<Leader>d", '"+d')
vim.keymap.set({ "n", "v" }, "<Leader>Y", '"+y$') -- for some reason capital Y doesn't work *when i press the keymap*
vim.keymap.set({ "n", "v" }, "<Leader>D", '"+D')

vim.keymap.set("n", "<Leader>v", "<Cmd>vertical split<CR>")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set({ "n", "v" }, "<C-s>", [[:s/\V]])
vim.keymap.set("n", "<C-t>", "<C-w>T")
for i = 1, 9 do
	vim.keymap.set("n", "<Leader>" .. i, "<Cmd>tabnext " .. i .. "<CR>")
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

vim.keymap.set("n", "<C-n>", "<Cmd>cnext<CR>")
vim.keymap.set("n", "<C-p>", "<Cmd>cprev<CR>")

vim.keymap.set("v", "<C-s>", [[:s/\V]])

local function pack_clean()
	local active_plugins = {}
	local unused_plugins = {}

	for _, plugin in ipairs(vim.pack.get()) do
		active_plugins[plugin.spec.name] = plugin.active
	end

	for _, plugin in ipairs(vim.pack.get()) do
		if not active_plugins[plugin.spec.name] then
			table.insert(unused_plugins, plugin.spec.name)
		end
	end

	if #unused_plugins == 0 then
		print("Nothing to clean.")
		return
	end

	vim.pack.del(unused_plugins)
end

local function ts_clean()
	local desired = {}
	local installed = {}

	for _, p in ipairs(parsers) do
		desired[p] = true
	end

	for file in vim.fs.dir(vim.fn.stdpath("data") .. "/site/parser") do
		if file:match("%.so$") then
			local parser = file:gsub("%.so$", "")
			installed[parser] = true
		end
	end

	for parser, _ in pairs(installed) do
		if not desired[parser] then
			vim.cmd("TSUninstall " .. parser)
		end
	end
end

local function clean_all()
	pack_clean()
	ts_clean()
	vim.cmd("MasonToolsClean")
end

vim.keymap.set("n", "<Leader>ca", clean_all)

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = parsers,
	callback = function()
		vim.treesitter.start()
	end,
})
