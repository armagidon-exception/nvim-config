local module = {}

---Defines a keymap
---@param mode string | table<string>
---@param mapping string
---@param command string | function
---@param opts table?
function module.map(mode, mapping, command, opts)
	opts = opts or {}
	local keymap = vim.keymap
	local dopts = { silent = true, noremap = true }
	keymap.set(mode, mapping, command, vim.tbl_deep_extend("force", dopts, opts))
end

function module.create_mappings(mappings)
    for _, mapping in ipairs(mappings) do
        local mode = mapping.mode or error("Mode is not specified")
        local keys = mapping.keys or error("Keys are not specified")
        local command = mapping.command or error("Command is not specified")
        local dopts = { noremap = true }
        local opts = mapping.opts or {}
        vim.keymap.set(mode, keys, command, vim.tbl_deep_extend("force", dopts, opts))
    end
end

return module
