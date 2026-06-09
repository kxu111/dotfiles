local servers = {
	"tree-sitter-cli",
	"lua_ls",
	"stylua",
	"nil",
	"alejandra",
	"clangd",
	"clang-format",
	"rust-analyzer",
	"tinymist",
	"pyright",
	"ruff",
	"svelte-language-server",
	"html",
	"ts_ls",
	"cssls",
}
local formatters = {
	lua = { "stylua" },
	nix = { "alejandra" },
	c = { "clang-format" },
	cpp = { "clang-format" },
	rs = { "rustfmt" },
	typ = { "typstyle" },
	py = { "ruff" },
}

vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/r4ppz/lspeek.nvim",
})

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({ auto_update = true, ensure_installed = servers })

vim.diagnostic.config({
	virtual_text = {
		severity = {
			min = vim.diagnostic.severity.WARN,
		},
	},
	float = {
		header = "",
		border = "single",
	},
	signs = {
		severity = {
			min = vim.diagnostic.severity.WARN,
		},
		text = {
			[vim.diagnostic.severity.ERROR] = "▪",
			[vim.diagnostic.severity.WARN] = "▪",
			[vim.diagnostic.severity.INFO] = "▪",
			[vim.diagnostic.severity.HINT] = "▪",
		},
	},
})

require("conform").setup({
	format_on_save = { lsp_format = "fallback", timeout_ms = 500 },
	formatters_by_ft = formatters,
})

local lspeek = require("lspeek")
lspeek.setup({
	window = {
		border = "single",
	},
})

vim.keymap.set("n", "gd", lspeek.peek_definition)
vim.keymap.set("n", "gT", lspeek.peek_type_definition)
