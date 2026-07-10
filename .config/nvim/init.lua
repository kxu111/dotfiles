local o = vim.opt
local map = vim.keymap.set
local del = vim.keymap.del

vim.g.mapleader=" "
o.guicursor = "a:block"
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true
o.undofile = true
o.splitright = true
o.splitbelow = true
o.number = true
o.relativenumber = true
o.winborder = "rounded"

local Config = {}

Config.add = function(opts)
  local spec = type(opts) == "string" and { src = opts } or opts
  spec.src = "https://github.com/" .. spec.src
  spec.version = spec.version or vim.version.range "*"
  spec.name = spec.name or nil
  vim.pack.add { spec }
end

Config.add { src = "Mofiqul/vscode.nvim", version = "main" }
require "vscode".setup {
    group_overrides = {
        StatusLine = {bg = "#68217A"}
    }
}
vim.cmd.colorscheme("vscode")

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
