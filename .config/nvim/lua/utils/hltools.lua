local M = {}

function M.hl(name)
	return vim.api.nvim_get_hl(0, { name = name, link = false })
end

function M.fg_or_nil(group)
	local value = M.hl(group)
	return value and value.fg or nil
end

return M
