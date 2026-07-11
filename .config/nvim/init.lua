-- simple nvim config
-- it's not much, because i mainly use emacs.
-- also use yazi, it's good.

local map = vim.keymap.set
local del = vim.keymap.del

vim.g.mapleader = " "
vim.o.guicursor = "a:block"
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.undofile = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.winborder = "solid"
vim.o.showmode = false
vim.o.termguicolors = true
vim.o.swapfile = false
vim.o.cursorline = true
vim.o.ruler = false
vim.o.signcolumn = "yes"

map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("n", "<C-t>", "<C-w>T") -- C-t is used for ctags, which nobody uses anyway

for i = 1, 9 do
    map("n", "<leader>"..i, i.."gt")
end

vim.cmd.packadd "nvim.undotree"
map("n", "<leader>u", "<cmd>Undotree<cr>") -- C-t is used for ctags, which nobody uses anyway

vim.cmd.packadd "cfilter"

vim.cmd.packadd "nohlsearch"
map("n", "<esc>", "<cmd>nohlsearch<cr>") -- C-t is used for ctags, which nobody uses anyway

local Config = {}

Config.add = function(opts)
  local spec = type(opts) == "string" and { src = opts } or opts
  spec.src = "https://github.com/" .. spec.src
  spec.version = spec.version or vim.version.range "*"
  spec.name = spec.name or nil
  vim.pack.add { spec }
end

Config.add {src="Mofiqul/vscode.nvim", version="main"}
vim.cmd.colorscheme "vscode"

Config.add "echasnovski/mini.nvim"
require "mini.icons".setup()

require "mini.pick".setup()
map("n", "<leader>f", "<cmd>Pick files<cr>")
map("n", "<leader>b", "<cmd>Pick buffers<cr>")
map("n", "<leader>g", "<cmd>Pick grep_live<cr>")

require "mini.files".setup{
    mappings = {
      close       = '<C-c>',
      go_in       = nil,
      go_in_plus  = 'l',
      go_out      = nil,
      go_out_plus = 'h',
      synchronize = '<CR>',
    },
    options = { permanent_delete = false },
    windows = {
      preview = true,
      width_preview = 50,
    },
}
map("n", "<C-e>", function() 
    if not MiniFiles.close() then
        MiniFiles.open(vim.api.nvim_buf_get_name(0)) 
    end 
end)

require "mini.completion".setup {}

require "mini.splitjoin".setup {}

require "mini.operators".setup {}

require "mini.comment".setup {}

require "mini.git".setup {}

require "mini.statusline".setup {}

require "mini.ai".setup {}

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
		print("No unused plugins.")
		return
	end

	local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
	if choice == 1 then
		vim.pack.del(unused_plugins)
	end
end

map("n", "<leader>pc", pack_clean)
