M = {}

local function get_mode_group(mode)
	local groups = {
		n = "n",
		i = "i",
		v = "v",
		V = "v",
		["\22"] = "v",
		c = "c",
		s = "s",
		S = "s",
		[" "] = "s",
		R = "r",
		r = "p",
		rm = "m",
		Rv = "v",
		["r?"] = "c",
		["!"] = "s",
		["t"] = "t",
	}

	local group = groups[mode] or "unknown"

	-- hard coded for completions
	if mode:sub(1, 1) == "i" and vim.fn.pumvisible() == 1 then
		group = "i"
	end

	return group:upper()
end

function M.get_mode_component()
	local mode = vim.api.nvim_get_mode().mode
	return get_mode_group(mode)
end

function M.get_saved_component()
	local saved = vim.bo.modified and "* Pending Changes" or ""

	if vim.bo.filetype == "TelescopePrompt" then
		saved = ""
	end

	return saved
end

return M
