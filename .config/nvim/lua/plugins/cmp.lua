-- i use nvim cmp because noice.nvim breaks mini completion

vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
})

local gen_loader = require("mini.snippets").gen_loader
require("mini.snippets").setup({
	snippets = {
		gen_loader.from_file("~/.config/nvim/snippets/global.json"),
		gen_loader.from_lang(),
	},
})

local cmp = require("cmp")

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
	},
	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			cmp.config.compare.kind,
		},
	},
	completion = {
		autocomplete = {
			require("cmp.types").cmp.TriggerEvent.TextChanged,
		},
	},
	mapping = cmp.mapping.preset.insert({
		-- ["<C-e>"] = cmp.mapping.complete(),
		["<C-y>"] = cmp.mapping.confirm({ select = false }),
	}),
	snippet = {
		expand = function(args)
			local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
			insert({ body = args.body }) -- Insert at cursor
			cmp.resubscribe({ "TextChangedI", "TextChangedP" })
			require("cmp.config").set_onetime({ sources = {} })
		end,
	},
	window = {
		completion = cmp.config.window.bordered({
			border = "single",
		}),
		documentation = cmp.config.window.bordered({
			border = "single",
		}),
	},
})
