local bufremove = require("mini.bufremove")
local pin = require("utils.bufpin")

local M = {}

function M.is_protected(bid)
	local protected = {
		"quickfix",
		-- "terminal",
		-- "nofile",
		-- "prompt-buffer",
	}
	for _, buftype in ipairs(protected) do
		if vim.bo[bid].buftype == buftype then
			return true
		end
	end
	return false
end

--- Remove one or many buffers
--- @param action? '"delete"'|'"wipeout"'
--- @param selection? '"all"'|'"current"'|'"others"'|'"left"'|'"right"'|'"unpinned"'
--- @param force boolean?
function M.remove_buffers(action, selection, force)
	action = action or "delete"
	selection = selection or "current"
	force = force or false

	local valid_actions = { delete = true, wipeout = true }
	if not valid_actions[action] then
		vim.notify("Invalid action: " .. action, vim.log.levels.ERROR)
		return
	end

	local valid_selections = { all = true, current = true, others = true, left = true, right = true, unpinned = true }
	if not valid_selections[selection] then
		vim.notify("Invalid selection: " .. selection, vim.log.levels.ERROR)
		return
	end

	local cur = vim.api.nvim_get_current_buf()
	local bufs = vim.api.nvim_list_bufs()

	for _, buf in ipairs(bufs) do
		local delete = selection == "all"
			or (selection == "current" and buf == cur)
			or (selection == "others" and buf ~= cur)
			or (selection == "left" and buf < cur)
			or (selection == "right" and buf > cur)

		if vim.fn.buflisted(buf) == 1 and delete and not pin.is_pinned(buf) and not M.is_protected(buf) then
			bufremove[action](buf, force)
		end
	end
end

function M.bufdelete_cur()
	M.remove_buffers("delete", "current", false)
end
function M.bufdelete_left()
	M.remove_buffers("delete", "left", false)
end
function M.bufdelete_others()
	M.remove_buffers("delete", "others", false)
end
function M.bufdelete_right()
	M.remove_buffers("delete", "right", false)
end
function M.bufwipeout_cur()
	M.remove_buffers("wipeout", "current", true)
end

return M
