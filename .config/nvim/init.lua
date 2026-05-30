-- stylua: ignore start
local servers = {
	"tree-sitter-cli",
	"lua_ls", "stylua",
	"nil", "alejandra",
	"clangd", "clang-format",
	"rust-analyzer",
	"tinymist",
	"pyright", "ruff",
}
local parsers = {
	"lua",
	"nix",
	"c", "cpp",
	"rust",
	"markdown_inline", "markdown",
	"typst",
	"python",
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
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.wrap = false
vim.o.swapfile = false
vim.o.winborder = "rounded"
vim.o.signcolumn = "yes"
vim.o.termguicolors = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.splitright = true
vim.o.undofile = true

vim.pack.add({
	"https://github.com/vague-theme/vague.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/chomosuke/typst-preview.nvim",
})

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({ auto_update = true, ensure_installed = servers })
vim.diagnostic.config({ virtual_text = true })
require("nvim-treesitter").install(parsers)
require("conform").setup({
	format_on_save = { lsp_format = "fallback", timeout_ms = 500 },
	formatters_by_ft = formatters,
})

require("mini.icons").setup({
	extension = {
		["typ"] = { glyph = "" },
		["cpp"] = { glyph = "" },
	},
})
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.ai").setup()
require("mini.splitjoin").setup()
require("mini.bufremove").setup()
require("mini.tabline").setup()
vim.keymap.set("n", "<Tab>", "<Cmd>bnext<CR>")
vim.keymap.set("n", "<S-Tab>", "<Cmd>bprev<CR>")
vim.keymap.set("n", "<Leader>x", function()
	require("mini.bufremove").delete(0, false)
end)
vim.keymap.set("n", "<leader>o", function()
	local bufremove = require("mini.bufremove")
	local cur = vim.api.nvim_get_current_buf()

	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if buf ~= cur then
			bufremove.delete(buf, false)
		end
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
require("mini.move").setup({ mappings = { left = "H", right = "L", down = "J", up = "K" } })
require("mini.completion").setup()
vim.o.pumborder = "rounded"
require("mini.statusline").setup({
	content = {
		active = function()
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
			local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
			local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
			local filename = MiniStatusline.section_filename({ trunc_width = 140 })
			local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 10 ^ 7 })
			local location = MiniStatusline.section_location({ trunc_width = 75 })

			return MiniStatusline.combine_groups({
				{ hl = mode_hl, strings = { mode } },
				"%<", -- Mark general truncate point
				{ hl = "MiniStatuslineFilename", strings = { filename } },
				"%=", -- End left alignment
				{ hl = "MiniStatuslineFileinfo", strings = { fileinfo, diagnostics, lsp } },
				{ hl = mode_hl, strings = { location } },
			})
		end,
	},
})

require("fzf-lua").setup({
	defaults = { formatter = "path.dirname_first" }, -- show greyed-out directory before filename
	fzf_opts = { ["--info"] = "hidden" },
	winopts = {
		border = "none",
		fullscreen = true,
		preview = {
			border = "rounded",
			scrollbar = false,
		},
	},
})
vim.keymap.set("n", "<Leader>s", "<Cmd>FzfLua files<CR>")
vim.keymap.set("n", "<Leader>fh", "<Cmd>FzfLua helptags<CR>")
vim.keymap.set("n", "<Leader>fb", "<Cmd>FzfLua buffers<CR>")
vim.keymap.set("n", "<Leader>fl", "<Cmd>FzfLua live_grep<CR>")
vim.keymap.set("n", "<Leader>fd", "<Cmd>FzfLua diagnostics_document<CR>")
vim.keymap.set("n", "<Leader>fs", "<Cmd>FzfLua lsp_definitions<CR>")
vim.keymap.set("n", "<Leader>fv", "<Cmd>FzfLua lsp_references<CR>")
vim.keymap.set("n", "<Leader>fr", "<Cmd>FzfLua resume<CR>")
vim.keymap.set("n", "<Leader>fa", "<Cmd>FzfLua lsp_code_actions<CR>")

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		require("fzf-lua").register_ui_select()
		MiniIcons.tweak_lsp_kind()
	end,
})

vim.cmd.packadd("nvim.undotree")
vim.keymap.set("n", "<Leader>u", "<Cmd>Undotree<CR>")

vim.cmd.packadd("nohlsearch")
vim.keymap.set("n", "<ESC>", "<Cmd>nohlsearch<CR>", { noremap = true, silent = true })

vim.cmd("filetype plugin indent on")

vim.keymap.set("n", "<Leader>q", "<Cmd>quit<CR>")
vim.keymap.set("n", "<Leader><C-q>", "<Cmd>qa!<CR>")
vim.keymap.set("n", "<Leader>w", "<Cmd>write<CR>")
vim.keymap.set("n", "<Leader>r", "<Cmd>source " .. vim.fn.stdpath("config") .. "/init.lua<CR>")

vim.keymap.set({ "n", "v" }, "<Leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<Leader>d", '"+d')
vim.keymap.set({ "n", "v" }, "<Leader>Y", '"+y$')
vim.keymap.set({ "n", "v" }, "<Leader>D", '"+d$')

vim.keymap.set("n", "<Leader>v", "<Cmd>vertical split<CR>")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<C-t>", "<C-w>T")
for i = 1, 9 do
	vim.keymap.set("n", "<Leader>" .. i, "<Cmd>tabnext " .. i .. "<CR>")
end

vim.keymap.set({ "n", "v" }, "<C-n>", ":norm ")
vim.keymap.set({ "n", "v" }, "<C-s>", [[:s/\V]])

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

vim.keymap.set("n", "<Leader>c", clean_all)

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

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		local c = require("vague.config.internal").current.colors

		vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
		vim.api.nvim_set_hl(0, "TabLine", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
		vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })

		vim.api.nvim_set_hl(0, "FzfLuaBorder", { link = "Comment" })
		vim.api.nvim_set_hl(0, "MiniFilesCursorLine", { bg = "none" })
		vim.api.nvim_set_hl(0, "MiniTablineCurrent", { fg = c.parameter, bold = true })
		-- stylua: ignore start
		vim.api.nvim_set_hl(0, "MiniTablineModifiedCurrent", { fg = c.parameter, bold = true })
		vim.api.nvim_set_hl(0, "MiniTablineVisible", { fg = vim.api.nvim_get_hl(0, { name = "Comment" }).fg, bold = true })
		vim.api.nvim_set_hl(0, "MiniTablineHidden", { fg = vim.api.nvim_get_hl(0, { name = "Comment" }).fg })
		-- stylua: ignore end
	end,
})
vim.cmd("colorscheme vague")
