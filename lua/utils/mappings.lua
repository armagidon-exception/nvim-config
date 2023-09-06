

---Defines a keymap
---@param mode string | table<string>
---@param mapping string
---@param command string | function
---@param opts table
local map = function(mode, mapping, command, opts)
	opts = opts or {}
	local keymap = vim.keymap
	local dopts = { silent = true, noremap = true }
	keymap.set(mode, mapping, command, vim.tbl_deep_extend("force", dopts, opts))
end

return map
