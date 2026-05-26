-- stylua: ignore start
local mason_pkgs = {
	"tree-sitter-cli",
	"lua_ls", "stylua",
	"nil", "alejandra",
	"clangd", "clang-format",
	"rust-analyzer",
	"tinymist",
	"pyright", "ruff",
}
local ts_parsers = {
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
vim.opt.shiftwidth = 4
vim.o.showtabline = 2
vim.o.wrap = false
vim.o.swapfile = false
vim.o.winborder = "rounded"
vim.o.signcolumn = "yes"
vim.o.termguicolors = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.o.splitright = true
vim.o.ruler = false
vim.opt.laststatus = 0
vim.o.undofile = true

vim.pack.add({
	"https://github.com/vague-theme/vague.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/ibhagwan/fzf-lua",
	{ src = "https://github.com/Saghen/blink.cmp", version = "v1" },
	"https://github.com/chomosuke/typst-preview.nvim",
})

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	auto_update = true,
	ensure_installed = mason_pkgs,
})
vim.diagnostic.config({ virtual_text = true })
require("nvim-treesitter").install(ts_parsers)
require("treesitter-context").setup({ max_lines = 1 })
require("conform").setup({
	format_on_save = { lsp_format = "fallback", timeout_ms = 500 },
	formatters_by_ft = formatters,
})

require("mini.icons").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.ai").setup()
require("mini.splitjoin").setup()
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
	windows = { preview = true },
	mappings = {
		go_in = "",
		go_in_plus = "l",
		synchronize = "<CR>",
	},
})
vim.keymap.set("n", "<Leader>e", function()
	if not MiniFiles.close() then
		MiniFiles.open(vim.api.nvim_buf_get_name(0))
	end
end)
vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesWindowUpdate",
	callback = function()
		vim.wo.number = true
		vim.wo.relativenumber = true
	end,
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
require("fzf-lua").register_ui_select()
vim.keymap.set("n", "<Leader>s", "<Cmd>FzfLua files<CR>")
vim.keymap.set("n", "<Leader>fh", "<Cmd>FzfLua helptags<CR>")
vim.keymap.set("n", "<Leader>fb", "<Cmd>FzfLua buffers<CR>")
vim.keymap.set("n", "<Leader>fl", "<Cmd>FzfLua live_grep<CR>")
vim.keymap.set("n", "<Leader>ft", "<Cmd>FzfLua diagnostics_document<CR>")
vim.keymap.set("n", "<Leader>fd", "<Cmd>FzfLua lsp_definitions<CR>")
vim.keymap.set("n", "<Leader>fv", "<Cmd>FzfLua lsp_references<CR>")
vim.keymap.set("n", "<Leader>fr", "<Cmd>FzfLua resume<CR>")
vim.keymap.set("n", "<Leader>fa", "<Cmd>FzfLua lsp_code_actions<CR>")

require("blink.cmp").setup({
	completion = {
		menu = {
			scrollbar = false,
			draw = {
				columns = {
					{ "source_name", "label", "label_description", gap = 2 },
					{ "kind_icon", "kind", gap = 2 },
				},
				components = {
					source_name = {
						text = function(ctx)
							return "[" .. ctx.source_name .. "]"
						end,
					},
				},
			},
		},
		documentation = { auto_show = true, auto_show_delay_ms = 0 },
		ghost_text = { enabled = true },
	},
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

local function ts_clean(parsers)
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
	ts_clean(ts_parsers)
	vim.cmd("MasonToolsClean")
end

vim.keymap.set("n", "<Leader>c", clean_all)

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			vim.cmd("TSUpdate")
		end
		if name == "blink.cmp" and kind == "install" or kind == "update" then
			vim.cmd("BlinkCmp build")
		end
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = ts_parsers,
	callback = function()
		vim.treesitter.start()
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
		vim.api.nvim_set_hl(0, "TabLine", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })

		vim.api.nvim_set_hl(0, "FzfLuaBorder", { link = "Comment" })

		vim.defer_fn(function()
			vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "none" })
			vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = "none" })
			vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", {
				fg = vim.api.nvim_get_hl(0, { name = "Constant" }).fg,
				bg = vim.api.nvim_get_hl(0, { name = "CursorLine" }).bg,
			})
			vim.api.nvim_set_hl(
				0,
				"BlinkCmpLabelMatch",
				{ fg = vim.api.nvim_get_hl(0, { name = "String" }).fg, bold = true }
			)
			vim.api.nvim_set_hl(0, "BlinkCmpSource", { link = "Normal" })
			vim.api.nvim_set_hl(0, "BlinkCmpDoc", { link = "Normal" })
			vim.api.nvim_set_hl(0, "BlinkCmpKind", { link = "Comment" })
		end, 200)
	end,
})
vim.cmd("colorscheme vague")
